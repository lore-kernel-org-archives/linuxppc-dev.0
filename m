Message-ID: <001c01be857a$bf894020$66f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Help about Kernel Image
Date: Tue, 13 Apr 1999 14:56:20 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, everyone
  I'm building a kernel for Motorola's FADS860 board.
My code base is embedded-2_2p7.tar.gz. When I debug the code,
I find some problems.
In arch/ppc/boot/head.S, line 144, author using following code
to clear the BSS segment:
=======================================
/* Clear all of BSS */
lis r3,edata@h
ori r3,r3,edata@l
lis r4,end@h
ori r4,r4,end@l
subi r3,r3,4
subi r4,r4,4
li r0,0
50: stwu r0,4(r3)
cmp 0,r3,r4
bne 50b
=======================================
But in my binary code of zImage, the kernel image is between "edata" and
"end"
following is symbols list:
***************************************
0010420c A _etext       = 0x104648
00105320 A _edata       = 0x105320
00106008 B zimage_start = 0x106000
0010600c B orig_y
00106010 B zimage_size
00106014 B cols
00106018 B end_avail
0010601c B lines
00111bc0 A _end         = 0x111bc0
***************************************
So, I have two questions:
1. the address of kerenl image is same as some variables, such as
   orig_y, cols and so on.
2. clear the BSS segment, crash the kernel image befrom decompressing it.


Does anyone know why?
Any suggestion is appreciated !
Thanks in advanced!


Best Regards,
Zhu Shuangjun


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
