Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0DBC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:16:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5921927
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5921927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440l2j0BHlzDqYX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:16:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440l0p6DMlzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 05:14:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 440l0p4dhNz8swq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 05:14:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 440l0p3kDFz9s7h; Fri, 15 Feb 2019 05:14:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 440l0n2f87z9s7T
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2019 05:14:48 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5E198AF0B;
 Thu, 14 Feb 2019 18:14:45 +0000 (UTC)
Date: Thu, 14 Feb 2019 19:14:43 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: sgosavi1 <Sachin.Gosavi@emerson.com>
Subject: Re: Kernel panic when loading the IDE controller driver
Message-ID: <20190214191443.5f64bb56@kitsune.suse.cz>
In-Reply-To: <1550132231035-0.post@n7.nabble.com>
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
 <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
 <1550062386389-0.post@n7.nabble.com>
 <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
 <1550132231035-0.post@n7.nabble.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Feb 2019 01:17:11 -0700 (MST)
sgosavi1 <Sachin.Gosavi@emerson.com> wrote:

> > Maybe look around 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?
> > id=9a0e77f28b50128df0c9e26ae489e44e29a7270a  
> 
> >Also look at ide_platform.c. I imagine there must be some way to set it 
> >up in your device tree.  
> 
> I have gone through this before and also tried the pata_platform driver but
> no success yet. I haven't found any example that passes the IO ports and IRQ
> information through the device tree to the driver code.

Hopefully there are examples of passing these values through ACPI.

Thanks

Michal
