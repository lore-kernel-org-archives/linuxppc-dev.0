Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP3Wf0W6PzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:46:05 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G4ir90134554
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:46:03 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28my2r4wbt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:46:03 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 16 Feb 2017 14:46:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 41A6A2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:45:57 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1G4jnd130736490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:45:57 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1G4jOt6013056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:45:24 +1100
Subject: Re: [PATCH 3/3] pci/hotplug/pnv-php: Disable MSI and PCI device
 properly
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1487200954-14681-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 "# v4 . 9+" <stable@vger.kernel.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 16 Feb 2017 15:45:00 +1100
MIME-Version: 1.0
In-Reply-To: <1487200954-14681-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9b2fa48d-c63f-b525-f1fa-3183976963e9@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/17 10:22, Gavin Shan wrote:
> pnv_php_disable_irq() can be called in two paths: Bailing path in
> pnv_php_enable_irq() or releasing slot. The MSI (or MSIx) interrupts
> is disabled unconditionally in pnv_php_disable_irq(). It's wrong
> because that might be enabled by drivers other than pnv-php.
>
> This disables MSI (or MSIx) interrupts and the PCI device only if
> it was enabled by pnv-php. In the error path of pnv_php_enable_irq(),
> we rely on the newly added parameter @disable_device. In the path
> of releasing slot, @pnv_php->irq is checked.
>
> Cc: <stable@vger.kernel.org> # v4.9+
> Fixes: 360aebd85a4c ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
