Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830EBC2BD09
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2024 05:34:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8nLY0FkGz3fqB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2024 15:34:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8nL51dsmz3d8B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2024 15:33:48 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1840168C4E; Thu, 27 Jun 2024 07:33:44 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:33:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 04/13] fs/dax: Add dax_page_free callback
Message-ID: <20240627053343.GD14837@lst.de>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com> <e626eda568267e1f86d5c30c24bc62474b45f6c3.1719386613.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e626eda568267e1f86d5c30c24bc62474b45f6c3.1719386613.git-series.apopple@nvidia.com>
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
Cc: linmiaohe@huawei.com, nvdimm@lists.linux.dev, jack@suse.cz, david@redhat.com, djwong@kernel.org, dave.hansen@linux.intel.com, david@fromorbit.com, peterx@redhat.com, linux-mm@kvack.org, will@kernel.org, hch@lst.de, dave.jiang@intel.com, vishal.l.verma@intel.com, linux-doc@vger.kernel.org, willy@infradead.org, jgg@ziepe.ca, catalin.marinas@arm.com, linux-ext4@vger.kernel.org, ira.weiny@intel.com, jhubbard@nvidia.com, npiggin@gmail.com, linux-cxl@vger.kernel.org, bhelgaas@google.com, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org, tytso@mit.edu, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, logang@deltatee.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 27, 2024 at 10:54:19AM +1000, Alistair Popple wrote:
> When a fs dax page is freed it has to notify filesystems that the page
> has been unpinned/unmapped and is free. Currently this involves
> special code in the page free paths to detect a transition of refcount
> from 2 to 1 and to call some fs dax specific code.
> 
> A future change will require this to happen when the page refcount
> drops to zero. In this case we can use the existing
> pgmap->ops->page_free() callback so wire that up for all devices that
> support FS DAX (nvdimm and virtio).

Given that ->page_ffree is only called from free_zone_device_folio
and right next to a switch on the the type, can't we just do the
wake_up_var there without the somewhat confusing indirect call that
just back in common code without any driver logic?

