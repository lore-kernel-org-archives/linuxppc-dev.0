Return-Path: <SRS0=bXCp=74=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 10:16:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A3B206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 10:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtOkR5jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A3B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49lnKb6vhyzDqdl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 20:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::543;
 helo=mail-ed1-x543.google.com; envelope-from=refactormyself@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QtOkR5jf; dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49llBS3HRmzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 18:39:42 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id y6so5593438edi.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=9KYL3/QNGdUfmk+FO2Zw/YosA4y8k6PjID3Uf7sVNdc=;
 b=QtOkR5jfF7lmmFdPdljqkdC04VnCGOnahNDsT9a2uCWPfLVGqPGebsOQohqZdJmAvO
 Q9kerB0b+T23muU/+2Yiydhh1mVDK5jhtS+tyjRqZlsLxmrPjIJOM01J96eIryeRw3nd
 HrsdmS5De7fOFhuWQNR80hKHSC0jWry8ZtylyDvAKaoglk7CLsNrmf8vGjGn6y6BEuUZ
 TCF59RiuSsjizZdHIMC3UqT6ThWx8GgWALJXvI9zMYNkRTAJsji+c1Js19VKRUJKuGHh
 4Dtn9I7UI/WUhNNY7JUZzJ4mgyOTLNMtDgEWW/KBcp4EbsVrQe9+ab2yD4mtTQmFIT/7
 qEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9KYL3/QNGdUfmk+FO2Zw/YosA4y8k6PjID3Uf7sVNdc=;
 b=DP23clyB5HyvDWSgdFnYXK9wPxX1KjCFQ0XTtqwL1fJRPXWSHSEa647QnauLiiztHm
 fDX2qLsZ3m6WxjVCdLwYKmL0f/Emr9axhRTa3meH/1jYZ0QixIfxsOMdsNRQWx3cgTs4
 yPETb644xDplKgQYDjL/JeBFComnc739VXBmtvqqu2v6xUXG06myjSskWcouPkGmuBSf
 CpX7eHmPpaC+wJawy/qW3T1zEHnVLcM5jVjsj/IIMiZrICNYiHwqvGff0rR2bsdwjnei
 7iBX9wgXDrgy3n3Tk9uBvhgVZVF7nqbbhS1e5TfYmFI6R2PtSgT3gLWjNBQJf8XG9M35
 a9/Q==
X-Gm-Message-State: AOAM532SvXllP+4dEd4S57iOqB2Fb6Rg4iqacAnthx4ou5L6IywjueLS
 FT2n2qVbTJL7rcD7fY4a5E2+spbFO/XaNA==
X-Google-Smtp-Source: ABdhPJxLXnD+PnWZMq7OsnU4Mxg6o2Ccm3rgVEepbhXZzGk1RDZts5KG01u8CP0K7rsYZGJjSKF1qg==
X-Received: by 2002:a5d:428e:: with SMTP id k14mr27402732wrq.21.1592209930738; 
 Mon, 15 Jun 2020 01:32:10 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
 by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 01:32:10 -0700 (PDT)
From: refactormyself@gmail.com
To: helgaas@kernel.org
Subject: [PATCH 0/8 v2] PCI: Align return values of PCIe capability and PCI
 accessors
Date: Mon, 15 Jun 2020 09:32:17 +0200
Message-Id: <20200615073225.24061-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
X-Mailman-Approved-At: Mon, 15 Jun 2020 20:10:47 +1000
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
Cc: Don Brace <don.brace@microsemi.com>, linux-pci@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, esc.storagedev@microsemi.com,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, skhan@linuxfoundation.org,
 bjorn@helgaas.com, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>


PATCH 1/8 to 7/8:
PCIBIOS_ error codes have positive values and they are passed down the
call heirarchy from accessors. For functions which are meant to return
only a negative value on failure, passing on this value is a bug.
To mitigate this, call pcibios_err_to_errno() before passing on return
value from PCIe capability accessors call heirarchy. This function
converts any positive PCIBIOS_ error codes to negative generic error
values.

PATCH 8/8:
The PCIe capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
code. The pci accessor on the other hand can only return 0 or any PCIBIOS_
error code.This inconsistency among these accessor makes it harder for
callers to check for errors.
Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all PCIe
capability accessors.

MERGING:
These may all be merged via the PCI tree, since it is a collection of
similar fixes. This way they all get merged at once.

Version 2:
* cc to maintainers and mailing lists
* Edit the Subject to conform with previous style
* reorder "Signed by" and "Suggested by"
* made spelling corrections
* fixed redundant initialisation in PATCH 3/8
* include missing call to pcibios_err_to_errno() in PATCH 6/8 and 7/8


Bolarinwa Olayemi Saheed (8):
  dmaengine: ioatdma: Convert PCIBIOS_* errors to generic -E* errors
  IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors
  IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors
  PCI: Convert PCIBIOS_* errors to generic -E* errors
  scsi: smartpqi: Convert PCIBIOS_* errors to generic -E* errors
  PCI/AER: Convert PCIBIOS_* errors to generic -E* errors
  PCI/AER: Convert PCIBIOS_* errors to generic -E* errors
  PCI: Align return values of PCIe capability and PCI accessorss

 drivers/dma/ioat/init.c               |  4 ++--
 drivers/infiniband/hw/hfi1/pcie.c     | 18 +++++++++++++-----
 drivers/pci/access.c                  |  8 ++++----
 drivers/pci/pci.c                     | 10 ++++++++--
 drivers/pci/pcie/aer.c                | 12 ++++++++++--
 drivers/scsi/smartpqi/smartpqi_init.c |  6 +++++-
 6 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.18.2

