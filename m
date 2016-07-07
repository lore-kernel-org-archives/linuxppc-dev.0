Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlSmC3BcYzDqy0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:44:58 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u676i9Oj146532
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 02:44:57 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xme9wf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 02:44:56 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 7 Jul 2016 16:44:54 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8A9ED2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:44:52 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u676iqNn7995700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:44:52 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u676iqJ2010685
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:44:52 +1000
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
 <577D533E.4030605@linux.vnet.ibm.com>
 <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
 <1467872513-sup-7704@x230.ozlabs.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Huy Nguyen
 <huyn@mellanox.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 7 Jul 2016 16:44:51 +1000
MIME-Version: 1.0
In-Reply-To: <1467872513-sup-7704@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8ae21f63-a17e-5b57-3a9a-1c38eae358ed@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/16 16:26, Ian Munsie wrote:
> We could probably use a dedicated error label for all the error paths
> before the pci_dev_put in the main function so we don't need it in every
> error path.

Yep, I've added that.

> If we explicitly match the Vendor + Device ID we will also match the
> networking functions, which we can't do, because before the mode switch
> there *IS* a CAPI VSEC in one of the networking functions and our driver
> would mistake it as a generic accelerator and try to initialise it. We
> could add a comment to this effect to the PCI ID table.

We can match the vendor, device ID *and* class code - unfortunately 
there isn't a macro for this, which makes it a little bit less 
aesthetically pleasing, but I'm pretty sure this works.

I'm not entirely sure how I feel about our current strategy of matching 
on all class 1200 devices (though if it weren't a CAPI device we'd bail 
very quickly...) - my quick grepping tells me we're one of a very small 
set of drivers in the kernel that uses PCI_DEVICE_CLASS.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
