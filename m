Message-ID: <36E2DD73.2D98E9EF@talknet.de>
Date: Sun, 07 Mar 1999 20:11:31 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Different Relocation Sceme for PREP boot
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The latest versions of the PREP boot code does not work for Motorola
RiscPC (Blackhawk). The problem can be seen on the following output:

Residual-Data Located at: $01FC0000
loaded at:     01F0B400 01F20FD0
relocated to:  00600000 00615BD0
board data at: 01FC0000 01FC6A0C
relocated to:  0060F0C0 00615ACC
zimage at:     01F15400 01FAD0F4
relocated to:  01F28000 01FBFCF4
avail ram:     00400000 00600000

Linux/PPC load: console=ttyS0,9600n8
Uncompressing Linux...inflate returned %d
exit       

Obviously zimage is going to be shifted up in memory but the locations
overlap. As the current memcpy code does not handle overlaped locations
this will destroy zimage. One could think to fix memcpy but than the
relocation fails on initrd (if used).
The location 0xfef80400 is not implemented on every type of hardware and
one can not predict what is returned on reading it.

I belive that zimage and initrd needs relocation only if loaded below
the start of the bootloader (at 0x600000). All this locations
potentially
conflict with the space where linux is written to resp. which is needed
to decompress.
If relocation is necessary the current code tries to move zimage and
initrd somewhere to the high addresses in memory. I think relocating to
the end of the bootloader is a much better choice as it is simple and
predictable.

I think this change could fix problems with booting PREP but it needs to
be tested on more hardware than I have. For me it works on a Motorola
RiscPC with pboot from floppy and over the network (prep mode). Below
is the output from the network boot:

loaded at:     00005400 0001AFD0
relocated to:  00600000 00615BD0
board data at: 01F79000 01F7FA0C
relocated to:  0060F0C0 00615ACC
zimage at:     0000F400 000A70F4
relocated to:  00616000 006ADCF4
avail ram:     00400000 00600000

Linux/PPC load: console=tty0
Uncompressing Linux...done.

Here is the diff against version $Id: misc.c,v 1.57 1999/03/03 14:54:16
for arch/ppc/boot/misc.c
________________________________________________________________________

diff -uN  misc.c.org  misc.c
--- misc.c.org  Sun Mar  7 11:31:32 1999
+++ misc.c      Sun Mar  7 19:19:00 1999
@@ -91,9 +91,11 @@

 tstc(void)
 {
+       return (
 #if defined(CONFIG_SERIAL_CONSOLE)
-       return (NS16550_tstc(com_port));
+               NS16550_tstc(com_port) ||
 #endif /* CONFIG_SERIAL_CONSOLE */
+               CRT_tstc());
 }

 getc(void)
@@ -302,8 +304,7 @@
        int timer;
        extern unsigned long start;
        char *cp, ch;
-       unsigned long i, motorola_id = 0;
-       char needs_reloc = 0;
+       unsigned long i;
        BATU *u;
        BATL *l;

@@ -402,17 +403,12 @@
         * so use that as an indicator.  -- Dan
         */

-       /* Determine if we have a Motorola board */
-       motorola_id = *(unsigned long *)0xfef80400 >> 24;
-       if ((motorola_id > 0xfa) || (motorola_id < 0xff))
-               needs_reloc = 1;
-       if ( (( (unsigned long)zimage_start <= 0x01000000 ) &&
initrd_start)
-               || needs_reloc)
-       {
-               memcpy ((void *)PAGE_ALIGN(-PAGE_SIZE+(unsigned
long)end_avail-zimage_size),
+       avail_ram = (char *)((unsigned long)&start+(num_words*4));
+       if ( (unsigned long)zimage_start < (unsigned long)&start )  {
+               memcpy ((void *)PAGE_ALIGN((unsigned long)avail_ram),
                        (void *)zimage_start, zimage_size );
-               zimage_start = (char *)PAGE_ALIGN(-PAGE_SIZE+(unsigned
long)end_avail-zimage_size);
-               end_avail = (char *)zimage_start;
+               zimage_start = (char *)PAGE_ALIGN((unsigned
long)avail_ram);
+               avail_ram = (char *)zimage_start + zimage_size;
                puts("relocated to:  "); puthex((unsigned
long)zimage_start);
                puts(" ");
                puthex((unsigned long)zimage_size+(unsigned
long)zimage_start);
@@ -430,16 +426,12 @@
                 * max ram is.
                 * -- Cort
                 */
-               if (needs_reloc)
-               {
-                       memcpy ((void *)PAGE_ALIGN(-PAGE_SIZE+
-                               (unsigned long)end_avail-INITRD_SIZE),
-                               (void *)initrd_start,
-                               INITRD_SIZE );
-                       initrd_start = PAGE_ALIGN(-PAGE_SIZE+
-                               (unsigned long)end_avail-INITRD_SIZE);
+               if ( (unsigned long)initrd_start < (unsigned long)&start
)  {
+                       memcpy ((void *)PAGE_ALIGN((unsigned
long)avail_ram),
+                               (void *)initrd_start, INITRD_SIZE );
+                       initrd_start = PAGE_ALIGN((unsigned
long)avail_ram);
                        initrd_end = initrd_start + INITRD_SIZE;
-                       end_avail = (char *)initrd_start;
+                       avail_ram = (char *)initrd_start + INITRD_SIZE;
                        puts("relocated to:  "); puthex(initrd_start);
                        puts(" "); puthex(initrd_end); puts("\n");
                }


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
