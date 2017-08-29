Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhTl12qxrzDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 23:19:57 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TDIqcf143728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 09:19:55 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cn6ynrusy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 09:19:54 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 07:19:54 -0600
Subject: Re: [PATCH] powerpc/kernel: Change retrieval of pci_dn
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Bryant G. Ly" <bgly@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 martin.petersen@oracle.com
References: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <20170829062031.hb3pwrnt5pohpr7l@tungsten.ozlabs.ibm.com>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 08:19:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170829062031.hb3pwrnt5pohpr7l@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0bbc434e-a9d2-8887-43fa-a343013cacb1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/29/17 1:20 AM, Sam Bobroff wrote:

> On Mon, Aug 28, 2017 at 11:05:03AM -0500, Bryant G. Ly wrote:
>> For a PCI device it's pci_dn can be retrieved from
>> pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
>> Thus, we should just use the generic function pci_get_pdn_by_devfn
>> to get the pci_dn.
>>
>> Signed-off-by: Bryant G. Ly <bgly@us.ibm.com>
> Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>
> I don't know this area but I tested it using a patched kernel with the
> old and new code together. My test kernel booted fine (in QEMU+KVM) and
> I saw 26 reads and 4 writes, all of which got the same value with either
> code block.
>
> I also checked that the error result in the "not found" case is the same
> as well, which it is, because rtas_{read,write}_config() will return
> PCIBIOS_DEVICE_NOT_FOUND if given a NULL pdn.
>
> So, looks good to me.
>
> Cheers,
> Sam.
>
Thanks for the review Sam!
