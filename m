Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 853A01A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:01:57 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 11 Aug 2015 05:31:54 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AA5CA125805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 05:35:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7B01rRE66322570
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 05:31:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7B01p58003256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 05:31:52 +0530
Date: Mon, 10 Aug 2015 17:17:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 00/42] powerpc/powernv: PCI hotplug suppport
Message-ID: <20150810071722.GA19068@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C83F34.9040306@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C83F34.9040306@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2015 at 04:05:40PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>The series of patches intend to support PCI slot for PowerPC PowerNV platform,
>>which is running on top of skiboot firmware. The patchset requires corresponding
>>changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
>>for review. The PCI slots are exposed by skiboot with device node properties,
>>and kernel utilizes those properties to populated PCI slots accordingly.
>
>
>This does not apply on top of any actual trees I have - torvalds/master,
>powerpc/master, powerpc/next.
>
>The problem patches are (at least):
>powerpc/powernv: Enable M64 on P7IOC
>powerpc/powernv: Release PEs dynamically
>
>What did you base them on (sha1)? It is always worth mentioning.
>

The patchset bases on powerpc/next + below patches that will be merged
prior to this patchset, I think. I tried to avoid conflicts as much as
I can do:

e14f70b powerpc/powernv: compound PE for VFs				<<< EEH Support for VF - END
42f59ac powerpc/eeh: Support error recovery for VF PE
9c1c221 powerpc/powernv: Support PCI config restore for VFs
8ac2231 powerpc/powernv: Support EEH reset for VF PE
a636ce5 powerpc/eeh: Create PE for VFs
a4e56fc powerpc/powernv: EEH device for VF
2f02884 powerpc/eeh: Cache only BARs, not windows or IOV BARs
1888e95 powerpc/pci: Remove VFs prior to PF
0dab41d powerpc/pci: Cache VF index in pci_dn
fdc2d8a PCI: Add pcibios_bus_add_device() weak function
2bcc609 PCI/IOV: Rename and export virtfn_add/virtfn_remove		<<< EEH Support for VF - START
efde611 powerpc/eeh: Disable automatically blocked PCI config

All above patches can be found from linux-ppc mail archive.

Thanks,
Gavin
