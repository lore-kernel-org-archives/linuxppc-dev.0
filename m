Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2Ghf60v3zF08L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 14:04:50 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBL2x7nV046325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 22:04:48 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2f02am64qf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 22:04:47 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 20:04:47 -0700
Subject: Re: [PATCH v1 7/7] pseries/setup: Add Initialization of VF Bars
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, helgaas@kernel.org,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-8-bryantly@linux.vnet.ibm.com>
 <4ea33f2e-d98c-85ef-eedf-2e8ca49aa839@ozlabs.ru>
 <8bdf7127-a3ec-1c75-2593-e39a8bd31e34@linux.vnet.ibm.com>
 <fd876ee1-4c12-587b-a8a0-56233fea3401@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 21:04:38 -0600
MIME-Version: 1.0
In-Reply-To: <fd876ee1-4c12-587b-a8a0-56233fea3401@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <a9ef0e7f-c005-f52f-e707-92d9c7ba8d4c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/17 12:38 AM, Alexey Kardashevskiy wrote:

> On 19/12/17 06:29, Juan Alvarez wrote:
>> This is PF only path. Yes either we have a root returned otherwise
>> will fall back to iomem_resource.
> You have removed context from my response, do not do that please.

My apologies. I will not do that.

>
> When will you have root and when you won't? imho it should always be either
> one or another.
>
Yes you are correct. The resource is carved out of a different mmio 
space and will never be passed in the assigned-addresses property in 
the device node of PF.

We will remove that function call, conditional check and set root accordingly.

>> On 12/18/17 1:21 AM, Alexey Kardashevskiy wrote:
>>> @dev here is a VF, right? I am not familiar with powervn much but from what
>>> I see - the devices are sitting on a root bus of their own PHB and they all
>>> either have a root returned from pci_find_parent_resource() or none of them
>>> has a root and will fall back to &iomem_resource, or both cases are possible?
>
- Juan 
