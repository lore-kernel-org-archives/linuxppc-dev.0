Return-Path: <SRS0=pfuI=TG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A2DC04AAA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 09:03:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C529B20830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 09:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C529B20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yGxd4tRpzDqHh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 19:03:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yGw93Dm5zDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2019 19:02:31 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 90E2F68AFE; Mon,  6 May 2019 11:02:10 +0200 (CEST)
Date: Mon, 6 May 2019 11:02:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/powernv: remove the unused pnv_pci_set_p2p
 function
Message-ID: <20190506090210.GA2064@lst.de>
References: <20190426124917.23789-1-hch@lst.de>
 <20190426124917.23789-2-hch@lst.de>
 <99c4c4a9-8a18-61ed-174a-9ffaec3d2e44@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c4c4a9-8a18-61ed-174a-9ffaec3d2e44@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 06, 2019 at 10:46:11AM +0200, Frederic Barrat wrote:
> Hi,
>
> The PCI p2p and tunnel code is used by the Mellanox CX5 driver, at least 
> their latest, out of tree version, which is used for CORAL. My 
> understanding is that they'll upstream it at some point, though I don't 
> know what their schedule is like.

As said before, we only keep exports in tree for in-tree users.  If the
CX5 driver grows special P2P support it will have to use the proper
existing kernel infrastructure for that anyway.
