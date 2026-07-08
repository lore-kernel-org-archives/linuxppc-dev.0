Return-Path: <linuxppc-dev+bounces-23829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6271AC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:09:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwM2W0hDdz2xll;
	Thu, 09 Jul 2026 01:09:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783523379;
	cv=none; b=mVra2eXQpHzSmUIF1fal4hnluTlCBnsiSdjjgcVCqGsA1XjxrjxqFVl9GPF+u6Q3ZKDMiRifXD/FTEyJ7dSBi7SFcxUdShGqjUyEstcjDmT3M81Zv9tjXyNR43QR18NoJ6zFmBZzRZlqdnFGSOZ/6MorRjw4Zzsd5KVZqHjr9IFpA+RlpUJBuVOuzji6Mu45dhVYpL836+9gqX+c1X5LFu5853/S1ikJLLoHHjED6n0Go7Eb4RFcRG2MDF40RpV3fNzGpBM/WAZKy389WcXTykRhVND4e62tT2Bzch2br4tldMjt19Rv+uDr2Ccw5C5gJZpjsH6f75Aip4bfSslVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783523379; c=relaxed/relaxed;
	bh=5PZNUkHdJ6nqcdgkr9hcvPfqh6tCZ4YTms0UgHLH5I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9clvSYSMxD2DqyjQoeUdiW+unR1axGaI5s2fyyMDaoO07ybYjAZ8bc1fVXKz8HeEmrU/FUMj+gih20utfy6SO2m/uVV7ej5E8y+nGJFQQUxKBGo5fGXuEzD2vXqeF3RGKYtExZGNGyyj7Er2ynhMB0VrCZOW0uQTXcqimYADJs/9UZGb/TRku/bKginWq1Vqi79nCVEySSIG76M6cRE+WnRF0Xhw6xQOrMUM9/nGA3BgJDFaWs4T07aefH6Y8wig8TDXqkJKb+YP8Lv+Mpc4SkFUqmheig/DZ4gYeQhdIXW6aiRRqBWo5otIAZ2VnGJc7d4A8pE8kyOhz417C9AFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KX6ZYgCf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KX6ZYgCf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwM2T4G5Gz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:09:37 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so5469695ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783523374; x=1784128174; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5PZNUkHdJ6nqcdgkr9hcvPfqh6tCZ4YTms0UgHLH5I0=;
        b=KX6ZYgCfTLShJSDGWPcOStQrOoWQDFT8scYIf5GCzt1dCxSqQi2UnG/P8tDacN9V6b
         DFmiaklc/sxrlJ1GzrRvXbB+RB+LX0y5XrOd8NE+5oqcu75vtdHdlg3KsV9r0OuMXdLz
         HBhEt+a7IpowJg2zJL9beM27dGekDhUfnonDvG08eVnq7lG1lqdgctYlKUzCNyNEWlbm
         fHMKIv/xRutgRrGDdC3y6CkYc+z/cPgDz2BlvAh9C53W7Y+KqKHs4g7j03xce+MKQj1b
         WDFORlSbHI2evgRQaVEe56nb/UDAcAdInV5Gf0Bx0IxMW1TmjRxElh3AFBa5znkE4mRx
         DUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523374; x=1784128174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5PZNUkHdJ6nqcdgkr9hcvPfqh6tCZ4YTms0UgHLH5I0=;
        b=LkH0V9eU2F8janrUf3hBuuvgmOzaLy+TuhuoeLOpz82g3KrmHAP0tz04RclogH33TS
         Mg4Qn6o/Qkm9NNmhmlTzHCV49Q2NOuRt3JWrFrTnA0Evo8qvXlSclxG1COojGRVG5jvj
         MR5WVUNxFSex2p0ErqzceyIlnckv6D5SgyGlx6Z1ycDY4LkIGBX+kIHXzuj3HhVHpj7h
         4L4wPdNjvD6zOUVken4hQc3l0IGweHZS00J5I3YcCzwtg/gl8kcXqmCbUOaJTUiDLHUh
         mT/fs/qqI9PWdaoz1fNptEUkPrIRcKPIAZD87ukIPOd0jZxv+Q/mfs/v8xrbBgMCaZX7
         rEKA==
X-Forwarded-Encrypted: i=1; AHgh+RrVqSXt3fa6vTcG8iLZkreQuwbOTmhBtxZy+pzCajSOEE3NCdxZZC52xV0uxQdSDBtO/trZ8E7YhpqvEko=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHDP5soEmA3NKYL1vZGcISZGFv6/qJNbJ3vqxPlr617unnugY6
	ZR5wN64vHyMZ9OinzhRxepfyfLU6iP3dNFrOtlFY458SI2MsdyVgeJFH
X-Gm-Gg: AfdE7cm5bUtylRAk3jA70iO3YjzRsjJAYURx+4qoiVvZOzVe/qw70FSi9O+0qrXvpDy
	dNe402hSgAYyOS88fvkzh4iP1m/QKMg9IIQhoWiQekYWWqdYmtJdByTkopOxBALs2eGppK/cG4n
	68rkJRv2wBgaBhBi1wZNBFKP501h4ZOM9EZAIFS0ddS2Mci92BRt6tawQ2PXSrRElo32SBbdXXu
	GIu2Mg6AH0zHUZImOfUFxtzu/E1hR1n4se7CTP/v13/wXCdJw2Qv+WfKit6Slp7R55qYqa9Sggg
	9YjKuzEU06pwQNnkCa03PNMVszLAQ68ohSLKHpp6I8iHmZqOJ5o65HqehCXhlEmy0mjuTzrecbw
	RXIEVpjTKw/Ici/NdaepUgXtpdgtphlJZhw3fxbNEH8zCzXyHAUuJOf0nXWfud06z+fbuzLgLBI
	FjUOv6fCf5g+iRVWfbEkBImwlFQtLTKvEk4Dc3Hk8LEliNy63/eUY/nMRsnznN
X-Received: by 2002:a17:902:ef4d:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2ccea36556dmr27151965ad.12.1783523374093;
        Wed, 08 Jul 2026 08:09:34 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm29932865ad.15.2026.07.08.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:09:33 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:39:19 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	fujita.tomonori@gmail.com, joelagnelf@nvidia.com, gregkh@linuxfoundation.org, 
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com, lina+kernel@asahilina.net, 
	j@jannau.net, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <ak5ngpTqcKS1rOvH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <20260708082454.1254320-5-mkchauras@gmail.com>
 <ak4MwnDwIgdUhK3K@luna>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak4MwnDwIgdUhK3K@luna>

On Wed, Jul 08, 2026 at 10:39:30AM +0200, Link Mauve wrote:
> Hi,
> 
> On Wed, Jul 08, 2026 at 01:54:51PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Minimum `rustc` version required for powerpc is 1.95 as some critical
> > features required for compiling rust code for kernel are not there.
> > 
> > For example Stable inline asm support which got merged in 1.95.
> 
> Didn’t we decide on 1.85.0 with the asm_experimental_arch feature
> instead?  And possibly on 64-bit 1.87.0 if it isn’t possible to disable
> altivec correctly there?
> 
1.85.0 or 1.85.1 is not feasible for ppc64le.
PPC maintainer is ok with 1.95 for PPC. It's still experimental for PPC.

Regards,
Mukesh

> > 
> > Link: https://github.com/rust-lang/rust/pull/147996
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  scripts/min-tool-version.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 031f2192b390..99bfdcaa3396 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -33,6 +33,8 @@ llvm)
> >  rustc)
> >  	if [ "$SRCARCH" = "s390" ]; then
> >  		echo 1.96.0
> > +	elif [ "$ARCH" = powerpc ]; then
> > +		echo 1.95.0
> >  	else
> >  		echo 1.85.0
> >  	fi
> > -- 
> > 2.55.0
> > 
> > 
> 
> -- 
> Link Mauve

