Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9785C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 10:34:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4A320851
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 10:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="u8GuuV7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4A320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449m596d9tzDqRy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 21:34:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com; envelope-from=ilya@yadro.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="u8GuuV7b"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449m3V2c1qzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 21:33:26 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D05F241978;
 Fri,  1 Mar 2019 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:content-type:mime-version
 :references:message-id:subject:subject:from:from:date:date
 :received:received:received; s=mta-01; t=1551436393; x=
 1553250794; bh=SgBOCev7fquOYBn+rGjF4SeZo5oGyiBxj5oGIxzi9nw=; b=u
 8GuuV7b0ttH3lhjSWHZXUfPT8/31OLO9WHBO0oE0/4+jmnhrkktmRz+kjG6jE9JX
 bsKqxvBkHV4hmRd98S80Nxy+QLzJoBjbnAtTdvtY7tt1tOjFsiu6wyyKgiZ/hZMt
 uZXgDarKnUCWk0Vud9WzsSzJC19SzNs+YYkxQfYJU0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0VujjfGtY6QF; Fri,  1 Mar 2019 13:33:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 54D4941974;
 Fri,  1 Mar 2019 13:33:13 +0300 (MSK)
Received: from localhost (172.17.15.183) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Mar
 2019 13:33:13 +0300
Date: Fri, 1 Mar 2019 13:32:46 +0300
From: =?utf-8?B?0JjQu9GM0Y8g0JrRg9C30L3QtdGG0L7Qsg==?= <ilya@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: DMA & POWER8
Message-ID: <20190301103246.a6elk7ohpmabqyn7@yadro.com>
References: <20190227155702.ngm3l5bjsde2vvrw@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190227155702.ngm3l5bjsde2vvrw@yadro.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.15.183]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
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
Cc: a.fomichev@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I'm sorry for previous email content without greeting.

A bit more description… We are working on enabling RDMA over PCIe NTB on
OpenPOWER using https://github.com/ntrdma project. During initialization 
dma_request_channel() founds no available channels. We also found that there no 
channels at all in dma_device_list. This is probably powerpc specific problem.
Could someone explain if that is hardware limitation or arch specific part
should be changed?

Ben, a while ago you answered regarding DMA master on POWER8, may be you have 
idea here also?

Thank you in advance!

Илья Кузнецов <ilya@yadro.com> wrote on Ср [2019-фев-27 18:57:02 +0300]:
>We're trying to use Slave-DMA API of the DMA Engine in the linux kernel on
>POWER8 OpenPOWER platform. And we discovered that dma_request_channel() always fails.
>Does it mean that Turismo hardware does not support Slave-DMA? Or DMA
>subsystem in the linux kernel needs to be fixed, doesn't it?
