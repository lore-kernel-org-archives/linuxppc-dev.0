Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 08B8AB6F7C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 06:16:30 +1100 (EST)
Message-ID: <4EA85C85.7090404@freescale.com>
Date: Wed, 26 Oct 2011 14:16:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Suzuki Poulose <suzuki@in.ibm.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com> <4E943C70.4030106@in.ibm.com>
 <1318428902.3782.9.camel@nimitz> <4EA6D701.3030603@freescale.com>
 <4EA85B95.9030802@in.ibm.com>
In-Reply-To: <4EA85B95.9030802@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
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

On 10/26/2011 02:12 PM, Suzuki Poulose wrote:
> On 10/25/11 21:04, Scott Wood wrote:
>> On 10/12/2011 09:15 AM, Dave Hansen wrote:
>>> This is not the place to enforce that kind of thing.  If
>>> CONFIG_RELOCATABLE is only supported on one platform, then do:
>>>
>>>     config RELOCATABLE
>>>         depends on 44x
>>>
>>> and take the 44x reference out of the #ifdef.
>>
>> ...but please first rename the existing, different CONFIG_RELOCATABLE
>> behavior that is currently supported on e500.
> 
> Scott,
> 
> I have renamed the new type of relocation to RELOCATABLE_PPC32_PIE. The
> patches
> were posted yesterday. Please let me know your thoughts.

I think it would make more sense to rename the existing behavior (maybe
something like DYNAMIC_MEMSTART -- if there's even enough overhead to
make it worth being configurable at all), since it's not fully
relocatable and since 64-bit already uses RELOCATABLE to mean PIE.

-Scott
