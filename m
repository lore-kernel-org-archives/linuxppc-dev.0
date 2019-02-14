Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:19:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2BA2229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2BA2229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440Tnx6cWNzDqWG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:19:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440TlH2QbNzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 19:17:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 440TlH0KSVz8sX5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 19:17:15 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 440TlG6F9xz9sMr; Thu, 14 Feb 2019 19:17:14 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=emerson.com
 (client-ip=162.253.133.57; helo=n7.nabble.com;
 envelope-from=sachin.gosavi@emerson.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 440TlG3wbHz9sMp
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2019 19:17:12 +1100 (AEDT)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id 179729BA4E49
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2019 01:17:11 -0700 (MST)
Date: Thu, 14 Feb 2019 01:17:11 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1550132231035-0.post@n7.nabble.com>
In-Reply-To: <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
 <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
 <1550062386389-0.post@n7.nabble.com>
 <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
Subject: Re: Kernel panic when loading the IDE controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> Maybe look around 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?
> id=9a0e77f28b50128df0c9e26ae489e44e29a7270a

>Also look at ide_platform.c. I imagine there must be some way to set it 
>up in your device tree.

I have gone through this before and also tried the pata_platform driver but
no success yet. I haven't found any example that passes the IO ports and IRQ
information through the device tree to the driver code.

Thanks,
Sachin.



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
