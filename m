Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN5bx6Q90zDvLW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:16:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM0E0pb015528
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:16:09 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26v5j3f5s7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:16:08 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 22 Nov 2016 10:16:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 769612BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:16:03 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAM0G3ps41549872
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:16:03 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAM0G2Io027848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:16:03 +1100
Subject: Re: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access
 timeout
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Stephen Hemminger <sthemmin@microsoft.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 22 Nov 2016 11:15:59 +1100
MIME-Version: 1.0
In-Reply-To: <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9f08836b-d483-e54a-b56d-c4f20d4d1a90@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/11/16 09:05, Bjorn Helgaas wrote:
> Hi Matthew,
>
> On Mon, Nov 21, 2016 at 03:09:49PM -0600, Matthew R. Ochs wrote:
>> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
>> complete. When an access does not complete within this period, a warning
>> is logged and an error returned to the caller.
>>
>> While this default timeout is valid for most hardware, some devices can
>> experience longer access delays under certain circumstances. For example,
>> one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
>> scenario. These types of devices can benefit from an extended timeout that
>> is specific to their hardware constraints.
>>
>> To support per-device VPD access timeouts, pci_set_vpd_timeout() is added
>> as an exported service. PCI devices will continue to default with the 50ms
>> timeout and use a per-device timeout when a driver calls this new service.
>
> Can you include a pointer to something in the spec that's behind the
> default 50ms timeout, or did somebody just pull that number out of the
> air?

It looks like Stephen Hemminger added the 50ms timeout in 1120f8b8169f, 
which seems to indicate that 50ms was chosen because it's longer than 
the 13ms per word that was measured on one device.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
