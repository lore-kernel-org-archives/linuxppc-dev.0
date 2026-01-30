Return-Path: <linuxppc-dev+bounces-16461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC6EE6BF1E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jan 2026 15:53:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2gXs3yVqz2xT4;
	Sat, 31 Jan 2026 02:53:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769788429;
	cv=none; b=EaFiMPuBenO8fTRJ+4e42AevE5309aUhGOy0/+wtX9n9RqIwagoPbLoA9GUFtsqjq2r67zdeJgrZHQLRfnWCl/ar1nTTcg05AsILLmeRwS1WuVPX12gdR5URhltZv3eDv/Hc/Fsg/ntLOOZ2pNDS1VGQ3eM5gr7UPVE/0aFI1LL6QpydkifK+JCUW1i/eDeBBMZD196tKlzYK+azIBY3sqJA6cHA4ZuX26Dki8vMqOHwqaDW/oIBJ/LDC8RqTF1NZKopqFHGkWh+H5iGWEKAyNmVx2Glfv5js6JD1e/Aw3XoywILzvyCEMV++NHp4shHlpt7/sy4Zm/J+rBrK/++0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769788429; c=relaxed/relaxed;
	bh=/N/gdqXNSxjGhSy6xlZCb5nNS6V3s9YjmXiDnl7X37k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcPh9cUqPJB5soZzk20W7zduG7Eq2vZ5dR/+FV4sqEAWPf126PlmCyx3x3/45OldjBcO+D8FbdNHNvt6eLj5CR0Jmg23Lijiq6H1MwXzlync0FD/OO81QMWnpM2lUJBkzMMHGZHbySGVBEfWW6/B1M9wvfkVGmqQr4T5DIzgjpOBeiI/Xv2hEemZ/FyBzy+UG+p5xnyNuloKTdVzVsKudGn3eLWeoIlOH+X8tnmG3Z/Akw8P8Yek5tuWa+N889hgUw0n1408nwB/FGshiBqFOA3jmXwcEf9+RuDyFw+k+nHeqklY+iYUoiHBlXPcSy+1QETEwSxEnnUEV8ArJpfiwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2gXr2ZZjz2xPW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2026 02:53:47 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60UFreJP3403643;
	Fri, 30 Jan 2026 09:53:40 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 60UFre7G3403642;
	Fri, 30 Jan 2026 09:53:40 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 30 Jan 2026 09:53:40 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Failure to build with LLVM for the Wii
Message-ID: <aXzUBHQR7ZJ4nVAA@gate>
References: <aXs8sgAcci9FKKpx@luna>
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
In-Reply-To: <aXs8sgAcci9FKKpx@luna>

Hi!

On Thu, Jan 29, 2026 at 11:55:46AM +0100, Link Mauve wrote:
> I’m trying to build the kernel for the Nintendo Wii, using LLVM instead
> of gcc, in order to bring Rust support to this architecture (and also
> because my distribution doesn’t ship a cross-compiling gcc), but I get
> this build issue near the end:
> ```
> % make O=wii LLVM=1 ARCH=powerpc -j1
> make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
>   GEN     Makefile
>   CALL    ../scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   WRAP    arch/powerpc/boot/dtbImage.wii
> objcopy: Unable to recognise the format of the input file `vmlinux'
> make[3]: *** [../arch/powerpc/boot/Makefile:394: arch/powerpc/boot/dtbImage.wii] Error 1
> make[2]: *** [../arch/powerpc/Makefile:236: zImage] Error 2
> make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
> make: *** [Makefile:248: __sub-make] Error 2
> ```
> 
> I believe it should use $(OBJCOPY) instead of objcopy, which is set to
> llvm-objcopy, but couldn’t figure out where it is misconfigured.

Other people already pointed you places, but to find out for yourself:

   make V=1

will tell you all that happens.  The kernel build system tries to not
say much at all normally, but sometimes you want to see whatever is
happening :-)


Segher

