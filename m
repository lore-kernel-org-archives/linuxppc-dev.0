Date: Wed, 25 Aug 2004 18:40:13 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
Cc: v2p@mind.be
MIME-Version: 1.0
Subject: ppc-linux still not booting on my virtexII board
Message-ID: <24181.1093452013@www39.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I traced down the problem a little further. Apparently the machine crashes
on certain memory accesses.

early_init() in arch/ppc/kernel/setup.c calls
memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start) to zero out the BSS
section. I substituted memset_io with my own memset function and found out
that the given parameters are ok, according to the symbol table. I then made
up a "debug memset" like this:

void mymemset(char *ptr, int c, int len)
{
  while (len--) {
    <code that waits for uart rx>
    hexout((int)ptr); // print the current address
    *(ptr++) = c;
  }
}

then I found that the board crashes always at the same address (c00931c0),
that is 0x01c0 bytes in the BSS section (which begins at c0093000).

Then I incremented "ptr" by a fixed offset (0x80) at the beginning of
mymemset(), to find out that the cpu then crashes when writing to the exact
same location c00931c0 (therefore one could think that it depends on the
absolute address, not on the number of bytes written).

Now it's getting weird. Assuming that there is something wrong with the
memory bus or memory controller, I wrote to that address using my
(homegrown) ROM monitor. But that is no problem and I would read back the
correct values from that address. The only difference is that the ROM
monitor uses no MMU (therefore I used 0x000931c0 instead of 0xc00931c0).

One could argue that there is something wrong with the initial MMU, but then
I can't think of a reason why it should happen at such a "odd" address.

Then there is a possibility of cache problems. Someone on this list
suggested that I better flush the caches before booting, using a code
snippet like this:

for(i=0; i<16384; i+=32) {
  asm("dccci 0,%0" :: "r"(i));
}
asm("iccci 0,0");
asm("sync;isync");

Ok, i inserted this code snippet at the beginning of early_init(), and then
BANG! the board crashed immediately.

I reproduced the memset() thing with both the denx kernel tree and the
kernel port for memec V2P eval board, supplied by the kind people at
mind.be.

The kernel versions are 2.4.25 and 2.4.22, respectively. My toolchain is a
powerpc-405-linux-gnu- with gcc version 3.3.2, which I downloaded in binary
form at
http://developer.osdl.org/dev/plm/cross_compile/powerpc-405-linux-gnu.tar.bz2
(I suspect that it's a crosstool generated one).

Perhaps someone who knows this weird processor better than me, can shed some
light? I'm no dumbass when it comes to the low level stuff, but I only know
some ARMs and PICs in this detail and this is my very first PPC project.
Thank you very much.

Regards,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
