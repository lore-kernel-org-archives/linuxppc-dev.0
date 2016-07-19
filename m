Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvFhl3z23zDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 08:53:59 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6JMrL8j035292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 18:53:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r8pgtw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 18:53:56 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 19 Jul 2016 16:53:56 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A19B13E40047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 16:53:53 -0600 (MDT)
Subject: Re: [PATCH] linuxppc/devtree: Parse new DRC mem/cpu/dev device tree
 elements
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <31f35f7c-3129-6bcc-1a0f-37e78aaa2e61@linux.vnet.ibm.com>
 <5786A793.2000504@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 19 Jul 2016 17:53:52 -0500
MIME-Version: 1.0
In-Reply-To: <5786A793.2000504@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1c7303b1-6a3d-2feb-1703-09918e6cce10@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Responses to your remarks about the patch.  Note that I will repost it in
smaller segments later this week.

On 07/13/2016 03:41 PM, Nathan Fontenot wrote:
> On 06/30/2016 04:44 PM, Michael Bringmann wrote:
>> Several properties in the DRC device tree format are replaced by
>> more compact representations to allow, for example, for the encoding
>> of vast amounts of memory, and or reduced duplication of information
>> in related data structures.
>>
>> "ibm,drc-info": This property, when present, replaces the following
>> four properties: "ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
>> and "ibm,drc-power-domains".  This property is defined for all
>> dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
>> are intended to provide a more compact representation, and reduce some
>> search overhead.
>>
>> "ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
>> node representation within the "ibm,dynamic-reconfiguration-memory"
>> property provided by the BMC.  This element format is intended to provide
> 
> BMC?

Just a term for the underlying platform.  I think that it came from a
conversation with another developer.  We can just use 'underlying platform'.

>> +#define	DRCONF_V2_CELL_OFFSET(i)	((i) * DRCONF_V2_CELLS_LEN)
>> +#define	DRCONF_V2_CELL_POSITION(p, i)	\
>> +			(void *)(((char *)(p))+((i) * DRCONF_V2_CELLS_LEN))
>> +#define DYN_MEM_V2_LEN(entries)	(((entries) * DRCONF_V2_CELLS_LEN) + \
>> +				 (1 * sizeof(unsigned int)))
>> +
> 
> These should probably be functions instead of #defines, makes debugging
> the code easier.

6-of-1 or half-a-dozen to me.  The main reason that I made them macros was
to document the size calculation in one place, instead of having it embedded
in multiple locations in the code as was done for the 'ibm,dynamic-memory'
struct parsing.

> 
>> +#define DRCONF_MEM_PRESERVED		0x00000001
>> +#define DRCONF_MEM_PRESERVABLE		0x00000002
>> +#define DRCONF_MEM_PRESERVED_STATE	0x00000004
>> +#define DRCONF_MEM_ASSIGNED		0x00000008
>> +#define DRCONF_MEM_NO_H_MIGRATE_DATA	0x00000010
>> +#define DRCONF_MEM_DRC_INVALID		0x00000020
>> +#define DRCONF_MEM_AI_INVALID		0x00000040
>> +#define DRCONF_MEM_RESERVED		0x00000080
>> +#define DRCONF_MEM_RESERVED_SW		0x80000000
> 
> I'll let others chime in, but we don't use all of these flags, or plan
> to at this point so I'm not sure we need to include definitions for them.

I can cut down the list.  3 were previously defined in this file.  
> 

>>  /*
>> - * Retrieve and validate the ibm,dynamic-memory property of the device tree.
>> + * Read the next memblock set entry from the ibm,dynamic-memory-v2 property
> 
> Just saw this here, ans see that it is used elsewhere. You may want to avoid
> using the term memblock, this already has a meaning in the kernel and may
> cause some confusion.
> 
> Still reviewing this patch, more comments as I review more.
> 
> -Nathan

'memblock' was used by the original comments for 'ibm,dynamic-memory' structures.
I will change them.

> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
