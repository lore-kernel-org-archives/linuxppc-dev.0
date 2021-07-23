Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DABC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 05:25:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFCB60EB2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 05:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CFCB60EB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWHpD2mNYz30L7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 15:25:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DJcUAYLk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+d1a5770da040865e1867+6543+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=DJcUAYLk; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWHnW6z5zz2yNT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2021 15:24:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Xptyi13HccZ4R8P+AijEDP2b7CXavc6mEvvmsOqoBkY=; b=DJcUAYLk0+dpd/8f5g9HghlA3p
 EeZr7LTFHZmDPgmsgccuMllN8saglU98K+LzeI94X0be9lqlsEPVr/7iAdl5BonTxc0zCc4mQCaU/
 0XS+8rP7eJINp0fVuc4beaxfm32S8rHcaj8NPOZvGL08pLLZQv1cTZgC80Ly2DfcuRWJXGFoiIABb
 VsygBF0zhSBU1IUbpYEnbCV1lbWyvuZiq5uM8z0aocWQeLQIBRN3HYYObC/sX1W3TDAZCehN+t/xD
 l8WwHz5ZdXguLSoAcOt6tdlh3NGabF9wtFkidWDFN08ja2VULxLzDcnQJdYtbuO8u1wcZ8V0Zc6G1
 og1TAruw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m6nfa-00B1E8-GY; Fri, 23 Jul 2021 05:24:27 +0000
Date: Fri, 23 Jul 2021 06:24:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER interrupt during suspend
Message-ID: <YPpShrTa448OpGjA@infradead.org>
References: <CAAd53p6VN0ejKHcTRgj8mZ_iApR=KogpVZ-HkvdoZbJ=Yue98g@mail.gmail.com>
 <20210722222351.GA354095@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722222351.GA354095@bjorn-Precision-5520>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Joerg Roedel <jroedel@suse.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI ENHANCED ERROR HANDLING \(EEH\) FOR POWERPC"
 <linuxppc-dev@lists.ozlabs.org>, Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 22, 2021 at 05:23:51PM -0500, Bjorn Helgaas wrote:
> Marking both of these as "not applicable" for now because I don't
> think we really understand what's going on.
> 
> Apparently a DMA occurs during suspend or resume and triggers an ACS
> violation.  I don't think think such a DMA should occur in the first
> place.
> 
> Or maybe, since you say the problem happens right after ACS is enabled
> during resume, we're doing the ACS enable incorrectly?  Although I
> would think we should not be doing DMA at the same time we're enabling
> ACS, either.
> 
> If this really is a system firmware issue, both HP and Dell should
> have the knowledge and equipment to figure out what's going on.

DMA on resume sounds really odd.  OTOH the below mentioned case of
a DMA during suspend seems very like in some setup.  NVMe has the
concept of a host memory buffer (HMB) that allows the PCIe device
to use arbitrary host memory for internal purposes.  Combine this
with the "Storage D3" misfeature in modern x86 platforms that force
a slot into d3cold without consulting the driver first and you'd see
symptoms like this.  Another case would be the NVMe equivalent of the
AER which could lead to a completion without host activity.

We now have quirks in the ACPI layer and NVMe to fully shut down the
NVMe controllers on these messed up systems with the "Storage D3"
misfeature which should avoid such "spurious" DMAs at the cost of
wearning out the device much faster.
