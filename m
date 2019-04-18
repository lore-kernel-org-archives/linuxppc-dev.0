Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1FC10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412BB2183E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhYX69b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412BB2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lJkB16zNzDqSG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:45:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lJfj6dRWzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 22:42:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FVaqqPnygq1+XAL2fV0XyKGzQwLVOq4vtfOZzXdI+DY=; b=mhYX69b7VKfQqcoKdU0MCUDY48
 wz7J5q7ip7jfFijvK+A2ZbRvvIroxJe506D3ZMQrb3CoLvm9xyPHHWa/5V6VVBpMznpOnG3TfkBul
 kz42uT6vbsEoSWFDuxWpELrhXI3brxwrB2rUkFxbS3l/dQ1clL/hYTVu4waRAQlFVAZ3+DkBqFnzm
 gqZN/EwyZolsR5K1343i6maSxSww63KZgfyNN3MAFzgqy9B9T+AHfzMgzbhHjdvpwUt4XzdVhma0k
 h/lt7McRzt4geBfeCA+wuguIFyeSB89NrhZTxPp/AqEhMrzdLLhaX7EmpBQ/MpRtZ2kCWwpclFQTQ
 +L6+vL3A==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hH6N8-0000gI-FO; Thu, 18 Apr 2019 12:42:35 +0000
Date: Thu, 18 Apr 2019 09:42:23 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Avoiding merge conflicts while adding new docs - Was: Re: [PATCH
 00/57] Convert files to ReST
Message-ID: <20190418091526.00e074d1@coco.lan>
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
Cc: linux-fbdev@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 xdp-newbies@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-gpio@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-kbuild@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jon,

Em Mon, 15 Apr 2019 23:55:25 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> I have a separate patch series with do the actual rename and
> adjustment of references. I opted to submit this first, as it
> sounds easier to merge this way, as each subsystem maintainer
> can apply the conversion directly on their trees (or at docs
> tree), avoiding merge conflects.

Based on the number of feedbacks we have about this, I'm
considering to submit a second version of my conversion patch
series that would be doing the rename together with each patch,
adding the rst files to an index file.

However, doing that would produce lots of warnings. We have
already lots of those at linux-next:

	checking consistency... 

	docs/Documentation/accelerators/ocxl.rst: WARNING: document isn't included in any toctree
	docs/Documentation/admin-guide/mm/numaperf.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/allocators.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/attributes.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/bigalloc.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/bitmaps.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/blockgroup.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/blocks.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/checksums.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/directory.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/eainode.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/group_descr.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/ifork.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/inlinedata.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/inodes.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/journal.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/mmp.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/special_inodes.rst: WARNING: document isn't included in any toctree
	docs/Documentation/filesystems/ext4/super.rst: WARNING: document isn't included in any toctree
	docs/Documentation/fmc/index.rst: WARNING: document isn't included in any toctree
	docs/Documentation/gpu/msm-crash-dump.rst: WARNING: document isn't included in any toctree
	docs/Documentation/interconnect/interconnect.rst: WARNING: document isn't included in any toctree
	docs/Documentation/laptops/lg-laptop.rst: WARNING: document isn't included in any toctree
	docs/Documentation/virtual/kvm/amd-memory-encryption.rst: WARNING: document isn't included in any toctree
	docs/Documentation/virtual/kvm/vcpu-requests.rst: WARNING: document isn't included in any toctree

After thinking a little bit and doing some tests, I think a good solution
would be to add ":orphan:" markup to the new .rst files that were not
added yet into the main body (e. g. something like the enclosed example).

That will make Sphinx suppress the:
	"WARNING: document isn't included in any toctree"
warning for the new files, while they're not included at the main indexes.

This way, maintainers can do all the hard work of doing/applying the ReST
file conversion/addition patch series on their own trees, and, once
everything gets merged, submit a patch against the latest docs-next
tree, removing the :orphan: tag and add them to the common index.rst
files.

That should largely avoid merging conflicts.

For example, assuming that someone converts the stuff at
Documentation/accounting and rename the text files there to
RST (I'm actually doing that), he could add the enclosed change on
the top of its index file:

	diff --git a/Documentation/accounting/index.rst b/Documentation/accounting/index.rst
	index e7dda5afa73f..e1f6284b5ff3 100644
	--- a/Documentation/accounting/index.rst
	+++ b/Documentation/accounting/index.rst
	@@ -1,3 +1,5 @@
	+:orphan:
	+
	 ==========
	 Accounting
	 ==========

With would make Sphinx to ignore the subdir index file while
reporting errors. It will still build the documentation, allowing
the developer to test the changes.

One of the advantages is that checking the orphaned docs is as
easy as running:

	$ git grep -l ":orphan:" Documentation/
	...
	Documentation/accounting/index.rst
	...

Making easy for people to check the orphaned files and send a fixup
patch if something got orphaned after the merge window and send a
fixes patches to be applied upstream.

What do you think?

Regards,
Mauro
