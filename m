Return-Path: <SRS0=zZlK=UP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9F3C31E49
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Jun 2019 08:47:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BD2216C8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Jun 2019 08:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BD2216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45RSdp3KQHzDr1c
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Jun 2019 18:47:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45RSc721qYzDqyx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2019 18:45:55 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 45RSby1NXQz1rBn0;
 Sun, 16 Jun 2019 10:45:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 45RSby0dMVz1qql1;
 Sun, 16 Jun 2019 10:45:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id fnOwM6JoyojP; Sun, 16 Jun 2019 10:45:49 +0200 (CEST)
X-Auth-Info: fJwPQASbNuDgl/aehkgpQTFNB7ny6jTRKY6YjGIMgoKnJD+r41neojvRQ/CdEYcp
Received: from igel.home (ppp-46-244-189-62.dynamic.mnet-online.de
 [46.244.189.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun, 16 Jun 2019 10:45:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id CF0352C117A; Sun, 16 Jun 2019 10:45:46 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v5 13/16] powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <877e9n9gng.fsf@igel.home>
 <1c271e47-6917-2f29-97b6-f3160ddf5117@c-s.fr>
X-Yow: While my BRAINPAN is being refused service in BURGER KING,
 Jesuit priests are DATING CAREER DIPLOMATS!!
Date: Sun, 16 Jun 2019 10:45:46 +0200
In-Reply-To: <1c271e47-6917-2f29-97b6-f3160ddf5117@c-s.fr> (christophe leroy's
 message of "Sun, 16 Jun 2019 10:01:10 +0200")
Message-ID: <87lfy1apfp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
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
Cc: j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Jun 16 2019, christophe leroy <christophe.leroy@c-s.fr> wrote:

> Le 15/06/2019 à 14:28, Andreas Schwab a écrit :
>> On Feb 21 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>>> index a000768a5cc9..6e56a6240bfa 100644
>>> --- a/arch/powerpc/mm/pgtable_32.c
>>> +++ b/arch/powerpc/mm/pgtable_32.c
>>> @@ -353,7 +353,10 @@ void mark_initmem_nx(void)
>>>   	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
>>>   				 PFN_DOWN((unsigned long)_sinittext);
>>>   -	change_page_attr(page, numpages, PAGE_KERNEL);
>>> +	if (v_block_mapped((unsigned long)_stext) + 1)
>>
>> That is always true.
>>
>
> Did you boot with 'nobats' kernel parameter ?
>
> If not, that's normal to be true, it means that memory is mapped with BATs.

bool + 1 is always true.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
