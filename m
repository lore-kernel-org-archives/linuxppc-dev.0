Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skJ0Y3gX5zDrWZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 10:06:53 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S05pHX040466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 20:06:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qupxjgwt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 20:06:51 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 28 Sep 2016 10:06:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 723602CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 10:06:46 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S06kDj61800700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 10:06:46 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S06j4U011827
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 10:06:46 +1000
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to pci_update_resource()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, clsoto@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Sep 2016 10:06:44 +1000
In-Reply-To: <20160927233749.GA19797@gwshan>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160927192003.GA14642@localhost> <1475012732.2857.293.camel@au1.ibm.com>
 <20160927233749.GA19797@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1475021204.2857.302.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-09-28 at 09:37 +1000, Gavin Shan wrote:
> 
> Yeah, it's safe to update it with memory decoding on. As the function call
> flow I listed in the changelog (as below), nobody should access the IOV BAR
> when pci_update_resource() is called. However, the PF's memory BARs might
> be accessed that time and it's not safe to disable PF's memory decoding.

The problem isn't so much whether anybody accesses the IOV BAR while
it's updated but whether the IOV BAR will decode at all.

IE. The BAR is updated in two steps, 32-bit each. That means that there
is a window where it contains a "bogus" value.

If that bogus value conflicts with another BAR (another BAR of the  PF
or another PF of the same device for example) then there is a risk of
something bad happening if the driver accesses that conflicting
resource during that window.

On the other hand, if the IOV BAR doesn't decode at all while the
update is done, which I think is the case as I believe SR-IOV isn't
enabled during the update (please verify), then we are safe.

Cheers,
Ben.
