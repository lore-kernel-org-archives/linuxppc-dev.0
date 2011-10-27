Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D80881007DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 19:43:34 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p9R8hR5c017689
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 14:13:27 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9R8hRvp3981560
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 14:13:27 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9R8hQnQ002605
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 19:43:27 +1100
Message-ID: <4EA919AE.4020508@in.ibm.com>
Date: Thu, 27 Oct 2011 14:13:26 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com> <4E943C70.4030106@in.ibm.com>
 <1318428902.3782.9.camel@nimitz> <4EA6D701.3030603@freescale.com>
 <4EA85B95.9030802@in.ibm.com> <4EA85C85.7090404@freescale.com>
In-Reply-To: <4EA85C85.7090404@freescale.com>
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

On 10/27/11 00:46, Scott Wood wrote:
> On 10/26/2011 02:12 PM, Suzuki Poulose wrote:
>> On 10/25/11 21:04, Scott Wood wrote:
>>> On 10/12/2011 09:15 AM, Dave Hansen wrote:
>>>> This is not the place to enforce that kind of thing.  If
>>>> CONFIG_RELOCATABLE is only supported on one platform, then do:
>>>>
>>>>      config RELOCATABLE
>>>>          depends on 44x
>>>>
>>>> and take the 44x reference out of the #ifdef.
>>>
>>> ...but please first rename the existing, different CONFIG_RELOCATABLE
>>> behavior that is currently supported on e500.
>>
>> Scott,
>>
>> I have renamed the new type of relocation to RELOCATABLE_PPC32_PIE. The
>> patches
>> were posted yesterday. Please let me know your thoughts.
>
> I think it would make more sense to rename the existing behavior (maybe
> something like DYNAMIC_MEMSTART -- if there's even enough overhead to
> make it worth being configurable at all), since it's not fully
> relocatable and since 64-bit already uses RELOCATABLE to mean PIE.

I think leaving the current behaviour as it is, and adding the PIE as an
additional configuration option would be safe and wouldn't disturb the
existing dependencies. ( CRASH_DUMP etc. depend on RELOCATABLE for archs
which work fine ).

For architectures with smaller TLB sizes, can afford to do the page aligned
old style mapping and not worry about PIE at all.

Thats just my view.

Disclaimer : I  am not an expert in the BookE land.  :-)

Thanks
Suzuki
