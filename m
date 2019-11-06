Return-Path: <SRS0=rI0D=Y6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30224C5DF62
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 03:26:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1040205C9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 03:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1040205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477Bl54KGhzF5NQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 14:26:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 477Bfl4PWgzF5L4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2019 14:22:20 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D732A30E;
 Tue,  5 Nov 2019 19:22:18 -0800 (PST)
Received: from [192.168.225.149] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8D63F719;
 Tue,  5 Nov 2019 19:21:57 -0800 (PST)
Subject: Re: [PATCH V8] mm/debug: Add tests validating architecture page table
 helpers
To: linux-mm@kvack.org
References: <1572240562-23630-1-git-send-email-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3229d68d-0b9d-0719-3370-c6e1df0ea032@arm.com>
Date: Wed, 6 Nov 2019 08:52:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1572240562-23630-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Michal Hocko <mhocko@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mark Brown <broonie@kernel.org>, "Kirill A . Shutemov" <kirill@shutemov.name>,
 Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Sri Krishna chowdary <schowdary@nvidia.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/28/2019 10:59 AM, Anshuman Khandual wrote:
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: | TODO |
> +    |         arc: | TODO |
> +    |         arm: | TODO |
> +    |       arm64: |  ok  |
> +    |         c6x: | TODO |
> +    |        csky: | TODO |
> +    |       h8300: | TODO |
> +    |     hexagon: | TODO |
> +    |        ia64: | TODO |
> +    |        m68k: | TODO |
> +    |  microblaze: | TODO |
> +    |        mips: | TODO |
> +    |       nds32: | TODO |
> +    |       nios2: | TODO |
> +    |    openrisc: | TODO |
> +    |      parisc: | TODO |
> +    |     powerpc: | TODO |
> +    |       ppc32: |  ok  |
> +    |       riscv: | TODO |
> +    |        s390: | TODO |
> +    |          sh: | TODO |
> +    |       sparc: | TODO |
> +    |          um: | TODO |
> +    |   unicore32: | TODO |
> +    |         x86: |  ok  |
> +    |      xtensa: | TODO |
> +    -----------------------

While here, are there some volunteers to test this on any of the
'yet to be tested and supported' platforms ?

- Anshuman
