Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AA53CB7BA2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:08:39 +1100 (EST)
Date: Thu, 5 Nov 2009 17:08:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Message-ID: <20091105140838.GA17171@oksana.dev.rtsoft.ru>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214359.GE24821@oksana.dev.rtsoft.ru>
	<197B3989-3373-4172-B5FA-727CA1EEE2AA@kernel.crashing.org>
	<AFE1C29A-88D4-4A1D-B7AD-A797CCC855D3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AFE1C29A-88D4-4A1D-B7AD-A797CCC855D3@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 08:02:44AM -0600, Kumar Gala wrote:
[...]
> >diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/
> >boot/dts/mpc8568mds.dts
> >index 00c2bbd..6d892ba 100644
> >--- a/arch/powerpc/boot/dts/mpc8568mds.dts
> >+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> >@@ -40,6 +40,8 @@
> >			i-cache-line-size = <32>;	// 32 bytes
> >			d-cache-size = <0x8000>;		// L1, 32K
> >			i-cache-size = <0x8000>;		// L1, 32K
> >+			sleep = <&pmc 0x00008000	// core
> >+				 &pmc 0x00004000>;	// timebase
> >
> >Just so I'm clear this is the devdisr bit position?
> 
> Also where in the code do we use this?  I'm not seeing it.

We don't use it (yet). The per-device power management is not yet
implemented. It is relatively easy to do on 83xx, but on 85xx there
is a restriction: we can't re-enable the device after we disable it,
i.e. POR sequence is needed. Though, we may want to disable all
'unused' (say echo 1 > /sys/devices/.../permanently_disable) to save
some power.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
