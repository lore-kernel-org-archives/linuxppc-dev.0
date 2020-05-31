Return-Path: <SRS0=0EC+=7N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4BDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 20:59:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6D6206A1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 20:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6D6206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allandria.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZrJs3zYszDqSh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2020 06:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=allandria.com
 (client-ip=50.242.82.17; helo=cynthia.allandria.com;
 envelope-from=flar@allandria.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=allandria.com
X-Greylist: delayed 1799 seconds by postgrey-1.36 at bilbo;
 Mon, 01 Jun 2020 06:57:34 AEST
Received: from cynthia.allandria.com (cynthia.allandria.com [50.242.82.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ZrGk09cpzDqQx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2020 06:57:33 +1000 (AEST)
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
 (envelope-from <flar@allandria.com>)
 id 1jfU9M-0007Mf-46; Sun, 31 May 2020 13:01:40 -0700
Date: Sun, 31 May 2020 13:01:40 -0700
From: Brad Boyer <flar@allandria.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
Message-ID: <20200531200140.GA27809@allandria.com>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
 <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au>
 <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>, Finn Thain <fthain@telegraphics.com.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, May 31, 2020 at 10:38:04AM +0200, Geert Uytterhoeven wrote:
> >  arch/m68k/include/asm/adb_iop.h |  1 +
> 
> As this header file is used by a single source file only, perhaps it should
> just be absorbed by the latter?
> Then you no longer need my Acked-by for future changes ;-)

While I don't really feel involved in this specific change (although I
was one of the testers when the driver was first written), I am a little
curious about the current coding standards. This header is pretty much
just a declaration of the hardware interface, of which there are many
in this directory. Is it better to just define all the offsets and bits
for hardware registers inside the driver? We used to always put them in
headers like this, but is that not the current standard? Would it be
cleaner to put such headers in the directory with the driver effectively
making them private? I seem to see quite a bit of that as well.

Thank you for your advice.

	Brad Boyer
	flar@allandria.com

