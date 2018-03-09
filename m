Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyBvP0S3WzF1rZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 14:00:16 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2930A3c147366
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Mar 2018 22:00:12 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gkd0y9mh4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Mar 2018 22:00:11 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 9 Mar 2018 02:59:22 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH] cxl: Perform NULL check for 'cxl_afu *' at various places
 in cxl
In-Reply-To: <afc6ba10-e2de-af7d-7a68-e78b4bc1e496@au1.ibm.com>
References: <20180308100547.2994-1-vaibhav@linux.vnet.ibm.com>
 <afc6ba10-e2de-af7d-7a68-e78b4bc1e496@au1.ibm.com>
Date: Fri, 09 Mar 2018 08:29:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874llqosxq.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for looking into this patch Andrew,

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 08/03/18 21:05, Vaibhav Jain wrote:
>> It is possible for a CXL card to have a valid PSL but no valid
>> AFUs. When this happens we have a valid instance of 'struct cxl'
>> representing the adapter but with its member 'struct cxl_afu *cxl[]'
>> as empty. Unfortunately at many placed within cxl code (especially
>> during an EEH) the elements of this array are passed on to various
>> other cxl functions. Which may result in kernel oops/panic when this
>> 'struct cxl_afu *' is dereferenced.
>> 
>> So this patch puts a NULL check at the beginning of various cxl
>> functions that accept 'struct cxl_afu *' as a formal argument and are
>> called from with a loop of the form:
>> 
>>         for (i = 0; i < adapter->slices; i++) {
>>         	   	afu = adapter->afu[i];
>> 		/* call some function with 'afu' */
>> 	}
>
> Surely in this case adapter->slices should be 0?
Not necessarily, as adapter->slice doesnt take into account AFUs that
fail to init. I saw this issue in one specific case were the only slice
on the card had issued with the AFU descriptor caused CXL init of that
AFU to fail.

>
> We might still need to harden for other cases...
Yes we may need some more hardening especially in our AFU descriptor
parsing code.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
