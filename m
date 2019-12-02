Return-Path: <SRS0=Td3a=ZY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E03C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC3A206F0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC3A206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Rgrl2fTbzDqNk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 10:13:11 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47RgmJ23rGzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2019 10:09:19 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F6A914DB02A2;
 Mon,  2 Dec 2019 15:09:17 -0800 (PST)
Date: Mon, 02 Dec 2019 15:09:16 -0800 (PST)
Message-Id: <20191202.150916.2303395989063321734.davem@davemloft.net>
To: leoyang.li@nxp.com
Subject: Re: [PATCH v6 00/49] QUICC Engine support on ARM, ARM64, PPC64
From: David Miller <davem@davemloft.net>
In-Reply-To: <CADRPPNSXS95DCpbnEG14tN7H4uxo7kFb8-azMU+MfPStyRcdpQ@mail.gmail.com>
References: <7beef282-1dd8-7c7a-4f6d-d0605d11eab5@kernel.org>
 <fb810251-f444-bd5d-54e3-774d2e1ccdb9@rasmusvillemoes.dk>
 <CADRPPNSXS95DCpbnEG14tN7H4uxo7kFb8-azMU+MfPStyRcdpQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Mon, 02 Dec 2019 15:09:17 -0800 (PST)
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
Cc: timur@kernel.org, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
 oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, qiang.zhao@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 2 Dec 2019 16:56:39 -0600

> On Mon, Dec 2, 2019 at 2:14 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 01/12/2019 17.10, Timur Tabi wrote:
>> > On 11/28/19 8:55 AM, Rasmus Villemoes wrote:
>> >> There have been several attempts in the past few years to allow
>> >> building the QUICC engine drivers for platforms other than PPC32. This
>> >> is yet another attempt.
>> >>
>> >> v5 can be found
>> >> here:https://lore.kernel.org/lkml/20191118112324.22725-1-linux@rasmusvillemoes.dk/
>> >>
>> >
>> > If it helps:
>> >
>> > Entire series:
>> > Acked-by: Timur Tabi <timur@kernel.org>
>>
>> Thanks. I'll leave it to Li Yang whether to apply that - they already
>> all (except for the last-minute build fix) have your R-b.
>>
>> Li Yang, any chance you could pick up these patches so they have plenty
>> of time in -next until 5.6?
> 
> Sure.  I will.  I'm waiting for the Ack from David on the networking side.

Acked-by: David S. Miller <davem@davemloft.net>
