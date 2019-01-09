Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F63C43612
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A7E2070B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZLJk1WHmzDqfj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 18:25:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZLGy5CQZzDqcS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 18:24:26 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x097O0fb006443;
 Wed, 9 Jan 2019 01:24:01 -0600
Message-ID: <f06efdd89b418ad831ee3a5da766f3f0a584050c.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 09 Jan 2019 18:24:00 +1100
In-Reply-To: <06c4612c-8409-ea7d-4f7c-4c010d8ecc01@ozlabs.ru>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box> <20190105175116.GB14238@ziepe.ca>
 <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
 <06c4612c-8409-ea7d-4f7c-4c010d8ecc01@ozlabs.ru>
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

On Wed, 2019-01-09 at 15:53 +1100, Alexey Kardashevskiy wrote:
> "A PCI completion timeout occurred for an outstanding PCI-E transaction"
> it is.
> 
> This is how I bind the device to vfio:
> 
> echo vfio-pci > '/sys/bus/pci/devices/0000:01:00.0/driver_override'
> echo vfio-pci > '/sys/bus/pci/devices/0000:01:00.1/driver_override'
> echo '0000:01:00.0' > '/sys/bus/pci/devices/0000:01:00.0/driver/unbind'
> echo '0000:01:00.1' > '/sys/bus/pci/devices/0000:01:00.1/driver/unbind'
> echo '0000:01:00.0' > /sys/bus/pci/drivers/vfio-pci/bind
> echo '0000:01:00.1' > /sys/bus/pci/drivers/vfio-pci/bind
> 
> 
> and I noticed that EEH only happens with the last command. The order
> (.0,.1  or .1,.0) does not matter, it seems that putting one function to
> D3 is fine but putting another one when the first one is already in D3 -
> produces EEH. And I do not recall ever seeing this on the firestone
> machine. Weird.

Putting all functions into D3 is what allows the device to actually go
into D3.

Does it work with other devices ? We do have that bug on early P9
revisions where the attempt of bringing the link to L1 as part of the
D3 process fails in horrible ways, I thought P8 would be ok but maybe
not ...

Otherwise, it might be that our timeouts are too low (you may want to
talk to our PCIe guys internally)

Cheers,
Ben.


