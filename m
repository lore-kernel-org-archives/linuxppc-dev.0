Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id BAFF52C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 21:34:54 +1100 (EST)
Date: Tue, 7 Jan 2014 10:34:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/dts: fix lbc lack of error interrupt
Message-ID: <20140107103447.GC2930@e106331-lin.cambridge.arm.com>
References: <1389076002-18674-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389076002-18674-1-git-send-email-dongsheng.wang@freescale.com>
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 07, 2014 at 06:26:42AM +0000, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> P1020, P1021, P1022, P1023 when the lbc get error, the error
> interrupt will be triggered. The corresponding interrupt is
> internal IRQ0. So system have to process the lbc IRQ0 interrupt.
> 
> The corresponding lbc general interrupt is internal IRQ3.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
> index 68cc5e7..13f209f 100644
> --- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
> @@ -36,7 +36,8 @@
>  	#address-cells = <2>;
>  	#size-cells = <1>;
>  	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
> -	interrupts = <19 2 0 0>;
> +	interrupts = <19 2 0 0
> +		      16 2 0 0>;


Minor nit: please bracket individual list elements like so:

interrupts = <19 2 0 0>,
             <16 2 0 0>;

Otherwise this looks fine to me.

Thanks,
Mark.
