Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0rh671MnzDrcn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 06:29:26 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIJSr7A139019
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:29:24 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exjf8ba1r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:29:23 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 12:29:22 -0700
Subject: Re: [PATCH v1 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, helgaas@kernel.org,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-4-bryantly@linux.vnet.ibm.com>
 <5a9a3c99-ae38-ac52-415c-fe3c2042acb2@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:29:14 -0600
MIME-Version: 1.0
In-Reply-To: <5a9a3c99-ae38-ac52-415c-fe3c2042acb2@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <d87099af-e6f4-cc1a-d5df-86e00eb48ce4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here we need to set the config_addr as PHYP (platform) 
does not enable the PE until the PE is bound to a VM, 
reason why we disable VF autoprobe.


On 12/17/17 10:34 PM, Alexey Kardashevskiy wrote:
> powernv does this from eeh_ops::probe, and so does pseries_eeh_probe(), do
> you still need this here?
