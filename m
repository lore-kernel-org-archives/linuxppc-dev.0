Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skDsg4g1nzDrWP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 07:45:42 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RLgx88073536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 17:45:40 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25qu85fwnm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 17:45:39 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 28 Sep 2016 07:45:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DFFB63578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 07:45:33 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RLjXDb4587784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 07:45:33 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RLjXW2016854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 07:45:33 +1000
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to pci_update_resource()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Bjorn Helgaas <helgaas@kernel.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, clsoto@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Sep 2016 07:45:32 +1000
In-Reply-To: <20160927192003.GA14642@localhost>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160927192003.GA14642@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1475012732.2857.293.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-27 at 14:20 -0500, Bjorn Helgaas wrote:
> On Mon, Sep 19, 2016 at 09:53:30AM +1000, Gavin Shan wrote:
> > In pci_update_resource(), the PCI device's memory decoding (0x2 in
> > PCI_COMMAND) is disabled when 64-bits memory BAR is updated if the
> > PCI device's memory space wasn't asked to be always on by @pdev->
> > mmio_always_on. The PF's memory decoding might be disabled when
> > updating its IOV BARs in the following path. Actually, the PF's
> > memory decoding shouldn't be disabled in this scenario as the PF
> > has been started to provide services:
> 
> The reason we disable memory decoding while updating a 64-bit BAR is
> because we can't do the update atomically, and a half-updated BAR might
> conflict with other devices.
> 
> You need to explain what is special about these SR-IOV BARs that makes it
> safe to update them non-atomically while decoding is enabled.

The IOV BAR won't decode until SR-IOV is enabled right ? Gavin, I don't
think we update it "live", so it should be safe...

Cheers,
Ben.
