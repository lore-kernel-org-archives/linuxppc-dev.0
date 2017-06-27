Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxw6G2f9XzDr3P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 04:52:54 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5RIn6jJ133299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 14:52:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bbskvsqd1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 14:52:51 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 27 Jun 2017 19:52:49 +0100
Subject: Re: [PATCH v2] powerpc/powernv: Enable PCI peer-to-peer
To: David Laight <David.Laight@ACULAB.COM>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mikey@neuling.org" <mikey@neuling.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "clsoto@linux.vnet.ibm.com" <clsoto@linux.vnet.ibm.com>
References: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DD002BE3A@AcuExch.aculab.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 20:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD002BE3A@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4b4ae1e5-a172-c962-65c3-8ee0624b34e3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/06/2017 à 14:32, David Laight a écrit :
> From: Frederic Barrat
>> Sent: 26 June 2017 19:09
>> P9 has support for PCI peer-to-peer, enabling a device to write in the
>> mmio space of another device directly, without interrupting the CPU.
>>
>> This patch adds support for it on powernv, by adding a new API to be
>> called by drivers. The pnv_pci_set_p2p(...) call configures an
>> 'initiator', i.e the device which will issue the mmio operation, and a
>> 'target', i.e. the device on the receiving side.
> ...
> 
> Two questions:
> 
> 1) How does the driver get the correct address to give to the 'initiator'
>     in order to perform an access to the 'target'?

That's left out of this patch intentionally. The assumption is that 
there's some handshake happening between the 2 drivers. But that's an 
area where we could work to make it easier in the future.

> 2) Surely the API call the driver makes should be architecture neutral,
>     returning an error on other architectures.

The point of the patch is just to enable it on p9. I've heard of a more 
generic, on-going effort, at the PCI API level, which would be 
cross-arch. But here we just want to allow it for p9 to allow some early 
drivers to take advantage of it if they choose to.

   Fred


> At least some x86 cpus also support peer-to-peer writes,
> I believe they can work between cpu chips.
> PCIe bridges might support them (or be configurable to support them).
> 
> 	David
> 
