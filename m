Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A13C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Aug 2021 04:54:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE5E61184
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Aug 2021 04:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCE5E61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgtS00LN6z3cLX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Aug 2021 14:54:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgtRb21Mjz300x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Aug 2021 14:54:00 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GgtRQ4Drfz9sV2;
 Fri,  6 Aug 2021 06:53:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VObFj0xlKBw1; Fri,  6 Aug 2021 06:53:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GgtRQ31z0z9sSt;
 Fri,  6 Aug 2021 06:53:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D0DFC8B7FE;
 Fri,  6 Aug 2021 06:53:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 343h2AQwUROS; Fri,  6 Aug 2021 06:53:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E4C8A8B7FD;
 Fri,  6 Aug 2021 06:53:49 +0200 (CEST)
Subject: Re: [PATCH v4] soc: fsl: qe: convert QE interrupt controller to
 platform_device
To: Saravana Kannan <saravanak@google.com>, Maxim Kochetkov <fido_max@inbox.ru>
References: <20210803113538.560277-1-fido_max@inbox.ru>
 <CAGETcx8QC+AMXvmk4RB=LGp00QLVVX4uCeeruAjFnGq_irMh4Q@mail.gmail.com>
 <dff603dc-9038-71cb-bfcb-5abc24f17109@inbox.ru>
 <CAGETcx-evuv-A+A5v3-ubFZNvn_i+QSvg+tSW0OOgAd82-pytg@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dc3411e9-d1e0-8a23-5d9b-1aee3880b4f7@csgroup.eu>
Date: Fri, 6 Aug 2021 06:53:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-evuv-A+A5v3-ubFZNvn_i+QSvg+tSW0OOgAd82-pytg@mail.gmail.com>
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
Cc: kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Dan Carpenter <dan.carpenter@oracle.com>, qiang.zhao@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 06/08/2021 à 06:39, Saravana Kannan a écrit :
> On Thu, Aug 5, 2021 at 9:35 PM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>>
>> 03.08.2021 20:51, Saravana Kannan wrote:
>>>> So lets convert this driver to simple platform_device with probe().
>>>> Also use platform_get_ and devm_ family function to get/allocate
>>>> resources and drop unused .compatible = "qeic".
>>> Yes, please!
>>
>> Should I totally drop { .type = "qeic"}, or keep?
> 
> Sorry for the confusion. My "Yes, please"!" was a show of support for
> switching this to a proper platform driver. Not a response to that
> specific question.
> 
> I didn't look at the code/DT close enough to know/care about the "type" part.
> 

As far as I understand, Leo told it needs to remain, based on his answer below:

"From the original code, this should be type = "qeic".  It is not
defined in current binding but probably needed for backward
compatibility."


Christophe
