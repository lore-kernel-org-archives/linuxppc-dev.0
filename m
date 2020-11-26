Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B2C63798
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 20:43:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E712821D7F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 20:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="AIgsjqpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E712821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChqTs2HMCzDrSH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 07:43:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=arista.com (client-ip=2a00:1450:4864:20::342;
 helo=mail-wm1-x342.google.com; envelope-from=dima@arista.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256
 header.s=googlenew header.b=AIgsjqpK; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChqRG5N0yzDrNx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 07:41:09 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so3603376wmh.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 12:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w6VmA0MSpBNFKGjboKbfCa/RS1kMg4YU1xfmJHUOcVc=;
 b=AIgsjqpKSHy6iapc6qUWhJHXk9u+Nwc98tW17cVqTWiuBOCpFKJaZpwQEDWCESW6xr
 0iiljROZxJuRGRmUFHAaH1o0I/sNmhVoyShowYoaw3F00CV3PJOoFDg34m9tUf2yvVd0
 i/UujVUT8Dz7IVws0tkhRV7l1emZKlAbZccIF7WKte3dZPzzULNEWKbPgnU2OrQ3Z2Cr
 9oIChr6BRPlN8NiA3agWLyOcEXPNg8Fz8eGV5DUDIU0FzgTfahZ91p6KuY/FXlA/mALC
 NaBnnGa09WWPjnkMD32vhePbew0RW6iw+ZNiZ6LEjqsqyWCGzHd5emjEMu5TK5ap3Dwq
 /0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w6VmA0MSpBNFKGjboKbfCa/RS1kMg4YU1xfmJHUOcVc=;
 b=Apl8ii8mhzqz3nRizV8fOQeO+aiPHNzze8vQhttuHthtNcnbIOg05UCmLxXOa5MtZX
 iq4m3hJJewoovIeNg82b/KjHpBB6J3l9dxEB+LHKQpxo4pMAAAJmgcls+bGjKVodHXla
 CI4MKuELk8TisAVcK6Np5gHD5AYgLbTNKQL3WM7F/KDAXDs6cpuwymSu/ME4CaZuUv8N
 dpN8pLrRzpt7VOxLktm618XUYhR2CQSrUf7SeXMkjKUEOp99PN3szuqw4qVQOXVHtBrH
 GlqYL4f0SaXmdQr3pEgPOvrnyvrYGDQHWwieV9uAWP4EQnV1g1K72PZRWsyA79zLHpet
 cw1Q==
X-Gm-Message-State: AOAM531VVINnMceR0hRPjE1zkBWzKQ/JpUG9eoR84MuwmHANRGTZXK2h
 F+FzeihK6rouwDaxdsVAhzvw7Q==
X-Google-Smtp-Source: ABdhPJz+5z7zQSHoNsFLo205RiTl/z0EFCCeqEXT+h/QL8PVpHo2PmiOksSPtmeBdcBQiOBpZlDSNQ==
X-Received: by 2002:a05:600c:ce:: with SMTP id
 u14mr5352854wmm.150.1606423265079; 
 Thu, 26 Nov 2020 12:41:05 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8?
 ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
 by smtp.gmail.com with ESMTPSA id x4sm10879944wrv.81.2020.11.26.12.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2020 12:41:04 -0800 (PST)
Subject: Re: [PATCH v2 00/19] Add generic vdso_base tracking
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org
References: <20201124002932.1220517-1-dima@arista.com>
 <5e315bf6-b03d-e66e-9557-22ece397080e@csgroup.eu>
From: Dmitry Safonov <dima@arista.com>
Message-ID: <dc2b40ca-003f-2621-48d4-ae4a48e94126@arista.com>
Date: Thu, 26 Nov 2020 20:41:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5e315bf6-b03d-e66e-9557-22ece397080e@csgroup.eu>
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 x86@kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Guo Ren <guoren@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On 11/24/20 6:53 AM, Christophe Leroy wrote:
> 
> 
> Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
>> v2 Changes:
>> - Rename user_landing to vdso_base as it tracks vDSO VMA start address,
>>    rather than the explicit address to land (Andy)
>> - Reword and don't use "new-execed" and "new-born" task (Andy)
>> - Fix failures reported by build robot
>>
>> Started from discussion [1], where was noted that currently a couple of
>> architectures support mremap() for vdso/sigpage, but not munmap().
>> If an application maps something on the ex-place of vdso/sigpage,
>> later after processing signal it will land there (good luck!)
>>
>> Patches set is based on linux-next (next-20201123) and it depends on
>> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
>> on my changes in akpm (fixing several mremap() issues).
> 
> I have a series that cleans up VDSO init on powerpc and migrates powerpc
> to _install_special_mapping() (patch 10 of the series).
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=204396&state=%2A&archive=both
> 
> 
> I'm wondering how we should coordinate with your series for merging.
> 
> I guess your series will also imply removal of arch_unmap() ? see
> https://elixir.bootlin.com/linux/v5.10-rc4/source/arch/powerpc/include/asm/mmu_context.h#L262

I think our series intersect only in that moment where I re-introduce
arch_setup_additional_pages() parameters. So, in theory we could
minimize the conflicts by merging both series in parallel and cleanup
the result by moving to generic vdso_base on the top, what do you think?

Thanks,
          Dmitry
