Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BDCF2C00A7
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 08:41:23 +1000 (EST)
Received: from mail9-db9 (localhost [127.0.0.1])	by mail9-db9-R.bigfish.com
 (Postfix) with ESMTP id 8E03EC80173	for <linuxppc-dev@ozlabs.org>; Mon, 22
 Jul 2013 22:41:19 +0000 (UTC)
Received: from DB9EHSMHS010.bigfish.com (unknown [10.174.16.231])	by
 mail9-db9.bigfish.com (Postfix) with ESMTP id 19D73920046	for
 <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 22:41:17 +0000 (UTC)
Date: Mon, 22 Jul 2013 17:41:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Po Liu <po.liu@freescale.com>
Subject: Re: [1/4] powerpc/85xx: Add SEC6.0 device tree
Message-ID: <20130722224110.GA26221@home.buserror.net>
References: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 09:54:14AM +0800, Po Liu wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
> 
> Add device tree for SEC 6.0 used on C29x silicon.
> 
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Singed-off-by: Po Liu <Po.Liu@freescale.com>

I've heard of patches being flamed, but here we want signing, not
singeing. :-)

Don't forget that you can use the -s option to have git add the signoff
for you.

> ---
> Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git

This URL is not accessible outside Freescale, so don't reference it when
posting patches publicly.

If your patch is against the latest upstream code, you don't need to say
anything special about that.  You only need to make a note when it's
against some other yet-to-be-merged tree or patch.

> +	compatible = "fsl,sec-v6.0", "fsl,sec-v5.2",
> +		     "fsl,sec-v5.0", "fsl,sec-v4.4",
> +		     "fsl,sec-v4.0";
> +	fsl,sec-era = <6>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	jr@1000 {
> +		compatible = "fsl,sec-v6.0-job-ring",
> +			     "fsl,sec-v5.2-job-ring",
> +			     "fsl,sec-v5.0-job-ring",
> +			     "fsl,sec-v4.4-job-ring",
> +			     "fsl,sec-v4.0-job-ring";
> +		reg	   = <0x1000 0x1000>;
> +	};
> +
> +	jr@2000 {
> +		compatible = "fsl,sec-v6.0-job-ring",
> +			     "fsl,sec-v5.2-job-ring",
> +			     "fsl,sec-v5.0-job-ring",
> +			     "fsl,sec-v4.4-job-ring",
> +			     "fsl,sec-v4.0-job-ring";
> +		reg	   = <0x2000 0x1000>;
> +	};

You claim compatibility with a bunch of prior SECs, but sec-v5.2 has four
job rings and an rtic node.  Likewise for the previous compatibles
listed.  This has two job rings and no rtic.

Can you point to where in the SEC v4.0 binding (I don't see a binding for
the subsequent versions), it says that these are optional?

-Scott
