Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfY023dzczDqVB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 23:38:42 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFCXwDI135199
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 07:38:40 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27br05h7cg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 07:38:40 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 10:38:36 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8049C1DC0070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 07:38:35 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBFCcYhG35061866
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 10:38:34 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBFCcYGq010804
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 10:38:34 -0200
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
To: Thomas Gleixner <tglx@linutronix.de>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161214232425.GA13182@gwshan> <alpine.DEB.2.20.1612151036340.3470@nanos>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 gabriel@krisman.be, bsingharora@gmail.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 10:38:33 -0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1612151036340.3470@nanos>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58528EC9.3060009@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/15/2016 07:36 AM, Thomas Gleixner wrote:
> On Thu, 15 Dec 2016, Gavin Shan wrote:
>>> static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
>>> {
>>> -	int n, nodes;
>>> +	int n, nodes = 0;
>>>
>>> 	/* Calculate the number of nodes in the supplied affinity mask */
>>> -	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
>>> +	for_each_online_node(n)
>>> 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
>>> 			node_set(n, *nodemsk);
>>> 			nodes++;
>>> 		}
>>> -	}
>>> +
>>
>> It'd better to keep the brackets so that we needn't add them when adding
>> more code into the block next time.
> 
> Removing the brackets is outright wrong. See:
>   https://marc.info/?l=linux-kernel&m=147351236615103
> 
> I'll fix that up when applying the patch.
> 
> Thanks,
> 
> 	tglx
> 

Thanks you all very much for the reviews and comments - lesson learned
about the brackets in multi-line if/for statements!

Thanks for fixing it Thomas.
Cheers,


Guilherme
