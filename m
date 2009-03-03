Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC06DDDFBD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 04:57:52 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n23HvmK8018177
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 10:57:48 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n23HvlhS002244
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 11:57:47 -0600 (CST)
Date: Tue, 3 Mar 2009 11:57:46 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2] powerpc/83xx: Add power management support for MPC837x
	boards
Message-ID: <20090303175746.GC8692@ld0162-tx32.am.freescale.net>
References: <20090303160201.GA3242@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090303160201.GA3242@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 03, 2009 at 07:02:01PM +0300, Anton Vorontsov wrote:
>  		mdio@24520 {
> @@ -226,6 +244,8 @@
>  			interrupt-parent = <&ipic>;
>  			tbi-handle = <&tbi0>;
>  			phy-handle = <&phy2>;
> +			sleep = <&pmc 0xc0000000>;
> +			fsl,magic-packet;
>  		};

Note that this makes it look to the kernel like enet0 can be put to sleep
without putting the mdio (which is shared with enet1) to sleep.  This is
why I moved mdio under the ethernet node on 8313erdb.

-Scott
