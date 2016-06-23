Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbBvw1dmlzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 05:52:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NJmwNn079392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:52:57 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qcxg3e3r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:52:57 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 13:52:57 -0600
Date: Thu, 23 Jun 2016 14:52:51 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dan Williams <dan.j.williams@intel.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: update arch_{add,remove}_memory() for radix
References: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87mvmbygdb.fsf@skywalker.in.ibm.com>
 <20160623193739.GA19202@arbab-laptop.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20160623193739.GA19202@arbab-laptop.austin.ibm.com>
Message-Id: <20160623195251.GB19202@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2016 at 02:37:39PM -0500, Reza Arbab wrote:
>Could it be that the functions just need to be renamed 
>hash__create_mapping()/radix__create_mapping() and moved out of #ifdef 
>SPARSEMEM_VMEMMAP?

Or vice-versa, maybe the callers should have been wrapped in the first 
place:

arch_add_memory() {
	...
	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
		vmemmap_create_mapping()
	...
}

arch_remove_memory() {
	...
	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
		vmemmap_remove_mapping()
	...
}

-- 
Reza Arbab
