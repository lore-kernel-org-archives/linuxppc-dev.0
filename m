Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0rhv73GGzDsRt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 06:30:07 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIJSsC3059985
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:30:03 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exkbf1b6e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:30:02 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 12:30:02 -0700
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
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:29:54 -0600
MIME-Version: 1.0
In-Reply-To: <4ea33f2e-d98c-85ef-eedf-2e8ca49aa839@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <8bdf7127-a3ec-1c75-2593-e39a8bd31e34@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is PF only path. Yes either we have a root returned otherwise
will fall back to iomem_resource.


On 12/18/17 1:21 AM, Alexey Kardashevskiy wrote:
> @dev here is a VF, right? I am not familiar with powervn much but from what
> I see - the devices are sitting on a root bus of their own PHB and they all
> either have a root returned from pci_find_parent_resource() or none of them
> has a root and will fall back to &iomem_resource, or both cases are possible?
