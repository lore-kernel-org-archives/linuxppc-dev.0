Return-Path: <glommer@parallels.com>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 816362C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 20:16:00 +1000 (EST)
Message-ID: <4FF6BA39.4000305@parallels.com>
Date: Fri, 6 Jul 2012 14:13:13 +0400
From: Glauber Costa <glommer@parallels.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420>
 <alpine.DEB.2.00.1207031344240.14703@router.home>
 <alpine.DEB.2.00.1207031535330.14703@router.home>
 <1341392420.18505.41.camel@ThinkPad-T420> <4FF439D0.1000603@parallels.com>
 <1341452486.18505.49.camel@ThinkPad-T420> <4FF54F18.50300@parallels.com>
 <1341480578.23916.7.camel@ThinkPad-T420>
In-Reply-To: <1341480578.23916.7.camel@ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Cc: LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>, Christoph Lameter <cl@linux.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2012 01:29 PM, Li Zhong wrote:
> On Thu, 2012-07-05 at 12:23 +0400, Glauber Costa wrote:
>> On 07/05/2012 05:41 AM, Li Zhong wrote:
>>> On Wed, 2012-07-04 at 16:40 +0400, Glauber Costa wrote:
>>>> On 07/04/2012 01:00 PM, Li Zhong wrote:
>>>>> On Tue, 2012-07-03 at 15:36 -0500, Christoph Lameter wrote:
>>>>>>> Looking through the emails it seems that there is an issue with alias
>>>>>>> strings. 
>>>>> To be more precise, there seems no big issue currently. I just wanted to
>>>>> make following usage of kmem_cache_create (SLUB) possible:
>>>>>
>>>>> 	name = some string kmalloced
>>>>> 	kmem_cache_create(name, ...)
>>>>> 	kfree(name);
>>>>
>>>> Out of curiosity: Why?
>>>> This is not (currently) possible with the other allocators (may change
>>>> with christoph's unification patches), so you would be making your code
>>>> slub-dependent.
>>>>
>>>
>>> For slub itself, I think it's not good that: in some cases, the name
>>> string could be kfreed ( if it was kmalloced ) immediately after calling
>>> the cache create; in some other case, the name string needs to be kept
>>> valid until some init calls finished. 
>>>
>>> I agree with you that it would make the code slub-dependent, so I'm now
>>> working on the consistency of the other allocators regarding this name
>>> string duplicating thing. 
>>
>> If you really need to kfree the string, or even if it is easier for you
>> this way, it can be done. As a matter of fact, this is the case for me.
>> Just that your patch is not enough. Christoph has a patch that makes
>> this behavior consistent over all allocators.
> 
> Sorry, I didn't know that. Seems I don't need to continue the half-done
> work in slab. If possible, would you please give me a link of the patch?
> Thank you. 
> 

Sorry for the delay. In case you haven't found it out yourself yet:

http://www.spinics.net/lists/linux-mm/msg36149.html

Please not this posted patch as is has a bug.

I do believe that your take on the aliasing code adds value to it. But
as I've already said once, might have to dig a bit deeper in that to get
to end of the rabbit hole.
