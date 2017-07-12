Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7DwP1YKXzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 09:01:41 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6CMwdZn044044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 19:01:39 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3pwtyg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 19:01:38 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 13 Jul 2017 00:01:36 +0100
Subject: Re: [PATCH v2] powerpc/powernv: Enable PCI peer-to-peer
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 brking@linux.vnet.ibm.com, clsoto@linux.vnet.ibm.com
References: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
 <1499899179.2865.42.camel@kernel.crashing.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 18:01:31 -0500
MIME-Version: 1.0
In-Reply-To: <1499899179.2865.42.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <040bff3c-6afd-0e20-2d3c-d26716137eeb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/07/2017 à 17:39, Benjamin Herrenschmidt a écrit :
> On Mon, 2017-06-26 at 20:08 +0200, Frederic Barrat wrote:
>> +       if (desc & OPAL_PCI_P2P_ENABLE) {
>> +               pe_init->p2p_initiator_count++;
>> +       } else {
>> +               if (pe_init->p2p_initiator_count > 0) {
>> +                       pe_init->p2p_initiator_count--;
>> +                       if (!pe_init->p2p_initiator_count)
>> +                               pnv_pci_ioda2_set_bypass(pe_init, true);
>> +               }
> 
> So you have the initiator refcounting in Linux and the target
> refcounting in OPAL ... any reason for that ?

The initiator refcount is per PE and skiboot doesn't track PEs. Also 
when the initiator refcount falls back to 0, we should restore the 
default bypass setting for the TVE, and that's more easily done from 
linux, since it knows the start and end address of the memory. So for 
those reasons, I don't really have the choice, the initiator refcount 
seems better suited in linux.

The target refcount is per PHB and it just seemed easier to keep it in opal.

Does the lack of symmetry bother you?

   Fred
