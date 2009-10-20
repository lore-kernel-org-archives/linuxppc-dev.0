Return-Path: <richard.cochran@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1191BB7B7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Oct 2009 21:01:30 +1100 (EST)
From: Richard Cochran <richard.cochran@omicron.at>
To: "'Scott Wood'" <scottwood@freescale.com>
Date: Tue, 20 Oct 2009 12:01:19 +0200
Subject: RE: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E30E2AECFD@alice.at.omicron.at>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
	<20091014152722.GA17867@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
	<20091015162728.GB3730@loki.buserror.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE800@alice.at.omicron.at>
	<20091016160125.GC11838@loki.buserror.net>
In-Reply-To: <20091016160125.GC11838@loki.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
>
> What problems have you been having with upstream kernels on mpc8313erdb,
> other than this IRQ issue?  It should work, though the BSP may have extra
> features that haven't been pushed upstream.

I have been working from kernel 2.6.30 (although the very latest
kernel is just the same WRT these problems, AFAICT). I had to patch in
order to sovle the following three problems:

1. The flash layout in the DTS does not match the default partitioning
   from Freescale. In the current dts, the NAND partitioning is wrong,
   and there is no partitioning for the NOR flash given.

2. The eTSEC interrupt issue that started this thread.

3. The PTP IO signals are not configured in a vanilla linux. For this,
   you need parts of a Freescale patch. [1] Their PTP implementation
   gianfar driver is horrible, but still, the IO configuration in
   these two files in the patch is necessary to get any external
   signals from the PTP clock:

   arch/powerpc/platforms/83xx/mpc8313_rdb.c
   arch/powerpc/platforms/83xx/mpc83xx.h

It may be that point 1 is not so important, since the flash layout is
perhaps a very personal thing, but I would still expect the default
dts to match the default partitioning from Freescale.

Point 2 is obviously essential, and if you buy the mpc8313 for its PTP
capabilities, as I did, then point 3 is a show stopper, as well.

> I just booted 2.6.32-rc4 straight from Linus on an mpc8572ds yesterday.
> I've booted various upstream kernels on mpc8313erdb (typically an older r=
ev,
> though).

Okay, you are right, the mpc8572ds does seem to work pretty well.

Perhaps we can fix up the above three issues?

Richard

[1] http://www.bitshrine.org/gpp_info/linux-fsl-2.6.23-MPC8313ERDB-IEEE-158=
8.patch.html
