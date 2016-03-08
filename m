Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA7B81A009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 10:57:53 +1100 (AEDT)
Date: Tue, 8 Mar 2016 17:57:49 -0600
From: Scott Wood <oss@buserror.net>
To: Ashish kumar <Ashish.kumar@nxp.com>
Cc: scott.wood@nxp.com, linuxppc-dev@lists.ozlabs.org,
 Shaveta Leekha <Shaveta.Leekha@nxp.com>
Message-ID: <20160308235749.GA1048@home.buserror.net>
References: <1453987059-26263-1-git-send-email-Ashish.Kumar@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453987059-26263-1-git-send-email-Ashish.Kumar@nxp.com>
Subject: Re: arch/PPC:B4860qds/B4420qds: Updates to device trees for B4860
 for DSP clusters and their L2 caches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 06:47:39PM +0530, Ashish kumar wrote:
> B4860 has 1 PPC core cluster and 3 DSP core clusters.
> Similarly B4420 has 1 PPC core cluster and 1 DSP core cluster.
> 
> Each DSP core cluster consists of 2 SC3900 cores and a shared L2 cache.
> 
> Add DSP clusters for B4420
> The L2 cache nodes such that they now appear in only the
> soc specific dtsi files(b4860si-post.dtsi and b4420si-post.dtsi).
> 
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Shaveta Leekha  <Shaveta.Leekha@nxp.com>

The subject line is way too long, and has a non-standard prefix.

It should be something like "powerpc/fsl: Add DSP clusters and their L2 nodes"

> +
> +	dsp-clusters {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dsp-cluster0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,sc3900-cluster";
> +			reg = <0>;
> +
> +			dsp0: dsp@0 {
> +				compatible = "fsl,sc3900";
> +				reg = <0>;
> +				next-level-cache = <&L2_2>;
> +			};
> +			dsp1: dsp@1 {
> +				compatible = "fsl,sc3900";
> +				reg = <1>;
> +				next-level-cache = <&L2_2>;
> +			};
> +		};
> +	};

Where is the binding for this stuff?

Why "dsp-cluster0" instead of "dsp-cluster@0"?

-Scott
