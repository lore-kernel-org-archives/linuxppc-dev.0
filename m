Return-Path: <jhautbois@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8B8D1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 00:11:30 +1100 (EST)
Received: by yws5 with SMTP id 5so1569254yws.15
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Dec 2010 05:11:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=vd4J8DfnLgPROrNC2Q-jxSCsrv=nv371Rhq5i@mail.gmail.com>
References: <AANLkTi=vd4J8DfnLgPROrNC2Q-jxSCsrv=nv371Rhq5i@mail.gmail.com>
Date: Wed, 15 Dec 2010 14:11:25 +0100
Message-ID: <AANLkTikJFCvSQana-x9xCwSfOELdQXApd=kYyZX5OpF2@mail.gmail.com>
Subject: Unbalanced enable for IRQ => phy_change
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi !

I am currently using a MPC8548 PowerPC board, and I have encountered
the following problem :
[ =C2=A0 19.867849] Unbalanced enable for IRQ 48
[ =C2=A0 19.867855] ------------[ cut here ]------------
[ =C2=A0 19.873819] Badness at /.../kernel/irq/manage.c:174
[ =C2=A0 19.873823] NIP: c0044acc LR: c0044acc CTR: c0018480
[ =C2=A0 19.873828] REGS: dfc2be60 TRAP: 0700 =C2=A0 Tainted: P
(2.6.24.7_www.men.de_1.1)
[ =C2=A0 19.873831] MSR: 00021000 <ME> =C2=A0CR: 24000022 =C2=A0XER: 000000=
00
[ =C2=A0 19.873839] TASK =3D dfc204e0[5] 'events/0' THREAD: dfc2a000
[ =C2=A0 19.873842] GPR00: c0044acc dfc2bf10 dfc204e0 0000002f 00021000
00000000 00000000 00000000
[ =C2=A0 19.873854] GPR08: 00000034 ffffffff 0000574e de821b20 24000024
100607bc 00008000 00001020
[ =C2=A0 19.873865] GPR16: c0447b44 c0447b2c 00fff018 033327d2 00000008
c044b2c8 c048d1a8 c044b300
[ =C2=A0 19.873877] GPR24: dfc206a0 dfc204e0 dfc01f30 dfc2a000 00029000
c04cb714 00000030 c04cb6e4
[ =C2=A0 19.873890] NIP [c0044acc] enable_irq+0x6c/0xdc
[ =C2=A0 19.873903] LR [c0044acc] enable_irq+0x6c/0xdc
[ =C2=A0 19.873908] Call Trace:
[ =C2=A0 19.873911] [dfc2bf10] [c0044acc] enable_irq+0x6c/0xdc (unreliable)
[ =C2=A0 19.873919] [dfc2bf30] [c0217868] phy_change+0x74/0xe4
[ =C2=A0 19.873926] [dfc2bf50] [c002fb2c] run_workqueue+0xc4/0x15c
[ =C2=A0 19.873933] [dfc2bf90] [c002ffb0] worker_thread+0x74/0xd4
[ =C2=A0 19.873940] [dfc2bfd0] [c0034360] kthread+0x48/0x84
[ =C2=A0 19.873946] [dfc2bff0] [c00047bc] kernel_thread+0x44/0x60
[ =C2=A0 19.873953] Instruction dump:
[ =C2=A0 19.873957] 7fe04a14 3bbf0030 7fa3eb78 483a9461 813f001c 7c7c1b78
2f890000 409e0038
[ =C2=A0 19.873968] 3c60c045 7fc4f378 3863f1d4 4bfd9129 <0fe00000> 7fa3eb78
7f84e378 483a91a5


When looking at the phy_change function in drivers/net/phy/phy.c I
have noticed something quite strange :
We are calling phy_disable_interrupts() and after some operations, enable_i=
rq().
The first thing I thought about is why aren't we calling
disable_irq/enable_irq or phy_disable_interrupts/phy_enable_interrupts
but a mix ?

Next, I took a more deep look at phy_disable_interrupts() and
sepcifically at the phy_config_interrupt() function :

=C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;

=C2=A0 =C2=A0 =C2=A0 =C2=A0phydev->interrupts =3D interrupts;
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (phydev->drv->config_intr)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D phydev->drv-=
>config_intr(phydev);

=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;

If phydev->drv->config_intr is not implemented (this is my use case :
I am using the drivers/net/gianfar.c driver), then, nothing will be
done, and there is no disable_irq() call.

I don't know what is better : using disable_irq/enable_irq or the phy
specific functions, but I think that we should avoid using a mix...
Am I wrong ?

Thanks in advance,
Regards,
JM
