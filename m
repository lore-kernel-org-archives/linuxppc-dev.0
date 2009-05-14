Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E295DE02B
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 02:04:03 +1000 (EST)
Message-ID: <4A0C40D4.1090508@freescale.com>
Date: Thu, 14 May 2009 11:03:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
	<fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
In-Reply-To: <fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> This version looks good to me.  Who's the first user? (I'd like to see
> that something is ready to use this before merging it)

I was going to do it the other way around - wait until this patch is merged, and then update some code to use it.  After all, it's easier to use a macro if it already exists in a header file. :-)

Grepping for "while.*in_be" finds lots of candidates.

I was originally planning to use this macro in sound/soc/fsl/fsl_ssi.c, but I eliminated the need to poll on a register with commit a4d11fe50c238a7da5225d1399314c3505cbd792 ("ASoC: remove trigger delay in Freescale MPC8610 sound driver").  So now I need to find a new guinea pig.

-- 
Timur Tabi
Linux kernel developer at Freescale
