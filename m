Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbz6020vTzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:05:12 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v25MwtIP127239
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 18:05:01 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28yu0nxs55-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 18:05:01 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 09:04:58 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C27B43578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:04:54 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v25N4k5050004004
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:04:54 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v25N4MqA004191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:04:22 +1100
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too
 many TCE levels requested
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Mon, 06 Mar 2017 10:03:54 +1100
In-Reply-To: <87innvrj9h.fsf@concordia.ellerman.id.au>
References: <20170222044359.3663-1-aik@ozlabs.ru>
 <87innvrj9h.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488755034.2870.114.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-27 at 22:00 +1100, Michael Ellerman wrote:
> > The alternative would be allocating TCE tables as big as PAGE_SIZE
> > but
> > only using parts of it but this would complicate a bit bits of code
> > responsible for overall amount of memory used for TCE table.
> > 
> > Or kmem_cache_create() could be used to allocate as big TCE table
> > levels
> > as we really need but that API does not seem to support NUMA nodes.
> 
> kmem_cache_alloc_node() ?

Is that 55 bits of address space (ie, 3 indirect levels + 64k pages) ?
Or only 39 (2 indirect level + 64k pages) ?

In the former case, I'm happy to limit the levels to 3 for 64K pages,
55 bits of TCE space is more than enough. 39 isn't however.

Cheers,
Ben.
