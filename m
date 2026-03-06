Return-Path: <linuxppc-dev+bounces-17860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE59FC9EC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 23:48:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSNQk1nyFz3cB3;
	Sat, 07 Mar 2026 10:48:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772840926;
	cv=none; b=ixcOHy9dBBJrX70ApZeHmNHmvRH5T+C/FIk7KR4q7kgBAyMkweGADOPLDk26ThksY++w+ox90C0z8nAn0WwfcsXT+PZvcj3PsBWOLa1LUZRSb5gqewFMyadeFpYQM6Jrc7Vd5FPpZlfTUJ/O87ZBgcUBos02NWBmbB8un/y5AlC3UcKQ+I7fCoX+uAH5O1A9Geq7/9jl0Rk/zvIO5yXlNvv/izIbFzXP5ej9nyIn/Wts0TZuMqt9Cyk5Xzjgmqjyy60bpYlOpReNLQwLM633VpqnBzq+f8+bA10lQJ7ULiTDMrQy9Zcakn2+aMF4tWFW3ilr6obOBVomISAETa3Izg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772840926; c=relaxed/relaxed;
	bh=+EuyHHVP1ezysh+DOMChYpQ6YLA93nDMuTUQuNAbUKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBiE8kfssWiu+4HLOZH0MM0p7QBfGwKMpxupn2LW9sf8kuCEjZ/LNi2eaj4a2cLNUY9sPMnc6ZCO4cIor1IBSEAhWasxS7iv2SZ9+F2OXhZmXsggHBI6ZLM50VgyODqZySg8evR8i1+fXenGITniaXeMZSWHLHteE3sPCdwthLKYJfNgsuibMZl7JjId6CPrISpmvRnMNwVKcO5D+hXntlLf8VyZuR3JE3RpfCJ7A/aRvwjAoswIlKttxprxSNyAIqGtZZg4Bc83TezzWjm22gKarJFIB7MNCWVtWK8jM9z5Ut8gOjiq8OIRnMukpD0/STissrZ8YATQR5hXJEbCZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=PioK8n1G; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=PioK8n1G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSNQh2Qbgz3c9y
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 10:48:43 +1100 (AEDT)
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 626NVQj92208026
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 6 Mar 2026 15:31:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 626NVQj92208026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1772839922;
	bh=+EuyHHVP1ezysh+DOMChYpQ6YLA93nDMuTUQuNAbUKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PioK8n1GDOCMylG5Zt2121yBqaQjmuAgAG8ArmoqbSGk+AY2HjiUf0EtOT1DsexRY
	 3XzpMhpcVWr9RPSEgwVE9ESR7uck6X+0Brpr8WoubZ+TlXmlH4lDGa0CVViVEYVOPr
	 a2U1eLnne4Jq8YkGPdE7tatxcJ2Gd+LMg66XDUlWERyyYKh8whYexkpditNEyz4ILx
	 yckiGOkMmhcxGYFKzQD0ff8pydvHcvjyUktvDHaVTIquZDk64YCElixBnK+5hWClOa
	 uRJidGVd5gvOOIeokQ5EcbFwoFLXBWjUIyo+ZDse7szoWgdzIXdm2JW1VkFzyB6i6x
	 eQ3pvQwa4welw==
Message-ID: <75d0ca29-b227-49c1-8204-b305f64b009b@zytor.com>
Date: Fri, 6 Mar 2026 15:31:21 -0800
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
Subject: Re: [PATCH 0/2] kbuild: Switch from '-fms-extensions' to
 '-fms-anonymous-structs' when available
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        llvm@lists.linux.dev
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <01433066-eb9b-4a96-8d7f-794af941d365@zytor.com>
 <20260306231705.GD2746259@ax162>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260306231705.GD2746259@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-03-06 15:17, Nathan Chancellor wrote:
> On Thu, Mar 05, 2026 at 03:43:29PM -0800, H. Peter Anvin wrote:
>> Question: does clang allow this with __extension__, or only if the option is
>> on the command line?  It would be desirable in the long run if both clang and
> 
> It looks like only on the command line:
> 
>   https://godbolt.org/z/zrE766obe
> 
>> gcc would allow this with __extension__, as that would be required to use it
>> in uapi headers (at least without some doable-but-nontrivial preprocessing,
>> which might be worthwhile to do anyway...)
> 
> I agree that would be desirable but wouldn't that change how
> __extension__ works? As far as I can tell from reading GCC's
> documentation [1], __extension__ just supresses warnings from -pedantic
> and such, it does not actually enable a used extension if it conflicts
> with whatever -std= value is passed?
> 
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html
> 

Maybe it does, but it's explicit purpose is to allow code to be compiled with
a -std= setting lower than the system libraries.

I was a little surprised to see that -std=c90 doesn't actually enforce C90
compatibility; even with -Wall -Wextra it requires -pedantic to issue
warnings; the same seems to apply to -std=c99 for at least some features that
were included in gnu* standards like anonymous structures and unions.

The latter is probably a particular indication about the desirability of this,
since the extension we are talking about is a relatively obvious extension of
the anonymous struct/union construct!

It is an incredibly useful thing in ABI headers, because it lets you avoid the
"copy/macro this entire structure definition into another."

	-hpa






