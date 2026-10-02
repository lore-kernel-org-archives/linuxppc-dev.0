Return-Path: <linuxppc-dev+bounces-28736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13282CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:19:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx3BH4Kkqz30Cj;
	Fri, 02 Oct 2026 19:19:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932743;
	cv=none; b=lFAc1tQcvnyswks1z9+rjhCtUKgrDBuEQLnVhitzJ15GfMqW3uel6wYSH/xMG9G2MZkGOjebSKCCu9V1fJSUKb/Umo15pRXB1IsnwUW2mPr5BzTXLBBGb3KX0z4ljDXcrZKmQe14v0xDRpW1EtrD0axnvlkQ4VbTLwvnu/qfLhR7nGajZWLH0vPqKE+qjRIrVQSs4vYSpJ33itlPslAcOjiXDtne/9t6MLJCf/3alOxmD63T2coirNRVEFksaczS1X03Rinx+D6MuT417cEX6pWul9dlZw3VGBTmpNVKsNVgOJ4Wiw2cRnL5irOXtNtgGm+hEMCpvE7yiyJu8iukOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932743; c=relaxed/relaxed;
	bh=kUPal21B/mSeq/i2I0fVbafYDiAiPgFaWqso5GBNYgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM6gK4hX6/a8sBRLru87IE1DaPA4SoG7ICV7y3SFwj8ll3bXzI97HktDGHwNFG0udpb3vLQwWzMDEhAM9jgaFODcpOi00Phy+amO/q8NqVdMzrv1vP6T4ZFsHq+gTXwkqAjGUzVhXf2fNA9d6BYx1lAx6vrCwwwI/IWniSNY8gFYf7ZDPzKbn7F6E/ZAtzVrqFC+H93bsVV1iAviSrDOYl0g66SPEWrdRW6RKkOIxhvSgS6wB87iGjZgmf4h/OZWNWye4vChgwBNlw1jGVgWyxxYop+dMulj7hh6h/HtqrcCoViiSnodhIIrPZxIKXcJjivxdnKxI+nMzD4E5BZ0HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bib7a0PM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bib7a0PM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3BF5Wqfz30Bd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:19:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A3F8760A96;
	Fri,  2 Oct 2026 09:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854CD1F000FF;
	Fri,  2 Oct 2026 09:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932738;
	bh=kUPal21B/mSeq/i2I0fVbafYDiAiPgFaWqso5GBNYgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bib7a0PM9uB/Juf5Fvu+oSR5+RsFmNc22FbQ3W8GIqtnemb+ACt71CTBw2sib4s92
	 fFnF4433pDjiEGcg7x5zAEvURZ47Q+qrMo2IYrA95mk7vxbQjDv/9+rywF+rGaZ2P7
	 MWKHtnnqTQ8pjgpyCRbNP4t/CulAsggec5uV/Q4dsuX2d3LyZTJU72PUMvHEvpTwms
	 bQHF6mNjpQkROI+pb8cwG0OWRm4RbVW2IZfgTwGPNyr7ZCIRlyeoMH50oI1zzLRcfH
	 fUDv5QFMQ3ZAiDD1vUKWIdfRDKrY3rzo4o2Sj1ojPFTeN/KT1OBRSYQl++2ya2NmOw
	 blTAYWLPs3B3Q==
Message-ID: <83a874fb-db66-4dc2-8e14-68c7e28ae27c@kernel.org>
Date: Fri, 2 Oct 2026 11:18:51 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev
References: <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162> <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com> <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com> <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ar46ap4jzLWyP92C@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/10/2026 à 12:48, Jason A. Donenfeld a écrit :
> On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
>> control. The change that introduced -max-store-memset only did it to
>> "allow fine-tuning of the inlining threshold for performance analysis
>> and optimization". If they decide to remove it for whatever reason,
>> we're back to square one.
> 
> I suppose all the more reason to get -finline-stringops=memset added to
> clang. Then the dual-default thing you came up with below will naturally
> start choosing the first option when it becomes available.
> 
>> I know something like below would be uglier due to the ifdef but it
>> would avoid changing anything for GCC while clearing up the issue at
>> hand for clang in a guaranteed stable and succinct manner.
> 
> But then we're back to the byte-by-byte codegen that Christophe pointed
> out.
>   
>> If that is not acceptable, something like the following does appear to
>> work for me.
> 
> Okay, great, let's do that.
> 
> Does this commit seem okay with you? I used the diff you sent below and
> adjusted the commit message: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.zx2c4.com%2Flinux-rng%2Fcommit%2F%3Fid%3D56ff95ee85715047eb5b5220243778af657778c8&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cd89b4de22ff94b6be71208df1fa9839a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639264485055490029%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Vxf8xRCdLavtw4Dmi%2B49FY1lJDWtm%2BjKv7f8BxKTGq4%3D&reserved=0
> 

The commit message says: Similarly, GCC has -finline-stringops=memset to 
do the same [4], should this issue ever hit future version of GCC.

Why default "-finline-stringops=memset" if 
$(cc-option,-finline-stringops=memset), have we identified cases where 
build fail without that or is it just for future provision ?

As shown in my previous email, with GCC 16 on powerpc32 we get a 
slightly better code without this option.

---
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..98d8d7fa64c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -173,6 +173,11 @@ config CC_HAS_ALLOC_TOKEN
  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
  	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) 
= { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)

+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if 
$(cc-option,-finline-stringops=memset)
+	default "-mllvm -max-store-memset=4294967295" if $(cc-option,-mllvm 
-max-store-memset=4294967295)
+
  config LD_CAN_USE_KEEP_IN_OVERLAY
  	# ld.lld prior to 21.0.0 did not support KEEP within an overlay 
description
  	# https://github.com/llvm/llvm-project/pull/130661


