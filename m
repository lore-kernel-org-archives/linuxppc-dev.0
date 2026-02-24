Return-Path: <linuxppc-dev+bounces-17137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA8F55434
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 01:59:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLHpd4hJhz3dBq;
	Wed, 25 Feb 2026 12:59:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771975996;
	cv=none; b=YeJidVzf0sJBEQ0K/h0zCzLrVqln7uCn7SGTgpXXyI36kVTmda94UsFm6BpJJ55lypizq52sHtnxkKz12A5soerUtmU+6AHTq8PHDP04q54WwMk6pgLisNWW30zgePxqtGpxi0bukkzDO3nAUA+v83cSLITNP/mlFyFtZPyPxKDh23YlMgSM21KVv/MPq1iTL32M0Xn6zK5C+kbKJyCc/OD/qRniL4/j5yhvY2pb8qswI1fT++gl2Uqe3f6oi5G1uJAAiXz27AS/g38ciX3AMWvwRz9gLiv+rUv/Ad1hD6vmWRsnGhAqyu2BpZbhE/Pnhyw1E1kLlOHVxl3ex+iRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771975996; c=relaxed/relaxed;
	bh=KwQalYMWTwMP4M+FQW5xwdF4J5kMnovp49C0rT2vdQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ9Nn8TrynkV8MrbzAfC0Eu904LUh4IaUy/ocnlO3yDvHc6RccsCjDLOjBs+Tk8BO922d5/ghGsqP3T5skA7x6oYd5g4tY2YYRsz5WSobJT7nAPAdjITVBUL4AxjLycN3JBSejHMBJNa/yKRsTcGPgK3EjvUzEYuePYfOuR7z6mzkwePeezziPmzkMEfdQiGbuRCGjcfKXo1K3+hiIV9M7te96GTifBNdjL4SijEIal6zmUfvzJ4odRrey782CGGL9e0aqMJRZtkVLOQhB9D002IZFkYuTSEQaj0WNQBVpcW4GQWIIEZ3WPH6FoG3RRaRgCUDNPk93cT7tUcgeKjew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Uukjzxhz; dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=G8QpVoG+; dkim-atps=neutral; spf=pass (client-ip=5.75.144.95; helo=mail.mainlining.org; envelope-from=aelin@mainlining.org; receiver=lists.ozlabs.org) smtp.mailfrom=mainlining.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Uukjzxhz;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=G8QpVoG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mainlining.org (client-ip=5.75.144.95; helo=mail.mainlining.org; envelope-from=aelin@mainlining.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 146 seconds by postgrey-1.37 at boromir; Wed, 25 Feb 2026 10:33:14 AEDT
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLDYQ2700z3clw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 10:33:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1771975841; bh=KwQalYMWTwMP4M+FQW5xwdF
	4J5kMnovp49C0rT2vdQ4=; b=Uukjzxhz3Dr+cXdlOV+aSFORFmnTUjXYjGwrVS20vC9V65UcL2
	6zIJXYirK0rR121RJOnzJ8r3FJgnPDOqDYCByUo9GWr4QctA470jTXacjULZ8/bNk202VwC4Kof
	bgx55G+1yENEvyNcAzvEPHMUNfM0+6OouO/vmJsgQealIzSgJHp+WhTKH1N92KrTFCdDtedcExM
	N0Iqe4R7VCY1DbIfXnAf1iWysnpadQ1lWCOcAd5Nfnn5kC8xvO33Be3Zvo8DNTOqKO2TUH4NpyF
	SYHlDR8B4kx6ulcAMOCZCRPA3wsCHLCL1ZVVytH6aGLpAVSAC1UmzMGZZTODtTvE7SQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1771975841; bh=KwQalYMWTwMP4M+FQW5xwdF
	4J5kMnovp49C0rT2vdQ4=; b=G8QpVoG+pfT01hkDnrLnViIoQqYohWptZmGJSHA+Swzqv+Zn91
	iJfFVFalGGzjTaaigF3XMrwKHWfoUpKVBuDA==;
Message-ID: <77cd40dd-bc40-4223-a5db-7eb514c13b78@mainlining.org>
Date: Wed, 25 Feb 2026 00:30:30 +0100
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
Subject: Re: Failure to build with LLVM for the Wii
To: Nathan Chancellor <nathan@kernel.org>, Link Mauve <linkmauve@linkmauve.fr>
Cc: linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
References: <aXs8sgAcci9FKKpx@luna> <20260129223136.GA1614447@ax162>
Content-Language: en-US
From: Aelin <aelin@mainlining.org>
In-Reply-To: <20260129223136.GA1614447@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/29/26 11:31 PM, Nathan Chancellor wrote:
> Hi Link,
> 
> On Thu, Jan 29, 2026 at 11:55:46AM +0100, Link Mauve wrote:
>> I’m trying to build the kernel for the Nintendo Wii, using LLVM instead
>> of gcc, in order to bring Rust support to this architecture (and also
>> because my distribution doesn’t ship a cross-compiling gcc), but I get
>> this build issue near the end:
>> ```
>> % make O=wii LLVM=1 ARCH=powerpc -j1
>> make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
>>    GEN     Makefile
>>    CALL    ../scripts/checksyscalls.sh
>>    DESCEND objtool
>>    INSTALL libsubcmd_headers
>>    WRAP    arch/powerpc/boot/dtbImage.wii
>> objcopy: Unable to recognise the format of the input file `vmlinux'
>> make[3]: *** [../arch/powerpc/boot/Makefile:394: arch/powerpc/boot/dtbImage.wii] Error 1
>> make[2]: *** [../arch/powerpc/Makefile:236: zImage] Error 2
>> make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
>> make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
>> make: *** [Makefile:248: __sub-make] Error 2
>> ```
>>
>> I believe it should use $(OBJCOPY) instead of objcopy, which is set to
>> llvm-objcopy, but couldn’t figure out where it is misconfigured.
>>
>> Thanks for your help!
> 
> It is the arch/powerpc/boot/wrapper script:
> 
>    https://github.com/ClangBuiltLinux/linux/issues/1601
> 
> I have a WIP series from long ago that may be a good starting point for
> getting something working but there were some errors I never got around
> to solving before having to shelve it for other issues:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/log/?h=wip/llvm-1-powerpc-boot-wrapper
> 
> Maybe something I (or someone else) can get back to soon.
> 
> Cheers,
> Nathan
> 

Hi Nathan,

your last 3 patches on this branch do indeed fix the wrapper script for 
the cross-compilation with LLVM=1 ARCH=powerpc without CROSS_COMPILE set 
or GNU binutils in PATH. They look good to me! Would you be willing to 
submit them now without touching the VDSO? That part does not seem to be 
necessary to fix the wrapper script for this usecase, so it should 
strictly be an improvement. I'd also be happy to pick up your patches, 
send them and follow-up on feedback if you don't want to do it yourself.

Best regards,
Aelin

