Message-ID: <36E43D92.BBA3893B@talknet.de>
Date: Mon, 08 Mar 1999 21:13:54 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Different Relocation Sceme for PREP boot
References: <Pine.LNX.3.96.990307203424.15583A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:
> 
> Please try the latest one.  The one you have isn't the latest one.  Let me
> know if you have the same trouble with it.

Got mine on Saturday from cvs.samba.org.

Seems we both go for the same goal. This change works nearly like mine
did.

I'd like to request two changes:

- Please fix the "tstc()" function using the code from the diff. The way
  it is at the moment, keyboard input to the boot prompt is ignored
  regardless the setting of CONFIG_SERIAL_CONSOLE.

- On comparing the zimage_start address to the 8MByte boundary you had a
  typing error.

The other diff is cosmetics.

Is it always necessary to relocate initrd or can it be reduced to the
case where it is below 8MByte. Do you know of an upper limit in memory
where it can reside?

These changes did boot on MVME2600 and RiscPC both via floppy and net.

______________________________________________________________________

diff -uN  misc.c.cort misc.c
--- misc.c.cort Mon Mar  8 16:03:28 1999
+++ misc.c      Mon Mar  8 21:33:39 1999
@@ -92,9 +92,11 @@

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
@@ -303,8 +305,7 @@
        int timer;
        extern unsigned long start;
        char *cp, ch;
-       unsigned long i, motorola_id = 0;
-       char needs_reloc = 0;
+       unsigned long i;
        BATU *u;
        BATL *l;

@@ -379,7 +380,7 @@
        avail_ram = (char *)PAGE_ALIGN((unsigned long)_end);
        puts("zimage at:     "); puthex((unsigned long)zimage_start);
        puts(" "); puthex((unsigned long)(zimage_size+zimage_start)); puts("\n");
-       if ( (unsigned long)zimage_start <= 0x008000000 )
+       if ( (unsigned long)zimage_start <= 0x00800000 )
        {
                memcpy( (void *)avail_ram, (void *)zimage_start, zimage_size );
                zimage_start = (char *)avail_ram;
@@ -398,10 +399,10 @@
                        (unsigned long)zimage_size+(unsigned long)zimage_start);
                memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
                initrd_start = (unsigned long)avail_ram;
-               initrd_end = initrd_start + INITRD_SIZE;
-               puts("relocated to:  "); puthex(initrd_start);
-               puts(" "); puthex(initrd_end); puts("\n");
-       }
+                       initrd_end = initrd_start + INITRD_SIZE;
+                       puts("relocated to:  "); puthex(initrd_start);
+                       puts(" "); puthex(initrd_end); puts("\n");
+               }

        avail_ram = (char *)0x00400000;
        end_avail = (char *)0x00800000;


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
