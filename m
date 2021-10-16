Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61049C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 06:41:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BEB61108
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 06:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2BEB61108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HWYSw2SLDz3cLF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 17:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HWYSQ2sT7z2ynq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2021 17:41:08 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HWYSJ4Z1gz9sSL;
 Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgjsS_Egr1BK; Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HWYSJ3TH7z9sSH;
 Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EEA88B765;
 Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id asovUeRSJBBo; Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.36])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 388CC8B763;
 Sat, 16 Oct 2021 08:41:03 +0200 (CEST)
Subject: Re: [PATCH v2 11/13] lkdtm: Fix lkdtm_EXEC_RODATA()
To: Kees Cook <keescook@chromium.org>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <44946ed0340013a52f8acdee7d6d0781f145cd6b.1634190022.git.christophe.leroy@csgroup.eu>
 <202110151432.D8203C19@keescook>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <61a3d2c4-4997-c221-3eef-d74aef5ba584@csgroup.eu>
Date: Sat, 16 Oct 2021 08:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110151432.D8203C19@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/10/2021 à 23:32, Kees Cook a écrit :
> On Thu, Oct 14, 2021 at 07:50:00AM +0200, Christophe Leroy wrote:
>> Behind its location, lkdtm_EXEC_RODATA() executes
>> lkdtm_rodata_do_nothing() which is a real function,
>> not a copy of do_nothing().
>>
>> So executes it directly instead of using execute_location().
>>
>> This is necessary because following patch will fix execute_location()
>> to use a copy of the function descriptor of do_nothing() and
>> function descriptor of lkdtm_rodata_do_nothing() might be different.
>>
>> And fix displayed addresses by dereferencing the function descriptors.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> I still don't understand this -- it doesn't look needed at all given the
> changes in patch 12. (i.e. everything is using
> dereference_function_descriptor() now)

dereference_function_descriptor() only deals with the function address, 
not the function TOC.

do_nothing() is a function. It has a function descriptor with a given 
address (address of .do_nothing) and a given TOC, say TOC1.

lkdtm_rodata_do_nothing() is another function. It has its own function 
descriptor with a given address (address of .lkdtm_rodata_do_nothing) 
and a given TOC, say TOC2.

If we use execute_location(), it will copy do_nothing() function 
descriptor and change the function address to the address of 
lkdtm_rodata_do_nothing(). So it will call lkdtm_rodata_do_nothing() 
with TOC1 instead of calling it with TOC2.

> 
> Can't this patch be dropped?

It is likely that the TOC will be the same for both functions, and 
anyway those functions are so simple that they don't use the TOC at all, 
so yes it would likely work without this patch but from my point of view 
it is incorrect to call one function with the TOC from the descriptor of 
another function.

If you thing we can take the risk, then I'm happy to drop the patch and 
replace it by

	execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing), CODE_AS_IS)

Christophe
