Return-Path: <SRS0=XOTo=LL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C7C49EA2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 04:41:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08DD613D5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 04:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08DD613D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G58Xj58Fwz3c0v
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 14:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Lg28WU8d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Lg28WU8d; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G58XC3Z8cz306W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 14:41:30 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G58X90fL9z9sW6; Thu, 17 Jun 2021 14:41:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G58X85dNdz9sTD;
 Thu, 17 Jun 2021 14:41:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623904888;
 bh=zj99gzadatRL4zwEOH6gU654Lg1IqdYv0wxWxXYTDrU=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=Lg28WU8dP+KNsKaC2V/5AvMvNRhzSGUEqSwYIalsTOzw31V1597Rm645vcCUqO8MA
 2P8Ap2y1ohD/i2MXo3dwccZSI3lBxnR/CAbjnP/YW1zmmGfLcMc23XLks1mBR0WJi2
 yWxICNZOdoVdIRUGB+T1QuUDdEBdItfJd6RMjBsRDVoNHNQKksxMp0VBMHmWeYNqLp
 ui5Vht7m6QGcUWl61aedKnNtk5Oa09LCId4YuhWIOd/yMUqM+IpuBxZBaXgql/BACZ
 TsQpUJp5u6NNzNWjZs6ZBgcbIrd1+MPF3HYNPgFB7mChq1TX5P6Egs3P5NiiZPEyAG
 rTsB10WC1bvLA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/11] powerpc: Add Microwatt device tree
In-Reply-To: <YMffEN3q5RlLeg4W@thinks.paulus.ozlabs.org>
References: <YMfeswgEHeXSLOUF@thinks.paulus.ozlabs.org>
 <YMffEN3q5RlLeg4W@thinks.paulus.ozlabs.org>
Date: Thu, 17 Jun 2021 14:41:28 +1000
Message-ID: <8735thrtl3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul Mackerras <paulus@ozlabs.org> writes:
>

Little bit of change log never hurts :)

> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/boot/dts/microwatt.dts | 105 ++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/microwatt.dts
>
> diff --git a/arch/powerpc/boot/dts/microwatt.dts b/arch/powerpc/boot/dts/microwatt.dts
> new file mode 100644
> index 000000000000..9b2e64da9432
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/microwatt.dts
> @@ -0,0 +1,105 @@
> +/dts-v1/;
> +
> +/ {
> +	#size-cells = <0x02>;
> +	#address-cells = <0x02>;
> +	model-name = "microwatt";
> +	compatible = "microwatt-soc";
> +
> +	reserved-memory {
> +		#size-cells = <0x02>;
> +		#address-cells = <0x02>;
> +		ranges;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x10000000>;
> +	};
> +
> +	cpus {
> +		#size-cells = <0x00>;
> +		#address-cells = <0x01>;
> +
> +		ibm,powerpc-cpu-features {
> +			display-name = "Microwatt";
> +			isa = <3000>;
> +			device_type = "cpu-features";
> +			compatible = "ibm,powerpc-cpu-features";
> +
> +			mmu-radix {
> +				isa = <3000>;
> +				usable-privilege = <2>;

skiboot says 6?

> +				os-support = <0x00>;
> +			};
> +
> +			little-endian {
> +				isa = <0>;

I guess you just copied that from skiboot.

The binding says it's required, but AFAICS the kernel doesn't use it.

And isa = 0 mean ISA_BASE, according to the skiboot source.

> +				usable-privilege = <3>;
> +				os-support = <0x00>;
> +			};
> +
> +			cache-inhibited-large-page {
> +				isa = <0x00>;
> +				usable-privilege = <2>;

skiboot says 6, ie. HV and OS.
Don't think it actually matters because you say os-support = 0.

> +				os-support = <0x00>;
> +			};
> +
> +			fixed-point-v3 {
> +				isa = <3000>;
> +				usable-privilege = <3>;

skiboot says 7.

> +			};
> +
> +			no-execute {
> +				isa = <0x00>;
> +				usable-privilege = <2>;

skiboot says 6.

> +				os-support = <0x00>;
> +			};
> +
> +			floating-point {
> +				hfscr-bit-nr = <0x00>;
> +				hwcap-bit-nr = <0x1b>;

Looks right, bit 27:

#define PPC_FEATURE_HAS_FPU		0x08000000


> +				isa = <0x00>;
> +				usable-privilege = <0x07>;
> +				hv-support = <0x00>;
> +				os-support = <0x00>;
> +			};
> +		};
> +
> +		PowerPC,Microwatt@0 {
> +			i-cache-sets = <2>;
> +			ibm,dec-bits = <64>;
> +			reservation-granule-size = <64>;

Never seen that one before.

> +			clock-frequency = <100000000>;
> +			timebase-frequency = <100000000>;

Those seem quite high?

> +			i-tlb-sets = <1>;
> +			ibm,ppc-interrupt-server#s = <0>;
> +			i-cache-block-size = <64>;
> +			d-cache-block-size = <64>;

The kernel reads those, but also hard codes 128 in places.
See L1_CACHE_BYTES.

> +			ibm,pa-features = [40 00 c2 27 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 00 80 00 80 00 00 00 80 00 80 00 00 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00 80 00];

Do you need that?

You shouldn't, if we've done things right with the cpu-features support.

> +			d-cache-sets = <2>;
> +			ibm,pir = <0x3c>;

Needed?

> +			i-tlb-size = <64>;
> +			cpu-version = <0x990000>;
> +			status = "okay";
> +			i-cache-size = <0x1000>;
> +			ibm,processor-radix-AP-encodings = <0x0c 0xa0000010 0x20000015 0x4000001e>;
> +			tlb-size = <0>;
> +			tlb-sets = <0>;

Does the kernel use those? I can't find it.

> +			device_type = "cpu";
> +			d-tlb-size = <128>;
> +			d-tlb-sets = <2>;
> +			reg = <0>;
> +			general-purpose;
> +			64-bit;
> +			d-cache-size = <0x1000>;
> +			ibm,chip-id = <0x00>;
> +		};
> +	};
> +
> +	chosen {
> +		bootargs = "";
> +		ibm,architecture-vec-5 = [19 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 40];

Do you need that?

I assume you run with MSR[HV] = 1 (you don't say anywhere), in which
case we never look at that property.

cheers
