Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3467C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 06:46:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233DF20881
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 06:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JMZ+vLjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233DF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qrNj5zHpzDqR5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="JMZ+vLjQ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qrLX1SbGzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 17:44:20 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qrLS1Crsz9v0QW;
 Thu, 31 Jan 2019 07:44:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=JMZ+vLjQ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GE1BryDiLvL6; Thu, 31 Jan 2019 07:44:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qrLR6vTNz9v0QV;
 Thu, 31 Jan 2019 07:44:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548917056; bh=cOJiyexC4RhzV3nLmw1xVDcK744oiB5d7rgry5+gXoM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JMZ+vLjQ76kryo0d4/3v/CDV0aIlsMdhbsiuclC0eKE0XnqOavCGYfranMcArXvgZ
 dV45OC8eZ/80eWqgb+hc9/o9z1Khd3UH2cqOEZvxMsXqASyrcPNuh48OKAIU0LEGhU
 t5oaxwZcm23sWI0poHri1Vgox0AoX9rAx2aliPUM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BA4FF8B78E;
 Thu, 31 Jan 2019 07:44:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ETfFXp9TLqKY; Thu, 31 Jan 2019 07:44:16 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8915D8B74C;
 Thu, 31 Jan 2019 07:44:14 +0100 (CET)
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
Date: Thu, 31 Jan 2019 07:44:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131064139.GB28876@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Petr Mladek <pmladek@suse.com>, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 devicetree@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 31/01/2019 à 07:41, Mike Rapoport a écrit :
> On Thu, Jan 31, 2019 at 07:07:46AM +0100, Christophe Leroy wrote:
>>
>>
>> Le 21/01/2019 à 09:04, Mike Rapoport a écrit :
>>> Add check for the return value of memblock_alloc*() functions and call
>>> panic() in case of error.
>>> The panic message repeats the one used by panicing memblock allocators with
>>> adjustment of parameters to include only relevant ones.
>>>
>>> The replacement was mostly automated with semantic patches like the one
>>> below with manual massaging of format strings.
>>>
>>> @@
>>> expression ptr, size, align;
>>> @@
>>> ptr = memblock_alloc(size, align);
>>> + if (!ptr)
>>> + 	panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
>>> size, align);
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
>>> Acked-by: Paul Burton <paul.burton@mips.com>	     # MIPS
>>> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
>>> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
>>> ---
>>
>> [...]
>>
>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index 7ea5dc6..ad94242 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>
>> [...]
>>
>>> @@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>>>   		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>>>   						__pa(MAX_DMA_ADDRESS),
>>>   						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>> +	if (!sparsemap_buf)
>>> +		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
>>> +		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
>>> +
>>
>> memblock_alloc_try_nid_raw() does not panic (help explicitly says: Does not
>> zero allocated memory, does not panic if request cannot be satisfied.).
> 
> "Does not panic" does not mean it always succeeds.

I agree, but at least here you are changing the behaviour by making it 
panic explicitly. Are we sure there are not cases where the system could 
just continue functionning ? Maybe a WARN_ON() would be enough there ?

Christophe

>   
>> Stephen Rothwell reports a boot failure due to this change.
> 
> Please see my reply on that thread.
> 
>> Christophe
>>
>>>   	sparsemap_buf_end = sparsemap_buf + size;
>>>   }
>>>
>>
> 
