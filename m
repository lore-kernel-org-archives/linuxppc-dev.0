Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3826DDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 04:36:35 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2OHaU9D029162
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 10:36:31 -0700 (MST)
Date: Mon, 24 Mar 2008 12:36:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Simplify error handling for unparseable input
Message-ID: <20080324173641.GA22159@loki.buserror.net>
References: <20080324034424.GC29985@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080324034424.GC29985@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 24, 2008 at 02:44:24PM +1100, David Gibson wrote:
> Index: dtc/dtc.h
> ===================================================================
> --- dtc.orig/dtc.h	2008-03-24 14:33:33.000000000 +1100
> +++ dtc/dtc.h	2008-03-24 14:33:34.000000000 +1100
> @@ -232,7 +232,6 @@
>  struct boot_info {
>  	struct reserve_info *reservelist;
>  	struct node *dt;		/* the device tree */
> -	int error;
>  };

If you remove this, there'll be no way to indicate semantic errors other
than die() (the NULL approaches are no good, since they inhibit recovery),
which is suboptimal if the error is not immediately fatal.

-Scott
