Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7STt4zmlzDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 12:42:26 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0P1csum068732
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 20:42:24 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286b7afwse-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 20:42:24 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 11:42:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 33EB62BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 12:42:15 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0P1g7vr19726438
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 12:42:15 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0P1fgKP009742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 12:41:42 +1100
Date: Wed, 25 Jan 2017 12:41:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Joel Stanley <joel@jms.id.au>,
 "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Validate memcons descriptor and output
 buffer
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1484783570-6298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <87d1fcahct.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d1fcahct.fsf@concordia.ellerman.id.au>
Message-Id: <20170125014117.GB13018@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2017 at 09:21:22PM +1100, Michael Ellerman wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> Currently, it's assumed that memcons and its output buffer are included
>> in the linear mapping. It's not true when "mem=384M" is included in
>> bootargs. The system runs into kernel crash eventually.
>>
>>    # od -x /proc/device-tree/ibm,opal/ibm,opal-memcons
>>    0000000 0000 0000 0b30 0010
>>    0000010
>>
>> This validates memcons descriptor and its output buffer to ensure they
>> are valid in linear mapping. Otherwise, the interface won't be populated
>> to avoid kernel crash during system boot.
>>
>> Cc: stable@vger.kernel.org #3.15+
>> Fixes: bfc36894a48 ("powerpc/powernv: Add OPAL message log interface")
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Hmm.
>
>Arguably the memcons shouldn't be in the linear map at all.
>

Thanks for review. I agree it shouldn't be in linear map as it is for logs
produced by skiboot, not kernel. Currently, the regions (including the
reserved ones) in memblock are covered by linear mapping. As I can see,
there is no flag to differentiate the cases - the region is reserved by
skiboot or kernel itself. With the flag, we can skip mapping the regions
that were reserved by skiboot to linear mapping area in htab_initialize()
or radix_init_pgtable(). I will see if I can introduce on without too much
efforts.

As I can see, the only benefit is to avoid randomly writing to the area
and data corruption, if the region is invisible from linear mapping.

>AFAICS the kernel only ever reads from it, so really it should be
>explicitly mapped, and mapped read only.
>
>That would also fix this problem :D
>

Yes, I think your proposed solution is better. This patch just adds more
checks to avoid the problem, meaning the logs is inaccessible if the buffer
is out of range. With your suggestion, it's still accessible.

I believe the log buffer should be mapped to VMALLOC area. In order to
setup mapping, we need page frame (struct page). However, it's possible
the page frame isn't existing (e.g. with mem= in bootargs).

It seems the best option would be mapping it into IOREMAP area with
ioremap_prot(). No page frame is needed and allow to set the region
to READONLY. Michael, what's your thoughts about this? :-)

Thanks,
Gavin
