Content-Type: text/plain;
  charset="iso-8859-1"
From: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Oops: kernel access of bad area, sig: 11
Date: Fri, 16 Nov 2001 13:41:54 +0200
MIME-Version: 1.0
Message-Id: <0111161241540C.28381@jocke.lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

Just pulled bk:linux_ppc_2_4  and ported it our  custom MPC860 board with
128MB RAM. Booted the new kernel and did a compile to test the kernel and
ggc got signal 11 and an Oops( see below).
The same "port" works for Monta Vistas kernel hhl 2.0(based on 2.4.2)

Any ideas what migth be wrong?

         Jocke

[root@jocke 2.4.15-pre4]# ppc_8xx-ksymoops -v vmlinux -a ppc oops1
ksymoops 2.4.1 on i686 2.4.3-12.  Options used
     -v vmlinux (specified)
     -K (default)
     -L (default)
     -O (default)
     -m /opt/hardhat/devkit/ppc/8xx/target/boot/System.map (default)
     -a ppc

Error (regular_file): read_system_map stat
/opt/hardhat/devkit/ppc/8xx/target/boot/System.map failed
ppc_8xx-ksymoops: No such file or directory
Oops: kernel access of bad area, sig: 11
NIP: C0004AFC XER: 00000000 LR: C001D6EC SP: C7259DF0 REGS: c7259d40 TRAP:
0300dUsing defaults from ksymoops -t elf32-little
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c7258000[228] 'cpp0' Last syscall: 108
last math 00000000 last altivec 00000000
GPR00: 00000100 C7259DF0 C7258000 C6FA3000 00000000 C011840C 02000000 1004D57C
GPR08: C0373040 00000000 000006F8 00000000 24022080 100327D0 10030000 00000000
GPR16: 1002FEC0 00000001 00000000 00000004 00009032 07259F40 00000000 C0002988
GPR24: 02000000 C0126AB0 00030002 C725C134 C74E3690 C0126AB0 00112889 C03318C0
Call backtrace:
C001D6DC C001D7CC C001D940 C000986C C0002988 00000023 0FF3249C
10011FC0 100081B4 10007684 100064F4 100041E0 10008320 10007684
100064F4 100041E0 10008320 10007684 100064F4 100041E0 10003464
0FED9DBC 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>???; c0004afc <clear_page+c/28>   <=====
Trace; c001d6dc <do_anonymous_page+50/e4>
Trace; c001d7cc <do_no_page+5c/160>
Trace; c001d940 <handle_mm_fault+70/104>
Trace; c000986c <do_page_fault+194/3d0>
Trace; c0002988 <ret_from_except+0/34>
Trace; 00000023 Before first symbol
Trace; 0ff3249c Before first symbol
Trace; 10011fc0 Before first symbol
Trace; 100081b4 Before first symbol
Trace; 10007684 Before first symbol
Trace; 100064f4 Before first symbol
Trace; 100041e0 Before first symbol
Trace; 10008320 Before first symbol
Trace; 10007684 Before first symbol
Trace; 100064f4 Before first symbol
Trace; 100041e0 Before first symbol
Trace; 10008320 Before first symbol
Trace; 10007684 Before first symbol
Trace; 100064f4 Before first symbol
Trace; 100041e0 Before first symbol
Trace; 10003464 Before first symbol
Trace; 0fed9dbc Before first symbol
Trace; 00000000 Before first symbol

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
