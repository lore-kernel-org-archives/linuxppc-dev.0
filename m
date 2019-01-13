Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B6DC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 13:07:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4563820836
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 13:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4563820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cxhv1JPMzDqW7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=duwe@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cxgB26p8zDqRJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 00:05:51 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 107)
 id 6548A68C8E; Sun, 13 Jan 2019 14:05:47 +0100 (CET)
Received: from blackhole (p5B0D8EE3.dip0.t-ipconnect.de [91.13.142.227])
 by newverein.lst.de (Postfix) with ESMTPSA id A9EE067329;
 Sun, 13 Jan 2019 14:05:44 +0100 (CET)
Date: Sun, 13 Jan 2019 14:05:38 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190113140512.44eac0e0@blackhole>
In-Reply-To: <20190113123356.GA26056@350D>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <20190112010914.GB10427@350D>
 <20190112084541.GK14180@gate.crashing.org>
 <20190113123356.GA26056@350D>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
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
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 13 Jan 2019 23:33:56 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Sat, Jan 12, 2019 at 02:45:41AM -0600, Segher Boessenkool wrote:
> > On Sat, Jan 12, 2019 at 12:09:14PM +1100, Balbir Singh wrote:
> > > Could you please define interesting frame on top a bit more?
> > > Usually the topmost return address is in LR
> > 
> > There is no reliable way (other than DWARF unwind info) to find out
> > where the value of LR at function entry currently lives (if
> > anywhere). It may or may not be still available in LR, it may or
> > may not be saved to the return stack slot.  It can also live in
> > some GPR, or in some other stack slot.
> > 
> > (The same is true for all other registers).
> > 
> > The only thing the ABI guarantees you is that you can find all
> > stack frames via the back chain.  If you want more you can use some
> > heuristics and do some heroics (like GDB does), but this is not
> > fully reliable.  Using DWARF unwind info is, but that requires big
> > tables.
> >
> 
> Thanks, so are you suggesting that a reliable stack is not possible on
> ppc64le? Even with the restricted scope of the kernel?

The LR value location is _always_ hard to determine for the topmost
frame. This is not a problem for voluntarily sleeping tasks, because the
topmost function will always be well known. It is a problem for tasks preempted
by an interrupt, or those handling an exception, that's why these need
to report "unreliable".

Note that this is a very general problem, across _all_ RISC-like
architectures. It should thus be handled as generically as possible.

	Torsten

