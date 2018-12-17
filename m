Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C59C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 21:42:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EC521473
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 21:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EC521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JZQ452QWzDqjp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 08:42:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.22; helo=mout.gmx.net;
 envelope-from=gerhard_pircher@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
X-Greylist: delayed 334 seconds by postgrey-1.36 at bilbo;
 Tue, 18 Dec 2018 08:40:43 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JZMb45yRzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 08:40:41 +1100 (AEDT)
Received: from [192.168.10.46] ([88.151.72.164]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeiJ8-1hCDBj1rOY-00qT0g; Mon, 17
 Dec 2018 22:35:01 +0100
Subject: Re: [PATCH 7/8] powerpc/dma: split the two __dma_alloc_coherent
 implementations
To: Christoph Hellwig <hch@lst.de>, Christophe Leroy <christophe.leroy@c-s.fr>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-8-hch@lst.de>
 <de3d6e75-70d6-e1af-f733-b1aeed99d6c5@c-s.fr> <20181217073543.GD1933@lst.de>
From: Gerhard Pircher <gerhard_pircher@gmx.net>
Message-ID: <6de76ffe-8873-30a2-acf6-e6fb483c1aad@gmx.net>
Date: Mon, 17 Dec 2018 22:34:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181217073543.GD1933@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YElZFFincVhMZXzkLKpNnoUBggrRPlRUJt6MdAJNHGVpr+kY0f0
 yNXLQVLjuFCnBqZk27Hsu95Ce/1TO7Oct5kFwVoRom3xfr1+NU9PI9ludVQtdZK+DnKHZ/b
 pDpO3hDcJ1zlDUcaaiNgrZbLroCluDrLPuFZCndbWyJf68tIwVSH26MveuL6lKWdEzDUzmj
 /cyD1i/8Fb2helhp/W/0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sXmYkyuNDjs=:9iLS5uIar3oICWVQQUwCrc
 WT7akvPUeic19T/oOPI85sUdyr7iLphl7M5wRVwGnF9JKrR4f847GXzJySzbctWEdvvwX/K03
 QeMS4OPEhk/MzTsoblz61ajhdeYeI6qJ9Zx9GF9Qz+LJbOAXO5R81xnHx65UMoMObqoGq02tu
 RLqEF7xjHIKouEEubH8kw2IkKg31hLuinQsQau+wiuAF6sHgRNgfNvjYT9a5Noo7eF7QlBoY0
 FFl1teoqG5cHSmBN/Rw8GIcRwYcqoz6Ps6rcOc9Qdl3scJWJyKH0x0HSv8+Iqv8XytGt87NeS
 xfwf43mFonxAiYxOBZproevWAmxEGhmrci76BkwyOMjR1tw55Ee1Ih6SF0J81w+9V4cNnJHzW
 +/RtiLsLmMKoFUofytj5VmEXT52/yj7IN0xxEweJNfi3VxKe1VBHynFjkylXPhA7db1+UwY4Y
 w6IDEdQzd4DEZf/lGy1fwDV8PN1TnqfRX0j3vL6d579pWwVIP6idpfNT9Vlm/pAdOoy2b3XcE
 zI3Yq6EG72rnhpz1Ojm/StQIwNA87I4HD4Ch3vjm2oqerktPgTmTINvBxy9M7rqGV0RoGq9GT
 eIgssdalgzXNLBdPJFBY/S5jWoFTnDxYxYt0ZvGDKekJCFzxmwhyZ+f0rTMIVIJFb2ePt/RRa
 oPbh0Ye3c/ArnKxLOMAk/mD8NlObTxly5+gVrOq/igivRJ2e9X2Awc10vzwMn+UzBU5ah53Kj
 csoTqX9IMAMHq8+NkuTRy5ecNx9+ZUVM4Nn9IMOmfJ3BtFw7xMAhz6LW78M4QpEj0Te2+/nAu
 w2+sXtzSkhIbTJEui/vzZ13ZQ1S3/5F15KZkrefKFhw99VFmWlCNDGOLvGSR3LYl7X9RZMMXD
 5W/UD1DkQk8KjI10rx3GtI7dUq9CoHVjupcjBIV2fyjdbvVRPmvKSru62RrkHsVN0m1biWpv0
 v/qX4bubiQg==
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Christian Lamparter <chunkeey@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Am 2018-12-17 um 08:35 schrieb Christoph Hellwig:
> On Mon, Dec 17, 2018 at 07:51:05AM +0100, Christophe Leroy wrote:
>>
>>
>> Le 16/12/2018 à 18:19, Christoph Hellwig a écrit :
>>> The implemementation for the CONFIG_NOT_COHERENT_CACHE case doesn't share
>>> any code with the one for systems with coherent caches.  Split it off
>>> and merge it with the helpers in dma-noncoherent.c that have no other
>>> callers.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> ---
>>>   arch/powerpc/include/asm/dma-mapping.h |  5 -----
>>>   arch/powerpc/kernel/dma.c              | 14 ++------------
>>
>> Instead of all the ifdefs in dma.c, couldn't we split it
>> in two files, ie dma.c for common parts and dma-coherence.c for specific 
>> stuff ?
> 
> The end goal is to kill dma.c and keep dma-noncoherent.c only with most
> of the code moving to common code.  Here is the current state of that:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.5
> 
> But it still has issues on two tested platforms and isn't ready yet.
I hope that I can give this a try on one of my AmigaOne machines over
Christmas. Unfortunately my main local AmigaOne machine is out of order
and the other one is only remotely accessible, which makes kernel testing
a bit hard. :-)

Gerhard
