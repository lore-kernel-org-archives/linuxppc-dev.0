Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3FECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 19:08:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035202054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf+6EyNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035202054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hYRY5m1WzF3J9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 06:08:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qf+6EyNn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b41; helo=mail-yb1-xb41.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qf+6EyNn"; 
 dkim-atps=neutral
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hYNg4xmZzF3Hg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 06:05:39 +1100 (AEDT)
Received: by mail-yb1-xb41.google.com with SMTP id d18-v6so907336yba.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FAfIpbbf5i32tB0r0OpipHm6jpAr1/uuQfuj8ItsGRA=;
 b=qf+6EyNnERQ9ISNKEs/mkjInmLhEi3e5XFQKCPEk9Rvbx9WMTSytjprKr1IKEWMkyE
 A0TiP8GXcfT4mMjuooA8trWdBcYRNEQ/SQtCXRR7NON8uqPDwo8QOptKmAfFgOCxe1CI
 dgBYCHD675VdwrtYHgijFyUl7N2oE8TFTqSxb5b3bWIGVo1begYx0OeNs40ZDNGviBm9
 5Fsex7kf8CYy/FXCKbGDTA/QRFfTEZBSYEc2XefNvN7iq03zwPD0x80b0r/6iYQiMk5r
 Aj3UYw43WcYJuAbXOui+EXjE1UDiUD5pN1Z1eXW5ZNPzki6NlRY3P6F/sfP5uidsdlY1
 SbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FAfIpbbf5i32tB0r0OpipHm6jpAr1/uuQfuj8ItsGRA=;
 b=F3RVTD2yq4qnbhKqUYdp1CAtP8uTwrpfi8xgLNf/64iB05GdPDU925XFOmpmqbLfQk
 UI5ax9FbP4vLlFgqBS7wkDi87FqN/WpiVV0dc3RFjTxkyPfs46CU2LyboU3S6pXo70w8
 PhQLrzPVWODHrwdy+wWUHMH01BeFj8SZFv81G4dKvmnFpSXksG3NkUSlX4RW96dHmf5Z
 LzHPmZ1EPAp6z+JsiAxuRoxwIVqugxcY3mH3wtJmiq6HNkronUedcIBfwV4nrtJ3984q
 vuyOkKEwXa6wC+fJ3RC37B3Y+1gigNM/q7UtB8atd8+4CIjVzZ+XI5pVU5Udgg25tF2p
 X2zA==
X-Gm-Message-State: AGRZ1gJzsJKRzk+f/tcZWfPfLYV5klUNeZbx+E3Xf7Zu7GMpFv/tRacd
 AXT5cPwvwQVMGel3zNbW/zo=
X-Google-Smtp-Source: AJdET5dV1IOus9aqQsph3pmNqMsV4bLMRQ4D26c0WAXpjJOwhptLhWUaKk6TE97vVn+BFlm+D9FO6A==
X-Received: by 2002:a25:73c2:: with SMTP id
 o185-v6mr4910563ybc.254.1540580736335; 
 Fri, 26 Oct 2018 12:05:36 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 r5-v6sm6493141ywr.80.2018.10.26.12.05.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Oct 2018 12:05:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
To: Mike Rapoport <rppt@linux.ibm.com>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <20181025093833.GA23607@rapoport-lnx>
 <CAL_JsqL62ttsGSbE1BS5v-mX3pKE-p_HyvuZD6nB+GUbQyetzg@mail.gmail.com>
 <20181025172935.GA27364@rapoport-lnx>
 <CAL_JsqJrMq+QHvuOsqEdCFchmXsd4s2XKUD_TboKzeEQprJvjg@mail.gmail.com>
 <1bb3bd63-a88e-b668-ea36-f0f985c0e2b1@gmail.com>
 <20181026110708.GA3814@rapoport-lnx>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <53ec9df5-ef2a-edc5-be1c-bca32959c0bc@gmail.com>
Date: Fri, 26 Oct 2018 12:05:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026110708.GA3814@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org,
 SH-Linux <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-s390@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 Openrisc <openrisc@lists.librecores.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/26/18 4:07 AM, Mike Rapoport wrote:
> On Thu, Oct 25, 2018 at 04:07:13PM -0700, Florian Fainelli wrote:
>> On 10/25/18 2:13 PM, Rob Herring wrote:
>>> On Thu, Oct 25, 2018 at 12:30 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>>
>>>> On Thu, Oct 25, 2018 at 08:15:15AM -0500, Rob Herring wrote:
>>>>> +Ard
>>>>>
>>>>> On Thu, Oct 25, 2018 at 4:38 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>>>>
>>>>>> On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
>>>>>>> On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> While investigating why ARM64 required a ton of objects to be rebuilt
>>>>>>>> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
>>>>>>>> because we define __early_init_dt_declare_initrd() differently and we do
>>>>>>>> that in arch/arm64/include/asm/memory.h which gets included by a fair
>>>>>>>> amount of other header files, and translation units as well.
>>>>>>>
>>>>>> I think arm64 does not have to redefine __early_init_dt_declare_initrd().
>>>>>> Something like this might be just all we need (completely untested,
>>>>>> probably it won't even compile):
> 
> [ ... ]
>  
>> FWIW, I am extracting the ARM implementation that parses the initrd
>> early command line parameter and the "setup" code doing the page
>> boundary alignment and memblock checking into a helper into lib/ that
>> other architectures can re-use. So far, this removes the need for
>> unicore32, arc and arm to duplicate essentially the same logic.
> 
> Presuming you are going to need asm-generic/initrd.h for that as well,
> using override for __early_init_dt_declare_initrd in arm64 version of
> initrd.h might be the simplest option.

What I am contemplating doing is promote
phys_initrd_start/phys_initrd_size to be global variables (similar to
initrd_start, initrd_end) and have a generic helper function for parsing
the initrd= command line parameter and finally removing
__early_init_dt_declare_initrd() because we could have
early_init_dt_check_for_initrd() just populate
phys_initrd_start/phys_initrd_size directly as well as
initrd_start/initrd_end using __va() to preserve compatibility with
architectures that rely on this. Then I would convert ARM64 to check for
phys_initrd_start which is really what it is is trying to do in
arch/arm64/mm/init.c::arm64_memblock_init().

Does that sound like a reasonable approach?
-- 
Florian
