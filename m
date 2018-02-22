Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znChg6Q6kzF16q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:04:51 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MC4T9P056466
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 07:04:49 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9urjvpyg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 07:04:46 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 12:04:43 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w1MC4fq247972596
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 12:04:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEA49A4053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 11:57:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5031A4055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 11:57:50 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 11:57:50 +0000 (GMT)
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
To: linuxppc-dev@lists.ozlabs.org
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
 <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
 <1519271512.2867.14.camel@au1.ibm.com>
 <CAKTCnzkjbNVxBVTKmffbxsyqMb83y2tXN1Xv4Zm3VT+sxePdpg@mail.gmail.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 13:04:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAKTCnzkjbNVxBVTKmffbxsyqMb83y2tXN1Xv4Zm3VT+sxePdpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4dcaa501-233c-0b61-bff6-a86ae84b320b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>> Yeah, I think metadata will evolve for a while till it settle's down.
>>> Since ocxl_ioctl_get_metadata is exposed via uapi, a newer program
>>> calling an older kernel will never work, since the size of that
>>> struct
>>> will always be larger than what the OS supports and our
>>> copy_to_user()
>>> will fail. The other option is for the user program to try all
>>> possible versions till one succeeds, that is bad as well. I think
>>> there are a few ways around it, if we care about this combination.
>>>
>>> Balbir Singh.
>>>
>>
>> We have a number of reserved members at the end of the struct which can
>> be re-purposed for future information (with a corresponding bump of the
>> version number).
> 
> Good point, agreed


I initially had reservations about using an ioctl command for various 
AFU/context parameters because extensibility is going to be a pain. With 
the current reserved fields and versioning, we're ok for some time 
(version handling will remain a bit of a pain but that's life). I agree 
it helps the library by making things more light weight compared to 
sysfs. But if we need to add parameters in the future, we should keep 
sysfs as an option, especially if it's for rarely used parameters, i.e. 
not something we'll need immediately after an open().

   Fred
