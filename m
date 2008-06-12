Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 098EBDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:54:09 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so407603yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 06:54:08 -0700 (PDT)
Message-ID: <fa686aa40806120654t4100745ay8b132c68b1bbac86@mail.gmail.com>
Date: Thu, 12 Jun 2008 07:54:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB to current head
In-Reply-To: <200806121345.52293.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806121344.26883.david.jander@protonic.nl>
	<200806121345.52293.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 5:45 AM, David Jander <david.jander@protonic.nl> wrote:
>
>
>  /* write */
> -#define CBDW_SC(_cbd, _sc)             __cbd_out16(&(_cbd)->cbd_sc, (_sc))
> -#define CBDW_DATLEN(_cbd, _datlen)     __cbd_out16(&(_cbd)->cbd_datlen, (_datlen))
> -#define CBDW_BUFADDR(_cbd, _bufaddr)   __cbd_out32(&(_cbd)->cbd_bufaddr, (_bufaddr))
> +#define CBDW_SC(_cbd, _sc)             __cbd_out16((volatile void __iomem *)&(_cbd)->cbd_sc, (_sc))
> +#define CBDW_DATLEN(_cbd, _datlen)     __cbd_out16((volatile void __iomem *)&(_cbd)->cbd_datlen, (_datlen))
> +#define CBDW_BUFADDR(_cbd, _bufaddr)   __cbd_out32((volatile void __iomem *)&(_cbd)->cbd_bufaddr, (_bufaddr))
>
>  /* read */
> -#define CBDR_SC(_cbd)                  __cbd_in16(&(_cbd)->cbd_sc)
> -#define CBDR_DATLEN(_cbd)              __cbd_in16(&(_cbd)->cbd_datlen)
> -#define CBDR_BUFADDR(_cbd)             __cbd_in32(&(_cbd)->cbd_bufaddr)
> +#define CBDR_SC(_cbd)                  __cbd_in16((volatile void __iomem *)&(_cbd)->cbd_sc)
> +#define CBDR_DATLEN(_cbd)              __cbd_in16((volatile void __iomem *)&(_cbd)->cbd_datlen)
> +#define CBDR_BUFADDR(_cbd)             __cbd_in32((volatile void __iomem *)&(_cbd)->cbd_bufaddr)

Another comment: This really doesn't look right.  The _cbd pointer
passed in should already be tagged with __iomem.  Trying to fix it
here is a band-aid and unsafe.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
