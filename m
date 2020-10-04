Return-Path: <SRS0=Om5s=DL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED904C41604
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2020 00:04:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05363206C9
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2020 00:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05363206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C3kW43qpyzDqRw
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2020 11:04:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3kTD69gSzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Oct 2020 11:03:10 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 21E9F11E3E4CA;
 Sat,  3 Oct 2020 16:46:17 -0700 (PDT)
Date: Sat, 03 Oct 2020 17:03:03 -0700 (PDT)
Message-Id: <20201003.170303.263984023177569654.davem@davemloft.net>
To: vladimir.oltean@nxp.com
Subject: Re: [PATCH v4 net-next 0/2] Add Seville Ethernet switch to T1040RDB
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201002134106.3485970-1-vladimir.oltean@nxp.com>
References: <20201002134106.3485970-1-vladimir.oltean@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [2620:137:e000::1:9]);
 Sat, 03 Oct 2020 16:46:17 -0700 (PDT)
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
Cc: devicetree@vger.kernel.org, andrew@lunn.ch, madalin.bucur@oss.nxp.com,
 netdev@vger.kernel.org, radu-andrei.bulie@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, fido_max@inbox.ru,
 robh+dt@kernel.org, paulus@samba.org, kuba@kernel.org, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri,  2 Oct 2020 16:41:04 +0300

> Seville is a DSA switch that is embedded inside the T1040 SoC, and
> supported by the mscc_seville DSA driver inside drivers/net/dsa/ocelot.
> 
> This series adds this switch to the SoC's dtsi files and to the T1040RDB
> board file.
> 
> I would like to send this series through net-next. There is no conflict
> with other patches submitted to T1040 device tree. Maybe this could at
> least get an ACK from devicetree maintainers.

Series applied, thank you.
