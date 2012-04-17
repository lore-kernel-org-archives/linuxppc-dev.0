Return-Path: <r58472@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE0F4B7060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 19:51:21 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Zhao Chenhui-B35336
 <B35336@freescale.com>
Subject: RE: [PATCH v4 1/4] powerpc/85xx: add HOTPLUG_CPU support
Date: Tue, 17 Apr 2012 09:51:11 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F092D1098@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1331889732-25240-1-git-send-email-chenhui.zhao@freescale.com>
 <4F8C78B3.1070002@freescale.com>
In-Reply-To: <4F8C78B3.1070002@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >  struct smp_ops_t smp_85xx_ops =3D {
> >  	.kick_cpu =3D smp_85xx_kick_cpu,
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	.cpu_disable	=3D generic_cpu_disable,
> > +	.cpu_die	=3D generic_cpu_die,
> > +#endif
> >  	.give_timebase	=3D smp_generic_give_timebase,
> >  	.take_timebase	=3D smp_generic_take_timebase,
> > -#endif
> >  };
>=20
> We need to stop using smp_generic_give/take_timebase, not expand its use.
> This stuff breaks under hypervisors where timebase can't be written.  It
> wasn't too bad before since we generally didn't enable CONFIG_KEXEC, but
> we're more likely to want CONFIG_HOTPLUG_CPU.

I understand that the guest OS shouldn't change the real timebase.  But no =
matter what timebase syncing method we are using, the timebase need to be c=
hanged anyway for certain features.  I think the better way should be trapp=
ing timebase modification in the hypervisor.

>=20
> Do the timebase sync the way U-Boot does -- if you find the appropriate
> guts node in the device tree.

That involves stopping timebase for a short time on all cores including the=
 cores that are still online.  Won't this be a potential issue?

- Leo=20
