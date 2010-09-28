Return-Path: <emrekara2002@yahoo.co.uk>
Received: from n24.bullet.mail.ukl.yahoo.com (n24.bullet.mail.ukl.yahoo.com
	[87.248.110.141]) by ozlabs.org (Postfix) with SMTP id 747EDB7226
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 23:32:27 +1000 (EST)
Message-ID: <864381.11683.qm@web25607.mail.ukl.yahoo.com>
Date: Tue, 28 Sep 2010 13:32:24 +0000 (GMT)
From: emre kara <emrekara2002@yahoo.co.uk>
Subject: powerpc kernel 2.6.35.6 crash with gianfar ethernet at full line rate
	traffic
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

Hi all,=0A=0AI have a serious problem with latest stable kernel (2.6.35.6) =
and gianfar ethernet driver.=0A=0AI'am using default SMP kernel configurati=
on and MPC8572DS development board and also using an hardware packet genera=
tor.=0A=0AMy test is ip forwarding between eth0 and eth1, and Hardware pack=
et generator produces full duplex, full line rate traffic with random packe=
t length and random payload . After 1.2 billion packet passed, kernel produ=
ces this bellow crash message.=0A=0AI have done same test with an intel qua=
d core pc and sky2 gigabit ethernet controller. No errors occured yet. So t=
hat it seems that this problem may be  related with gianfar.=0A=0AAny comme=
nt and help are appreciated.=0A=0A=0A=0AThanks.=0A=0AEmre=0A=0A=0A=0A=0A=0A=
------------[ cut here ]------------=0A=0Akernel BUG at net/core/skbuff.c:1=
27!=0A=0AOops: Exception in kernel mode, sig: 5 [#1]=0A=0ASMP NR_CPUS=3D8 M=
PC8572 DS=0A=0Alast sysfs file: /sys/devices/pci0002:03/0002:03:00.0/subsys=
tem_device=0A=0AModules linked in:=0A=0ANIP: c0255260 LR: c0255260 CTR: c02=
21f64=0A=0AREGS: effebd70 TRAP: 0700   Not tainted  (2.6.35.6)=0A=0AMSR: 00=
029000 <EE,ME,CE>  CR: 24028022  XER: 20000000=0A=0ATASK =3D ef03ce10[3] 'k=
softirqd/0' THREAD: ef04a000 CPU: 0=0A=0AGPR00: c0255260 effebe20 ef03ce10 =
0000007c 00021000 ffffffff c0225ac0 c04364cc=0A=0AGPR08: c042e9ac c04364e0 =
effea000 c0430000 20028048 1001a108 ef550000 ef0f6d70=0A=0AGPR16: ef0f6e18 =
ef0f685c 00000000 ef550800 00000008 00000001 ef0f6800 0000003f=0A=0AGPR24: =
ef141a80 ef0f6b60 00000000 ef550950 ef0f6b60 00000420 ef3f0400 ef525600=0A=
=0ANIP [c0255260] skb_put+0x8c/0x94=0A=0ALR [c0255260] skb_put+0x8c/0x94=0A=
=0ACall Trace:=0A=0A[effebe20] [c0255260] skb_put+0x8c/0x94 (unreliable)=0A=
=0A[effebe30] [c023e004] gfar_clean_rx_ring+0x10c/0x4d8=0A=0A[effebe90] [c0=
23e794] gfar_poll+0x3c4/0x5f4=0A=0A[effebf60] [c0262498] net_rx_action+0xf8=
/0x1a4=0A=0A[effebfa0] [c0049dcc] __do_softirq+0xe0/0x178=0A=0A[effebff0] [=
c0010790] call_do_softirq+0x14/0x24=0A=0A[ef04bf50] [c0004868] do_softirq+0=
x90/0xa0=0A=0A[ef04bf70] [c004a98c] run_ksoftirqd+0xb4/0x164=0A=0A[ef04bfb0=
] [c005dacc] kthread+0x78/0x7c=0A=0A[ef04bff0] [c0010b9c] kernel_thread+0x4=
c/0x68=0A=0AInstruction dump:=0A=0A81030098 2f800000 409e000c 3d20c03d 3809=
e0d8 3c60c03d 7c8802a6 7d695b78=0A=0A3863ee60 90010008 4cc63182 4bdefaa9 <0=
fe00000> 48000000 9421fff0 7c0802a6=0A=0AKernel panic - not syncing: Fatal =
exception in interrupt=0A=0ACall Trace:=0A=0A[effebb20] [c00082fc] show_sta=
ck+0x4c/0x180 (unreliable)=0A=0A[effebb50] [c0043720] panic+0xa0/0x11c=0A=
=0A[effebbe0] [c000db44] die+0x184/0x1d0=0A=0A[effebc10] [c000dcfc] _except=
ion+0x114/0x130=0A=0A[effebd60] [c0011440] ret_from_except_full+0x0/0x4c=0A=
=0A--- Exception: 700 at skb_put+0x8c/0x94=0A=0A    LR =3D skb_put+0x8c/0x9=
4=0A=0A[effebe30] [c023e004] gfar_clean_rx_ring+0x10c/0x4d8=0A=0A[effebe90]=
 [c023e794] gfar_poll+0x3c4/0x5f4=0A=0A[effebf60] [c0262498] net_rx_action+=
0xf8/0x1a4=0A=0A[effebfa0] [c0049dcc] __do_softirq+0xe0/0x178=0A=0A[effebff=
0] [c0010790] call_do_softirq+0x14/0x24=0A=0A[ef04bf50] [c0004868] do_softi=
rq+0x90/0xa0=0A=0A[ef04bf70] [c004a98c] run_ksoftirqd+0xb4/0x164=0A=0A[ef04=
bfb0] [c005dacc] kthread+0x78/0x7c=0A=0A[ef04bff0] [c0010b9c] kernel_thread=
+0x4c/0x68=0A=0ARebooting in 180 seconds..=0A=0A=0A      
