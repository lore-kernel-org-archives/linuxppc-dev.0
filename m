Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7149B70F9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 01:30:28 +1000 (EST)
Subject: Re: [PATCH] powerpc: rename immap_86xx.h to fsl_guts.h, and add
	85xx support
From: Peter Tyser <ptyser@xes-inc.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1279749902-13459-1-git-send-email-timur@freescale.com>
References: <1279749902-13459-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 10:30:17 -0500
Message-ID: <1279812617.7232.8703.camel@petert>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

> +/**
> + * Global Utility Registers.
> + *
> + * Not all registers defined in this structure are available on all chips, so
> + * you are expected to know whether a given register actually exists on your
> + * chip before you access it.
> + *
> + * Also, some registers are similar on different chips but have slightly
> + * different names.  In these cases, one name is chosen to avoid extraneous
> + * #ifdefs.
> + */
> +#ifdef CONFIG_PPC_85xx
> +struct ccsr_guts_85xx {
> +#else
> +struct ccsr_guts_86xx {
> +#endif

Is there a good reason to have 2 different names for the same structure
depending on the architecture?  I'd think keeping a common "ccsr_guts"
name would get rid of the ifdefs above as well as in code that can be
used on both 85xx and 86xx processors down the road.

Best,
Peter
