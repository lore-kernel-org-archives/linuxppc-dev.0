Return-Path: <brking@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61017B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 01:42:14 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 26 Jan 2012 07:42:08 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DE3B93E40036
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 07:41:36 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id q0QEfZtT148924
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 07:41:35 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0QEfX2d028502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 07:41:34 -0700
Message-ID: <4F216620.2010509@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2012 08:41:36 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: tlb flushing on Power
References: <4F2160B3.60708@linux.vnet.ibm.com>
In-Reply-To: <4F2160B3.60708@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CC'ing linuxppc-dev...


On 01/26/2012 08:18 AM, Seth Jennings wrote:
> Hey Dave,
> 
> So I submitted the zsmalloc patches to lkml at the beginning
> of the year
> 
> https://lkml.org/lkml/2012/1/9/389
> 
> I found there are two functions Nitin used in the mapping
> functions that are not supported in the powerpc arch:
> set_pte() and __flush_tlb_one().
> 
> set_pte() seems straightforward for the ppc64 case, although
> I think Power does some sort of pte hashing that might convolute
> it a little.
> 
> My real question is how to achieve the function of __flush_tlb_one()
> on Power.  I looked in Docuemntation/cachetlb.txt and it seems like
> the portable tlb flush functions are:
> 
> void flush_tlb_all(void)
> void flush_tlb_mm(struct mm_struct *mm)
> void flush_tlb_range(struct vm_area_struct *vma,
> 			unsigned long start, unsigned long end)
> void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> 
> Of those options, flush_tlb_page() seems the closest to what 
> __flush_tlb_one() does.  However, we don't have a vma argument in
> our context (akaik) to send to it.
> 
> I was wondering if you have any ideas.  Any help is greatly appreciated!
> 
> --
> Seth


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
