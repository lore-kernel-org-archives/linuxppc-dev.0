Date: Mon, 29 Mar 1999 15:48:07 -0600 (CST)
From: Dave Weis <djweis@plconline.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: modifying boot loader
Message-ID: <Pine.LNX.3.95.990329154458.29373G-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hello

i'm trying to modify the coffboot loader to produce an object file that
looks like the one below:

Disassembly of section .text:

00000000 <pin_obj_start>:
       0:       00 00 00 00     .long 0x0
       4:       ba df ca 11     lm      r22,-13807(r31)
        ...

00000024 <start>:
      24:       code here..............

What would the magic incantation be? I have modified LD_ARGS in the
makefile to be
LD_ARGS = -e _start -T ld.script -Ttext 0 -Tdata 10000 -Bstatic

which gives me this header

Disassembly of section .text:

00000000 <_start>:
       0:       00 00 00 0c     .long 0xc
        ...

0000000c <__start>:
       c:       3d 20 00 00     liu     r9,0
      10:       3d 00 00 00     liu     r8,0
      14:       39 08 5c a4     cal     r8,23716(r8)
      18:       7c 00 48 ac     .long 0x7c0048ac
      1c:       7c 00 4f ac     .long 0x7c004fac
      20:       39 29 00 20     cal     r9,32(r9)
      24:       28 09 00 08     cmpli   0,r9,8
      28:       41 80 ff f0     blt     18 <__start+0xc>
      2c:       48 00 00 04     b       30 <start>

00000030 <start>:
      30:       7c 2c 0b 78     mr      r12,r1
      34:       38 21 ff e0     cal     r1,-32(r1)


Also, does anyone know off-hand what the two constants at 0x18 and 0x1c
are?

Thanks for any help

djweis

-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231
http://www.plconline.com/ | "Great spirits will always encounter violent
                          | opposition from mediocre minds" - Einstein


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
