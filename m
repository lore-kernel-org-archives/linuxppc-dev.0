Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlKWr08h5zDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 11:18:47 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u671E55t033654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 21:18:45 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xj69aj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 21:18:45 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 7 Jul 2016 11:18:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D78DA2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 11:18:39 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u671Id619372094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 11:18:39 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u671IdGD028769
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 11:18:39 +1000
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
 <577D533E.4030605@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 7 Jul 2016 11:18:37 +1000
MIME-Version: 1.0
In-Reply-To: <577D533E.4030605@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for the review Fred!

On 07/07/16 04:51, Frederic Barrat wrote:
>> +    rc = CXL_READ_VSEC_MODE_CONTROL(dev, switch_work->vsec, &val);
>> +    if (rc) {
>> +        dev_err(&bus->dev, "cxl: Failed to read CAPI mode control:
>> %i\n", rc);
>> +        pci_dev_put(dev);
>> +        goto err_free_work;
>> +    }
>> +    devfn = dev->devfn;
>> +    pci_dev_put(dev);
>
> This is to balance the 'get' done in cxl_check_and_switch_mode(), right?
> A comment wouldn't hurt. I think we're missing the 'put' on the first
> error path above (!bridge).

Yep, it's to balance the pci_dev_get() in cxl_check_and_switch_mode() - 
you're right, a comment to that effect wouldn't hurt.

You're also right about the error path. Will fix in V2.

> I was half-expecting to see a new entry in the cxl_pci_tbl pci ID table
> for the Mellanox entry, but no such thing. By what magic is cxl_probe()
> called after the switch? Because of the device class?

It matches against the class, as function 0 of the device after reset 
comes up as a class 1200 processing accelerator.

Perhaps we should be a bit more explicit though...

> Out of curiosity, could you tell me what the 3rd pci function looks like
> (vendor ID, device ID, ....)?

Before:

root@io163:~# lspci -vnn
0000:00:00.0 PCI bridge [0604]: IBM Device [1014:03dc] (prog-if 00 
[Normal decode])
         Flags: fast devsel
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 00000000-00000fff
         Capabilities: [40] Power Management version 3
         Capabilities: [48] Express Root Port (Slot-), MSI 00
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [148] #19

0000:01:00.0 Infiniband controller [0207]: Mellanox Technologies MT27700 
Family [ConnectX-4] [15b3:1013]
         Subsystem: IBM Device [1014:04f4]
         Flags: fast devsel, IRQ 502
         Memory at 200000000000 (64-bit, prefetchable) [disabled] [size=32M]
         Capabilities: [60] Express Endpoint, MSI 00
         Capabilities: [48] Vital Product Data
         Capabilities: [9c] MSI-X: Enable- Count=128 Masked-
         Capabilities: [c0] Vendor Specific Information: Len=18 <?>
         Capabilities: [40] Power Management version 3
         Capabilities: [100] Device Serial Number ba-da-ce-55-de-ad-ca-fe
         Capabilities: [160] Vendor Specific Information: ID=1280 Rev=0 
Len=080 <?>
         Capabilities: [240] #19

0000:01:00.1 Infiniband controller [0207]: Mellanox Technologies MT27700 
Family [ConnectX-4] [15b3:1013]
         Subsystem: IBM Device [1014:04f4]
         Flags: fast devsel, IRQ 502
         Memory at 200002000000 (64-bit, prefetchable) [disabled] [size=32M]
         Capabilities: [60] Express Endpoint, MSI 00
         Capabilities: [48] Vital Product Data
         Capabilities: [9c] MSI-X: Enable- Count=128 Masked-
         Capabilities: [40] Power Management version 3
         Capabilities: [100] Device Serial Number ba-da-ce-55-de-ad-ca-fe

After:

root@io163:~# lspci -vnn
0000:00:00.0 PCI bridge [0604]: IBM Device [1014:03dc] (prog-if 00 
[Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 00000000-00000fff
         Capabilities: [40] Power Management version 3
         Capabilities: [48] Express Root Port (Slot-), MSI 00
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [148] #19

0000:01:00.0 Processing accelerators [1200]: Mellanox Technologies 
MT27700 Family [ConnectX-4] [15b3:1013]
         Subsystem: IBM Device [1014:04f4]
         Physical Slot: Slot3
         Flags: bus master, fast devsel, latency 0, IRQ 502
         Memory at 200004000000 (64-bit, prefetchable) [size=128K]
         Memory at 200004020000 (64-bit, prefetchable) [size=128K]
         Memory at <ignored> (64-bit, prefetchable) [size=256T]
         Capabilities: [60] Express Endpoint, MSI 00
         Capabilities: [48] Vital Product Data
         Capabilities: [9c] MSI-X: Enable- Count=128 Masked-
         Capabilities: [100] Device Serial Number ba-da-ce-55-de-ad-ca-fe
         Capabilities: [160] Vendor Specific Information: ID=1280 Rev=0 
Len=080 <?>
         Kernel driver in use: cxl-pci

0000:01:00.1 Infiniband controller [0207]: Mellanox Technologies MT27700 
Family [ConnectX-4] [15b3:1013]
         Subsystem: IBM Device [1014:04f4]
         Physical Slot: Slot3
         Flags: bus master, fast devsel, latency 0, IRQ 502
         Memory at 200000000000 (64-bit, prefetchable) [size=32M]
         Capabilities: [60] Express Endpoint, MSI 00
         Capabilities: [48] Vital Product Data
         Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
         Capabilities: [40] Power Management version 3
         Capabilities: [100] Device Serial Number ba-da-ce-55-de-ad-ca-fe
         Kernel driver in use: mlx5_core

0000:01:00.2 Infiniband controller [0207]: Mellanox Technologies MT27700 
Family [ConnectX-4] [15b3:1013]
         Subsystem: IBM Device [1014:04f4]
         Physical Slot: Slot3
         Flags: bus master, fast devsel, latency 0, IRQ 502
         Memory at 200002000000 (64-bit, prefetchable) [size=32M]
         Capabilities: [60] Express Endpoint, MSI 00
         Capabilities: [48] Vital Product Data
         Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
         Capabilities: [40] Power Management version 3
         Capabilities: [100] Device Serial Number ba-da-ce-55-de-ad-ca-fe
         Kernel driver in use: mlx5_core

Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
