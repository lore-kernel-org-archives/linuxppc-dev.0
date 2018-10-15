Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B8C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:57:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4CA20652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4CA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YM5B1PTNzF36D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.244; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0244.hostedemail.com
 [216.40.44.244])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YM390D2qzDqfd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 12:55:32 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0BD57100E806B;
 Mon, 15 Oct 2018 01:55:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rest56_4cb72aaaa3b19
X-Filterd-Recvd-Size: 2553
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf14.hostedemail.com (Postfix) with ESMTPA;
 Mon, 15 Oct 2018 01:55:27 +0000 (UTC)
Message-ID: <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
From: Joe Perches <joe@perches.com>
To: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz
 Fischer <mdf@kernel.org>
Date: Sun, 14 Oct 2018 18:55:25 -0700
In-Reply-To: <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
 <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
 <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
> On 10/14/18 18:06, Joe Perches wrote:
> > On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
> > > From: Frank Rowand <frank.rowand@sony.com>
> > > 
> > > Add test case of two fragments updating the same property.  After
> > > adding the test case, the system hangs at end of boot, after
> > > after slub stack dumps from kfree() in crypto modprobe code.
[]
> > I think this is worse performance than before.
> > 
> > This now walks all entries when before it would
> > return -EINVAL directly when it found a match.
> 
> Yes, it is worse performance, but that is OK.
> 
> This is a check that is done when a devicetree overlay is applied.
> If an error occurs then that means that the overlay was incorrectly
> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> in this patch provides an example of how a bad overlay can be created.
> 
> Once an error was detected, the check could return immediately, or it
> could continue to give a complete list of detected errors.  I chose to
> give the complete list of detected errors.

Swell.  Please describe that in the commit message.


