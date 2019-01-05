Return-Path: <SRS0=xMQ5=PN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0047AC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 22:45:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AFF222B3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 22:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AFF222B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43XGvs3qr7zDqFt
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jan 2019 09:45:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43XGtD5YxJzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jan 2019 09:44:20 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x05MhkSS014869;
 Sat, 5 Jan 2019 16:43:51 -0600
Message-ID: <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 06 Jan 2019 09:43:46 +1100
In-Reply-To: <20190105175116.GB14238@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box> <20190105175116.GB14238@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
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
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sbest@redhat.com,
 saeedm@mellanox.com, alex.williamson@redhat.com, paulus@samba.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, ogerlitz@mellanox.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-01-05 at 10:51 -0700, Jason Gunthorpe wrote:
> 
> > Interesting.  I've investigated this further, though I don't have as
> > many new clues as I'd like.  The problem occurs reliably, at least on
> > one particular type of machine (a POWER8 "Garrison" with ConnectX-4).
> > I don't yet know if it occurs with other machines, I'm having trouble
> > getting access to other machines with a suitable card.  I didn't
> > manage to reproduce it on a different POWER8 machine with a
> > ConnectX-5, but I don't know if it's the difference in machine or
> > difference in card revision that's important.
> 
> Make sure the card has the latest firmware is always good advice..
> 
> > So possibilities that occur to me:
> >   * It's something specific about how the vfio-pci driver uses D3
> >     state - have you tried rebinding your device to vfio-pci?
> >   * It's something specific about POWER, either the kernel or the PCI
> >     bridge hardware
> >   * It's something specific about this particular type of machine
> 
> Does the EEH indicate what happend to actually trigger it?

In a very cryptic way that requires manual parsing using non-public
docs sadly but yes. From the look of it, it's a completion timeout.

Looks to me like we don't get a response to a config space access
during the change of D state. I don't know if it's the write of the D3
state itself or the read back though (it's probably detected on the
read back or a subsequent read, but that doesn't tell me which specific
one failed).

Some extra logging in OPAL might help pin that down by checking the InA
error state in the config accessor after the config write (and polling
on it for a while as from a CPU perspective I don't knw if the write is
synchronous, probably not).

Cheers,
Ben.


