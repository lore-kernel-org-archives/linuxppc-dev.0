Return-Path: <SRS0=Xl/Y=I3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F5CC433C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:57:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3846192B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3846192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F89zc6yRSz30Jk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 22:57:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nefkom.net (client-ip=212.18.0.10; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F89zF45rwz2xYt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 22:56:41 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4F89z203Xbz1s3jy;
 Mon, 29 Mar 2021 13:56:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4F89z15Hl9z1r1M8;
 Mon, 29 Mar 2021 13:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id 0FNUX2a-J2oV; Mon, 29 Mar 2021 13:56:28 +0200 (CEST)
X-Auth-Info: nWR6V27iMQF9ig2aZa97r4JZveNCKigm5K0cTjGtV8hbwOnwQh9wQHpDD5U43/X9
Received: from igel.home (ppp-46-244-184-171.dynamic.mnet-online.de
 [46.244.184.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Mon, 29 Mar 2021 13:56:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 585142C3258; Mon, 29 Mar 2021 13:56:28 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64s: power4 nap fixup in C
References: <20210312012044.3660743-1-npiggin@gmail.com>
 <a01d923737cb1d4a603dc5046b67787233051c12.camel@kernel.crashing.org>
 <236a67a4-1609-5fec-3c68-41db02cd1a4c__18973.8760514714$1617008745$gmane$org@csgroup.eu>
X-Yow: I'm an East Side TYPE..
Date: Mon, 29 Mar 2021 13:56:28 +0200
In-Reply-To: <236a67a4-1609-5fec-3c68-41db02cd1a4c__18973.8760514714$1617008745$gmane$org@csgroup.eu>
 (Christophe Leroy's message of "Mon, 29 Mar 2021 11:04:52 +0200")
Message-ID: <87czvikwb7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mär 29 2021, Christophe Leroy wrote:

> Le 29/03/2021 à 10:33, Benjamin Herrenschmidt a écrit :
>> On Fri, 2021-03-12 at 11:20 +1000, Nicholas Piggin wrote:
>>>
>>> +static inline void nap_adjust_return(struct pt_regs *regs)
>>>
>>> +{
>>>
>>> +#ifdef CONFIG_PPC_970_NAP
>>>
>>> +       if (unlikely(test_thread_local_flags(_TLF_NAPPING))) {
>>> +               /* Can avoid a test-and-clear because NMIs do not call this */
>>> +               clear_thread_local_flags(_TLF_NAPPING);
>>> +               regs->nip = (unsigned long)power4_idle_nap_return;
>>> +       }
>> Is this a pointer to a function descriptor or the actual code ?
>> 
>
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -209,4 +209,8 @@ _GLOBAL(power4_idle_nap)
>  	mtmsrd	r7
>  	isync
>  	b	1b
> +
> +	.globl power4_idle_nap_return
> +power4_idle_nap_return:
> +	blr
>  #endif

The problem is not the definition, it is the reference.  In C, a
function symbol always resolves to the address of the descriptor.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
