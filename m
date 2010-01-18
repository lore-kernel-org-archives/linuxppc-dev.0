Return-Path: <oakad@yahoo.com>
Received: from web37606.mail.mud.yahoo.com (web37606.mail.mud.yahoo.com
	[209.191.87.89]) by ozlabs.org (Postfix) with SMTP id B6B0DB7D3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 19:14:37 +1100 (EST)
Message-ID: <901258.88094.qm@web37606.mail.mud.yahoo.com>
Date: Mon, 18 Jan 2010 00:14:35 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Weird crash of kernel during module loading on mpc8548 based board
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings.=0A=0AI've got a rather weird problem and hope that somebody may =
have encountered=0Ait before.=0A=0AI've got an MPC8548 based board which wa=
s not supported by the=0Au-boot/kernel, but was quite similar to other AMC =
boards of this sort. I=0Apatched up the kernel and stress-tested the board =
quite extensively=0A(essentially, by compiling a whole gentoo distro native=
ly on it, which=0Atook me a couple of weeks :-). Board has a single SODIMM =
with 512 MB=0Amemory installed.=0A=0ANow, I enabled a loadable module suppo=
rt and want to load a small module=0AI'm working on. However, all my attemp=
ts to load the module lead to=0Aimmediate kernel segfault, at precisely the=
 first command of the=0Amodule_init function.=0A=0AI'm working with a git h=
ead version of the kernel (2.6.33-rc4-xx).=0AAll user space functionality w=
orks fine - I'm running a fully featured=0Aworkstation setup on it over nfs=
 root.=0A=0AHere is the debug dump:=0A-bash: HISTORY: PID=3D1731 UID=3D0 mo=
dprobe rio_core=0A[   34.149070] load_module: umod=3D4802f008, len=3D141251=
, uargs=3D1001d160=0A[   34.150198] Core section allocation order:=0A[   34=
.150212]         .text=0A[   34.150217]         .exit.text=0A[   34.150221]=
         .plt=0A[   34.150226]         .note.gnu.build-id=0A[   34.150231] =
        __ksymtab_strings=0A[   34.150236]         .rodata.str1.4=0A[   34.=
150241]         __ksymtab=0A[   34.150246]         __kcrctab=0A[   34.15025=
1]         .data=0A[   34.150256]         .gnu.linkonce.this_module=0A[   3=
4.150261]         .bss=0A[   34.150266] Init section allocation order:=0A[ =
  34.150273]         .init.text=0A[   34.150277]         .init.plt=0A[   34=
.150285]         .symtab=0A[   34.150339]         .strtab=0A[   34.150410] =
final section addresses:=0A[   34.150418]         0xe10ac2f8 .note.gnu.buil=
d-id=0A[   34.150434]         0xe10ab000 .text=0A[   34.150440]         0xe=
10ac1a4 .exit.text=0A[   34.150446]         0xe10b0000 .init.text=0A[   34.=
150453]         0xe10ac31c __ksymtab_strings=0A[   34.150460]         0xe10=
ac37c .rodata.str1.4=0A[   34.150466]         0xe10ac5bc __ksymtab=0A[   34=
.150472]         0xe10ac5ec __kcrctab=0A[   34.150479]         0xe10ac604 .=
data=0A[   34.150486]         0xe10ac728 .gnu.linkonce.this_module=0A[   34=
.150492]         0xe10ac870 .bss=0A[   34.150497]         0xe10ac1a8 .plt=
=0A[   34.150503]         0xe10b0058 .init.plt=0A[   34.150514]         0xe=
10b0068 .symtab=0A[   34.150524]         0xe10b0f08 .strtab=0A[   34.150545=
] kobject: 'rio_core' (e10ac770): kobject_add_internal:=0Aparent: 'module',=
 set: 'module'=0A[   34.150580] Absolute symbol: 0x00000000=0A[   34.150586=
] Absolute symbol: 0x00000000=0A[   34.150593] Absolute symbol: 0x00000000=
=0A[   34.151961] Absolute symbol: 0xb77d8702=0A[   34.152726] Absolute sym=
bol: 0x137e9f0d=0A[   34.152869] Absolute symbol: 0x86125fdb=0A[   34.15342=
8] Absolute symbol: 0xc4a5e8df=0A[   34.153728] Absolute symbol: 0x74e7f0ed=
=0A[   34.153866] Absolute symbol: 0xb45adf12=0A[   34.154328] Failed to fi=
nd symbol rio_free_iface=0A[   34.154676] Failed to find symbol rio_remove_=
iface=0A[   34.155024] Failed to find symbol rio_add_iface=0A[   34.155372]=
 Failed to find symbol rio_alloc_iface=0A[   34.155720] Failed to find symb=
ol copy_toio_be32=0A[   34.156080] Failed to find symbol copy_fromio_be32=
=0A[   34.162175] kobject: 'holders' (df19a700): kobject_add_internal: pare=
nt:=0A'rio_core', set: '<NULL>'=0A[   34.162201] kobject: 'rio_core' (e10ac=
770): kobject_uevent_env=0A[   34.162220] kobject: 'rio_core' (e10ac770): f=
ill_kobj_path: path =3D=0A'/module/rio_core'=0A[   34.163393] kobject: 'not=
es' (df19a540): kobject_add_internal: parent:=0A'rio_core', set: '<NULL>'=
=0A[   34.163457] Unable to handle kernel paging request for instruction fe=
tch=0A[   34.163465] Faulting instruction address: 0xe10b0000=0A[   34.1634=
76] Oops: Kernel access of bad area, sig: 11 [#1]=0A[   34.168864] STX AMC8=
548=0A[   34.171299] Modules linked in: rio_core(+)=0A[   34.175395] NIP: e=
10b0000 LR: c0001dc0 CTR: e10b0000=0A[   34.180349] REGS: df1b1e50 TRAP: 04=
00   Not tainted  (2.6.33-rc4-00193-=0Agd1e4922-dirty)=0A[   34.188248] MSR=
: 00029000 <EE,ME,CE>  CR: 24022482  XER: 00000000=0A[   34.194360] TASK =
=3D dfa4d2c0[1736] 'modprobe' THREAD: df1b0000=0A[   34.199918] GPR00: 0000=
0000 df1b1f00 dfa4d2c0 e10b0000 00000001 e10ac728=0Affffffff 00000000=0A[  =
 34.208295] GPR08: 0000002c df1b0000 c0bfd000 0000006c 00000005 10024204=0A=
1ffebe00 1001c598=0A[   34.216672] GPR16: 00000000 00000000 00000003 1001d5=
74 00000000 10005b10=0A00000000 00000000=0A[   34.225049] GPR24: 1001d428 0=
0000000 000227c3 1001d160 c04a6c80 c04a6c8c=0A000000000 e10b0000=0A[   34.2=
33636] NIP [e10b0000] rio_init+0x0/0x68 [rio_core]=0A[   34.238856] LR [c00=
01dc0] do_one_initcall+0x74/0x220=0A[   34.243807] Call Trace:=0A[   34.246=
253] [df1b1f20] [c00617ec] sys_init_module+0xf4/0x250=0A[   34.251912] [df1=
b1f40] [c000fa18] ret_from_syscall+0x0/0x3c=0A[   34.257473] Instruction du=
mp:=0A[   34.260434] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=
=0AXXXXXXXX XXXXXXXX=0A[   34.268197] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <=
9421fff0> 3c60e10b=0A7c0802a6 3863c37c=0A[   34.276187] ---[ end trace 72ab=
109d9f179c15 ]---=0A=0A=0A=0A=0A      _____________________________________=
_____________________________________________=0ASee what's on at the movies=
 in your area. Find out now: http://au.movies.yahoo.com/session-times/
