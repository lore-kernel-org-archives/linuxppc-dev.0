Return-Path: <SRS0=hB4d=WF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5FC433FF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Aug 2019 19:50:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB2E214C6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Aug 2019 19:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB2E214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 464wnV74mVzDqnw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Aug 2019 05:50:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 464wkq19TJzDqkg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2019 05:47:46 +1000 (AEST)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E6191265AE21;
 Fri,  9 Aug 2019 12:47:38 -0700 (PDT)
Date: Fri, 09 Aug 2019 12:47:37 -0700 (PDT)
Message-Id: <20190809.124737.1555857142412327777.davem@davemloft.net>
To: jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v2] ibmveth: Allow users to update reported
 speed and duplex
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190806151524.69d75f8d@cakuba.netronome.com>
References: <1565108588-17331-1-git-send-email-tlfalcon@linux.ibm.com>
 <20190806151524.69d75f8d@cakuba.netronome.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 09 Aug 2019 12:47:38 -0700 (PDT)
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
Cc: tlfalcon@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Tue, 6 Aug 2019 15:15:24 -0700

> On Tue,  6 Aug 2019 11:23:08 -0500, Thomas Falcon wrote:
>> Reported ethtool link settings for the ibmveth driver are currently
>> hardcoded and no longer reflect the actual capabilities of supported
>> hardware. There is no interface designed for retrieving this information
>> from device firmware nor is there any way to update current settings
>> to reflect observed or expected link speeds.
>> 
>> To avoid breaking existing configurations, retain current values as
>> default settings but let users update them to match the expected
>> capabilities of underlying hardware if needed. This update would
>> allow the use of configurations that rely on certain link speed
>> settings, such as LACP. This patch is based on the implementation
>> in virtio_net.
>> 
>> Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
> 
> Looks like this is the third copy of the same code virtio and
> netvsc have :(  Is there a chance we could factor this out into
> helpers in the core?

Yeah, let's stop the duplication of code while we can.

Thomas please perform the consolidation and respin.

Thank you.
