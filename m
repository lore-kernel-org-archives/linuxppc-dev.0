Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55C2C1A072B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 17:43:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 13:13:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E5423125804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 13:16:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P7hfOm1704334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 13:13:42 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P7heHr010155
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 13:13:41 +0530
Date: Thu, 25 Jun 2015 13:13:37 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix vma page prot flags in opal-prd
 driver
Message-ID: <20150625074303.GB4233@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
References: <20150621182616.9866.16633.stgit@drishya>
 <20150625061546.GA4233@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150625061546.GA4233@dirshya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> [2015-06-25 11:45:46]:

[snip]
 
> Hi Ben,
> 
> remap_pfn_range() is the correct method to map the firmware pages
> because we will not have struct page associated with this RAM area.
> 
> We do a memblock_reserve() in early boot and take out this memory from
> kernel and avoid struct page allocation/init for these.

Kindly ignore the this comment.  memblock_reserve() does not
prevent/avoid struct page allocation.  We do have valid struct page
which can be used for mapping.

--Vaidy
