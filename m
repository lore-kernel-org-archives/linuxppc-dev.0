Message-ID: <3BB8B3AC.3A97D7D@comdev.cc>
Date: Mon, 01 Oct 2001 11:19:24 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Subject: crash in fault.c
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


(apologies for the previous blank message)

I get this randomly and frequently, usually when booting, attempting to
ftp
to the box, or occasionally when starting a new process.

Any hints or clues are appreciated.

I'm using kernel 2.4.4 running on a custom 8260 based board.


Oops: Exception in kernel mode, sig: 4
NIP: C000BE80 XER: 00000000 LR: C0003DC4 SP: C3D5FDC0 REGS: c3d5fd10
TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3d5e000[1] 'init' Last syscall: 13
last math c3d5e000 last altivec 00000000
GPR00: 00000400 C3D5FDC0 C3D5E000 C3D5FE80 0FF2FF1C 2000F932 1004CDE8
0FFDD688
GPR08: 0FFDE2D8 1004CDE8 00001000 7FFFF3C0 48444888 1004BB08 03FDF000
007FFF16
GPR16: 00000000 007FFF00 007FFEB0 03FD824C 00009032 03D5FE70 00000000
C0003DC4
GPR24: C000BE48 00000000 00030001 2000F932 C3D5FE80 0FF2FF1C 0FFE8248
C01270A0
Call backtrace:
C000BFD8 C0003DC4 0FF25DD0 0FF5B820 0FF5A56C 0FF5B47C 0FF57ED0
0FF8C440 0FF8C270 1000E1F4 1000E658 1000F30C 10027810 1002748C
0FEDC068 00000000
Kernel panic: Attempted to kill init!

>From System.map ...

closest to c000be80 :: c000be48 T do_page_fault     (plus 56 of 904)
closest to c000bfd8 :: c000be48 T do_page_fault     (plus 400 of 904)
closest to c0003dc4 :: c0003dc4 T ret_from_except     (plus 0 of 40)

>From arch/ppc/mm/fault.lst  ...

  78:fault.c       ****         if (regs->trap == 0x400)
 967                    .stabn 68,0,78,.LM3-do_page_fault
 968                    .LM3:
 969 0018 801C00A0      lwz 0,160(28)
 970                    .stabn 68,0,66,.LM4-do_page_fault
 971                    .LM4:
 972 001c 3F400003      lis 26,0x3
 973                    .stabn 68,0,62,.LM5-do_page_fault
 974                    .LM5:
 975 0020 7C9D2378      mr 29,4
 976                    .stabn 68,0,78,.LM6-do_page_fault
 977                    .LM6:
 978 0024 2C000400      cmpwi 0,0,1024
 979                    .stabn 68,0,62,.LM7-do_page_fault
 980                    .LM7:
 981 0028 7CBB2B78      mr 27,5
 982                    .stabn 68,0,66,.LM8-do_page_fault
 983                    .LM8:
 984 002c 635A0001      ori 26,26,1
 985                    .stabn 68,0,70,.LM9-do_page_fault
 986                    .LM9:
 987 0030 3B200000      li 25,0
 988                    .stabn 68,0,78,.LM10-do_page_fault
 989                    .LM10:
 990 0034 4082000C      bc 4,2,.L868
  79:fault.c       ****                 error_code &= 0x48200000;
 991                    .stabn 68,0,79,.LM11-do_page_fault
 992                    .LM11:
 993 0038 777B4820      andis. 27,27,0x4820
 994 003c 48000008      b .L869
 995                    .L868:
  80:fault.c       ****         else
  81:fault.c       ****                 is_write = error_code &
0x02000000;
 996                    .stabn 68,0,81,.LM12-do_page_fault
 997                    .LM12:
 998 0040 5779018C      rlwinm 25,27,0,6,6
 999                    .L869:

And some more...


 149:fault.c       ****         switch (handle_mm_fault(mm, vma,
address, is_write)) {
 1200                   .stabn 68,0,149,.LM53-do_page_fault
 1201                   .LM53:
 1202 017c 7C641B78     mr 4,3
 1203 0180 7F26CB78     mr 6,25
 1204 0184 7FE3FB78     mr 3,31
 1205 0188 7FA5EB78     mr 5,29
 1206 018c 48000001     bl handle_mm_fault
 1207 0190 2C030001     cmpwi 0,3,1
 1208 0194 41820020     bc 12,2,.L898
 1209 0198 41810010     bc 12,1,.L905
 1210 019c 2C030000     cmpwi 0,3,0
 1211 01a0 4182015C     bc 12,2,.L901
 1212 01a4 480000F4     b .L903
 1213                   .L905:
 1214 01a8 2C030002     cmpwi 0,3,2
 1215 01ac 41820018     bc 12,2,.L899
 1216 01b0 480000E8     b .L903
 1217                   .L898:
 150:fault.c       ****         case 1:
 151:fault.c       ****                 current->min_flt++;
 1218                   .stabn 68,0,151,.LM54-do_page_fault
 1219                   .LM54:
 1220 01b4 81220104     lwz 9,260(2)
 1221 01b8 39290001     addi 9,9,1
 1222 01bc 91220104     stw 9,260(2)
 152:fault.c       ****                 break;


--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
