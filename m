Message-ID: <004e01bff2ef$fb03d0a0$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: How to use ppcbug to debug my program with mmu?
Date: Fri, 21 Jul 2000 16:45:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:
   I am using MVME2600 SBC and I want to debug my program under PPCbug.
According the PPCbug Firmware Package User's Manual chapter 2, a program
with mmu enable should be debugged using PPCbug if some rules are obeyed.
   Those address ranges
         0x0 -- 0x0fffffff,
         0x10000000 -- 0x1fffffff ,
         0xe0000000 -- 0xefffffff,
         0xf0000000 -- 0xffffffff
   have been mapped from physical address to logical address 1 to 1 using
BAT mothed .  Exception vectors 0x100 , 0x700, 0xc00, 0x2000 and spr272,
spr273, spr274, spr275 are not being used.
   I write the code like this under ppcbug at address 0x40000:
          1.     initial all the BAT register
          2.     isync
          3.     msr | 0x30  ==> msr    # open the mmu
          4.     do sth. else
    But it always not come back to PPC1-bug> status after I use command
'T'to singlestep run step 3.
    I also used the mothed like this :
          1.     initial all the BAT register
          2.     isync
          3.     msr | 0x30  ==> srr1    # open the mmu
          4.     logical address of 6. => srr0
          5.     rfi
          6.     do sth. else
    The same error happened when singlestep 5.

   Can this code be debugged under ppcbug? If can , how?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
