Message-Id: <4.2.0.32.19990420164347.03650340@mail.lauterbach.com>
Date: Tue, 20 Apr 1999 16:49:40 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Current egcs, binutils and kernel (fwd)
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.10.9904201339320.26859-100000@mercator.cs.kuleu
 ven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 13:39 20.04.99 , Geert Uytterhoeven wrote:

>---------- Forwarded message ----------
>Date: Tue, 20 Apr 1999 13:15:41 +0200
>From: Reinhard Nissl <rnissl@gmx.de>
>To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
>Cc: "linux-apus@sunsite.auc.dk" <linux-apus@sunsite.auc.dk>
>Subject: Re: Current egcs, binutils and kernel
>
>Hi,
>
>Geert Uytterhoeven wrote:
>
>> On Wed, 14 Apr 1999, Reinhard Nissl wrote:
>> > has anyone had success in compiling (egcs-1.1.2 and binutils-2.9.1.0.23)
>> > the current APUS kernel with support for network block devices (nbd.c)?
>> >
>> > I get an undefined reference to __lshrdi3 from nbd_ioctl(), which looks
>> > like a compiler / binutils bug.
>>
>> Hence a __lshrdi3() routine needs to be added to arch/ppc/kernel/misc.S.
>
>I had a look into misc.S and found similar routines (__ashrdi3) there. Then I
>searched in the egcs-1.1.2 sources for files, where such functions are
>referenced. I found definitions in egcs-1.1.2/gcc/config/rs6000/rs6000.md but
>they are not native ppc assembler instructions. As I'm not that much used to
>*.md files and ppc assembly code, I'm currently not able to define the missing
>function in misc.S myself.
>
>I checked the kernel source diffs from version 2.2.4 to 2.2.6 for lshrdi3 and
>had only success for arch=sparc. So, is there anybody who can add the missing
>function to misc.S for arch=ppc?


objdump -D libgcc.a shows:

_lshrdi3.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <__lshrdi3>:
   0:   7c a5 2b 79     mr.     r5,r5
   4:   4d 82 00 20     beqlr
   8:   20 05 00 20     subfic  r0,r5,32
   c:   2c 00 00 00     cmpwi   r0,0
  10:   41 81 00 14     bgt     24 <__lshrdi3+0x24>
  14:   7c 00 00 d0     neg     r0,r0
  18:   39 60 00 00     li      r11,0
  1c:   7c 6c 04 30     srw     r12,r3,r0
  20:   48 00 00 14     b       34 <__lshrdi3+0x34>
  24:   7c 89 2c 30     srw     r9,r4,r5
  28:   7c 60 00 30     slw     r0,r3,r0
  2c:   7c 6b 2c 30     srw     r11,r3,r5
  30:   7d 2c 03 78     or      r12,r9,r0
  34:   7d 63 5b 78     mr      r3,r11
  38:   7d 84 63 78     mr      r4,r12
  3c:   4e 80 00 20     blr

__lshrdi3 is a logical right shift (0 is shifted in from the left, whereas 
__ashrdi3 arithmetic right shift shifts in the sign bit) on a 64-bit 
quantitity. You could also use the example code in Appendix E of the PPC601 
manual.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
