Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9406FB6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 06:12:34 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id p9QJCORa021756
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 00:42:24 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9QJCOCm4436214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 00:42:24 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9QJCN7Z000724
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 00:42:24 +0530
Message-ID: <4EA85B95.9030802@in.ibm.com>
Date: Thu, 27 Oct 2011 00:42:21 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com> <4E943C70.4030106@in.ibm.com>
 <1318428902.3782.9.camel@nimitz> <4EA6D701.3030603@freescale.com>
In-Reply-To: <4EA6D701.3030603@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/11 21:04, Scott Wood wrote:
> On 10/12/2011 09:15 AM, Dave Hansen wrote:
>> On Tue, 2011-10-11 at 18:24 +0530, Suzuki Poulose wrote:
>>> On 10/10/11 23:30, Scott Wood wrote:
>>>> On 10/10/2011 04:56 AM, Suzuki K. Poulose wrote:
>>>>> #if defined(CONFIG_RELOCATABLE)&&   defined(CONFIG_44x)
>>>>> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
>>>>> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
>>>>> #endif
>>>>
>>>> Why is this 44x-specific?
>>>
>>> As of now, we compile with relocations only for the 44x. We could make this
>>> generic once the approach is accepted by everyone and implemented on the other
>>> platforms.
>>
>> This is not the place to enforce that kind of thing.  If
>> CONFIG_RELOCATABLE is only supported on one platform, then do:
>>
>> 	config RELOCATABLE
>> 		depends on 44x
>>
>> and take the 44x reference out of the #ifdef.
>
> ...but please first rename the existing, different CONFIG_RELOCATABLE
> behavior that is currently supported on e500.

Scott,

I have renamed the new type of relocation to RELOCATABLE_PPC32_PIE. The patches
were posted yesterday. Please let me know your thoughts.

Thanks
Suzuki
