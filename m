Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0095FB6F93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 02:35:26 +1100 (EST)
Message-ID: <4EA6D701.3030603@freescale.com>
Date: Tue, 25 Oct 2011 10:34:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com> <4E943C70.4030106@in.ibm.com>
 <1318428902.3782.9.camel@nimitz>
In-Reply-To: <1318428902.3782.9.camel@nimitz>
Content-Type: text/plain; charset="UTF-8"
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Suzuki Poulose <suzuki@in.ibm.com>,
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

On 10/12/2011 09:15 AM, Dave Hansen wrote:
> On Tue, 2011-10-11 at 18:24 +0530, Suzuki Poulose wrote:
>> On 10/10/11 23:30, Scott Wood wrote:
>>> On 10/10/2011 04:56 AM, Suzuki K. Poulose wrote:
>>>> #if defined(CONFIG_RELOCATABLE)&&  defined(CONFIG_44x)
>>>> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
>>>> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
>>>> #endif
>>>
>>> Why is this 44x-specific?
>>
>> As of now, we compile with relocations only for the 44x. We could make this
>> generic once the approach is accepted by everyone and implemented on the other
>> platforms. 
> 
> This is not the place to enforce that kind of thing.  If
> CONFIG_RELOCATABLE is only supported on one platform, then do:
> 
> 	config RELOCATABLE
> 		depends on 44x
> 
> and take the 44x reference out of the #ifdef.

...but please first rename the existing, different CONFIG_RELOCATABLE
behavior that is currently supported on e500.

-Scott
