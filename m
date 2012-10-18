Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CCDAF2C0096
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 06:03:58 +1100 (EST)
Message-ID: <1350587006.2476.12.camel@pasglop>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Berger <robert.karl.berger@gmail.com>
Date: Fri, 19 Oct 2012 06:03:26 +1100
In-Reply-To: <50804020.30505@gmail.com>
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, mla@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-10-18 at 20:45 +0300, Robert Berger wrote:
> -       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH addr */
> -       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low addr */
> +       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
> +       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> +
>  
>         msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> -       if (!msi->msi_dev)
> +       if (msi->msi_dev)
>                 return -ENODEV; 

The above changes look bad. The first one is stupid, the second one is clearly broken.

The diff us from good to bad right ? Looks like somebody added a very busted patch.

If I look at the code in current upstream, I see:

	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */

	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
	if (!msi->msi_dev)
		return -ENODEV;


Which looks correct. So this might be something specific to ELDK ?

Cheers,
Ben.
