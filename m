Return-Path: <prvs=0625e213bf=bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BPmx3Q6PzF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 10:52:01 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SNmqef115379
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 19:51:58 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h0hra76s6-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 19:51:58 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 17:51:57 -0600
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
 <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
 <87muys3p2v.fsf@morokweng.localdomain>
 <34fd1ae9-9697-ac6c-d6bc-7c25b4515a25@intel.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 ebiederm@xmission.com, arnd@arndb.de
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in pkey_disable_clear()
In-reply-to: <34fd1ae9-9697-ac6c-d6bc-7c25b4515a25@intel.com>
Date: Wed, 28 Mar 2018 20:51:42 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tabvjw1.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Dave Hansen <dave.hansen@intel.com> writes:

> On 03/28/2018 01:47 PM, Thiago Jung Bauermann wrote:
>>>>  	if (flags)
>>>> -		assert(rdpkey_reg() > orig_pkey_reg);
>>>> +		assert(rdpkey_reg() < orig_pkey_reg);
>>>>  }
>>>>
>>>>  void pkey_write_allow(int pkey)
>>> This seems so horribly wrong that I wonder how it worked in the first
>>> place.  Any idea?
>> The code simply wasn't used. pkey_disable_clear() is called by
>> pkey_write_allow() and pkey_access_allow(), but before this patch series
>> nothing called either of these functions.
>> 
>
> Ahh, that explains it.  Can that get stuck in the changelog, please?

Yes, will be in the next version.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
