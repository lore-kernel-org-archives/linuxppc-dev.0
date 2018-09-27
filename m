Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5FC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 18:22:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DC221708
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="DoP2xIca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DC221708
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ljnl6Q80zF38p
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 04:22:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.b="DoP2xIca";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.73; helo=rcdn-iport-2.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="DoP2xIca"; 
 dkim-atps=neutral
X-Greylist: delayed 646 seconds by postgrey-1.36 at bilbo;
 Fri, 28 Sep 2018 04:19:50 AEST
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LjlB3LC8zF37d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 04:19:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=843; q=dns/txt; s=iport;
 t=1538072390; x=1539281990;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=cAG8rOD6AL/BWLmyRIVLF6FwD6JtQPyY8cfvn+rw6AM=;
 b=DoP2xIcaiZhOkUr6PhlZQSbf7BMlHyKAyWGWuketCWunge8dIvGItlCr
 ozjmu821CwFw6w0TiRyezJDDTTmMnM2GRCRm/8/O66j4iOV6cmgq0+Dks
 fb0ptZwz0tMEFDkCbPDvqdy5osUyYsEXB3g4lCELw1ClG7PYcAkfSaJGv w=;
X-IronPort-AV: E=Sophos;i="5.54,311,1534809600"; d="scan'208";a="461535457"
Received: from alln-core-10.cisco.com ([173.36.13.132])
 by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2018 18:08:56 +0000
Received: from [10.24.65.89] ([10.24.65.89])
 by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id w8RI8pMg000694;
 Thu, 27 Sep 2018 18:08:54 GMT
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Maksym Kokhan <maksym.kokhan@globallogic.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <3320a561-2287-63f7-2162-84a639a22a8a@cisco.com>
Date: Thu, 27 Sep 2018 11:08:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Outbound-SMTP-Client: 10.24.65.89, [10.24.65.89]
X-Outbound-Node: alln-core-10.cisco.com
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
Cc: linux-mips <linux-mips@linux-mips.org>,
 linux-efi <linux-efi@vger.kernel.org>, Ruslan Bilovol <rbilovol@cisco.com>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>,
 Frank Rowand <frowand.list@gmail.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Devicetree List <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Bordunov <aborduno@cisco.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927180851.taMdWhdyT-4dg4dzK4WTFJLa7I-56bPGiSlShLunXyg@z>

On 09/27/2018 10:05 AM, Ard Biesheuvel wrote:
> On 27 September 2018 at 18:55, Maksym Kokhan
> <maksym.kokhan@globallogic.com> wrote:
>> There were series of patches [1] for 4.3.0-rc3, that allowed
>> architectures to use a generic builtin command line. I have rebased
>> these patches on kernel 4.19.0-rc4.
>>
> 
> Could you please elaborate on the purpose of this series? Is it simply
> to align between architectures? Does it solve an actual problem?

1) It removed a lot of code duplication between architecture

2) At Cisco we have issues where our bootloaders having default boot 
arguments. Some platforms we can't update the boot loader and it's 
helpful to be able to have boot arguments which are prepended to the 
bootloader arguments , and some parameters which are appended. These 
changes allow that.

Daniel
