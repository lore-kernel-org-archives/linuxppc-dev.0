Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E1C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 19:15:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6813A2229E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 19:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6dFSXmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6813A2229E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ywTy2xhYzDqZ3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 06:15:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=fq9p=qs=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z6dFSXmg"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ywS91XS4zDqV9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 06:13:45 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC6FB21B68;
 Mon, 11 Feb 2019 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549912423;
 bh=bXfWZwIpTavcxjFHSjNqtf609+ILqH6i+/QsFhv/OSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z6dFSXmg7U3zznGCk9N6RO+TU1ileez4YKCceweKxQ/BYhoFAagf727lMksYkwOH/
 uxNYqGBGyx9i5TrBclaiGGyEfGnd1fOu5QhfR7zhIVpzxqhJTiXUSQhN3/VUghYv/d
 ctkzlyarDpadBfGtBGiKIHeoCLn3Bo+0NSxTDazI=
Date: Mon, 11 Feb 2019 20:13:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Tull <atull@kernel.org>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
Message-ID: <20190211191341.GA13134@kroah.com>
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
 <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
 <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-fpga@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Moritz Fischer <mdf@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 12:41:40PM -0600, Alan Tull wrote:
> On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> 
> What LTSI's are these patches likely to end up in?  Just to be clear,
> I'm not pushing for any specific answer, I just want to know what to
> expect.

I have no idea what you are asking here.

What patches?  What is "LTSI's"?

confused,

greg k-h
