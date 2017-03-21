Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnLSt0mnGzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 16:09:01 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L58miJ049839
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 01:08:54 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2qbww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 01:08:54 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 15:08:51 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L58dEo49872960
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 16:08:47 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L58E3C013073
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 16:08:14 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH 2/3] cxl: Introduce afu_desc sysfs attribute
In-Reply-To: <1b3669f3-40f9-b521-d722-a5e2cc915826@linux.vnet.ibm.com>
References: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
 <20170314040606.16894-3-vaibhav@linux.vnet.ibm.com>
 <1b3669f3-40f9-b521-d722-a5e2cc915826@linux.vnet.ibm.com>
Date: Tue, 21 Mar 2017 10:37:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k27jw735.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing the patch Fred!!

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>> +
>> +	if (afu->attr_afud.size > 0) {
>> +		sysfs_attr_init(&afu->attr_afud.attr);
>> +		afu->attr_afud.attr.name = "afu_desc";
>> +		afu->attr_afud.attr.mode = 0444;
>
>
> So I had a long pause here, wondering if we are showing too much 
> information to ANY user. Most of the content of the AFU descriptor is 
> already world-readable through other sysfs attributes, the only ones 
> troubling me are offset 0x50 and 0x58, ie. the page resolution interrupt 
> handling. We currently don't support it (yet), but we need to think 
> about it. A user process, by monitoring offset x50 could get a glimpse 
> of the layout of the address space of other processes. Not the actual 
> content, but at least what addresses are valid. I think that's already 
> too much.
As we discussed "Paged Resolution EA (offset 0x58)" register is write
only should ideally return 0x00  for all reads (need to confirm with
h/w on this). Secondly there isnt much information exposed from register
"Paged Resolution Handle(offset 0x50)" apart from process handle. Lastly
presently Paged-Response Resolution isn't supported for cxl on linux. So,
I think we are safe for the time being.

> Why not just exporting an area only covering 64 bits (and guaranteed not 
> to be all 1's) and call it mmio_check? It would seem safer to me.
AFAIK the minimum granuality that we have is PAGE_SIZE and we cannot mmap
anything less than PAGE_SIZE. Though one exception for hashed paged
table on power, we have an ability to map 4K PFN on 64K hosts but it
isnt supported for radix on P9.

At best I can limit access to first page of the afu descriptor.


-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
