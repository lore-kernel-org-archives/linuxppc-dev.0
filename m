Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10EC42C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:45:06 +1000 (EST)
Message-ID: <1377207893.20722.14.camel@snotra.buserror.net>
Subject: Re: [PATCH] Device Tree bindings for DSP clusters and DSP CPUs
From: Scott Wood <scottwood@freescale.com>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Date: Thu, 22 Aug 2013 16:44:53 -0500
In-Reply-To: <1377077149-24347-1-git-send-email-poonam.aggrwal@freescale.com>
References: <1377077149-24347-1-git-send-email-poonam.aggrwal@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-21 at 14:55 +0530, Poonam Aggrwal wrote:
> Binding for DSP CPU clusters and DSP CPUs for Freescale SOCs which
> have DSP CPUs in addition to PowerPC CPUs. For example B4860.
> 
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/dsp-cpus.txt   |   78 ++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
> new file mode 100644
> index 0000000..da7f5d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
> @@ -0,0 +1,78 @@
> +===================================================================
> +Binding for DSP CPU clusters and DSP CPUs for Freescale SOCs which
> +have DSP CPUs in addition to PowerPC cpus.
> +Copyright 2013 Freescale Semiconductor Inc.
> +
> +Power Architecture CPUs in Freescale SOCs are represented in device trees as
> +per the definition in ePAPR.
> +
> +Required properties for DSP CPU cluster:
> +- compatible : should be "fsl,dsp-cluster" or "fsl,sc3900-cluster".
> +- reg : should contain the cluster index
> +
> +Required properties for DSP CPU:
> +- compatible : should be "fsl,dsp" or "fsl,sc3900".
> +- reg : should contain index of DSP CPU within the DSP clsuter. 

s/clsuter/cluster/

Could you elaborate on "index of DSP CPU within the DSP cluster"?  From
the examples it looks like the reg values are unique even across
clusters.

I wonder whether we should be describing this at all in the device tree
given that the topology is discoverable in registers...  though that
applies to the PowerPC CPUs as well. :-)

-Scott
