Return-Path: <chandru@in.ibm.com>
Received: from e23smtp08.au.ibm.com (unknown [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2EFDDE2F6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 23:33:15 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n0H4G1TP027376
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 23:16:01 -0500
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0GCHco64419822
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 23:17:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0GCGY9G002452
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 23:16:35 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Fri, 16 Jan 2009 17:46:36 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<200901091637.24658.chandru@in.ibm.com>
	<200901151335.27649.chandru@in.ibm.com>
In-Reply-To: <200901151335.27649.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901161746.36584.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 January 2009 13:35:27 Chandru wrote:
> Hello Dave, From the debug console output, if there is anything you can add
> here, pls let me know.

As we can see from the console output here,  physbase isn't page aligned when 
the panic occurs.  So we could as well send (start_pfn << PAGE_SHIFT) to 
reserve_bootmem_node() instead of physbase. your thoughts ?.

Also end_pfn in mark_reserved_region_for_nid() is defined as 

unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);

Does this refer to the pfn after the area that we are interested in ?.  We have 
atleast two fixes here,  
1. Limit start and end to bdata->node_min_pfn  and bdata->node_low_pfn in 
reserve_bootmem_node() and add comments out in there that the caller of the 
funtion should be aware of how much are they reserving. 
2. send (start_pfn << PAGE_SHIFT) to reserve_bootmem_node() instead of 
physbase. 

Chandru
