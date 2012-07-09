Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 315DB2C021B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 11:49:02 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 01:42:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q691f94G53018670
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 11:41:10 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q691mv3M000617
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 11:48:58 +1000
Message-ID: <1341798533.2439.13.camel@ThinkPad-T420>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Glauber Costa <glommer@parallels.com>
Date: Mon, 09 Jul 2012 09:48:53 +0800
In-Reply-To: <4FF6BA39.4000305@parallels.com>
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420>
 <alpine.DEB.2.00.1207031344240.14703@router.home>
 <alpine.DEB.2.00.1207031535330.14703@router.home>
 <1341392420.18505.41.camel@ThinkPad-T420> <4FF439D0.1000603@parallels.com>
 <1341452486.18505.49.camel@ThinkPad-T420> <4FF54F18.50300@parallels.com>
 <1341480578.23916.7.camel@ThinkPad-T420> <4FF6BA39.4000305@parallels.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2012-07-06 at 14:13 +0400, Glauber Costa wrote:
> On 07/05/2012 01:29 PM, Li Zhong wrote:
> > On Thu, 2012-07-05 at 12:23 +0400, Glauber Costa wrote:
> >> On 07/05/2012 05:41 AM, Li Zhong wrote:
> >>> On Wed, 2012-07-04 at 16:40 +0400, Glauber Costa wrote:
> >>>> On 07/04/2012 01:00 PM, Li Zhong wrote:
> >>>>> On Tue, 2012-07-03 at 15:36 -0500, Christoph Lameter wrote:
> >>>>>>> Looking through the emails it seems that there is an issue with alias
> >>>>>>> strings. 
> >>>>> To be more precise, there seems no big issue currently. I just wanted to
> >>>>> make following usage of kmem_cache_create (SLUB) possible:
> >>>>>
> >>>>> 	name = some string kmalloced
> >>>>> 	kmem_cache_create(name, ...)
> >>>>> 	kfree(name);
> >>>>
> >>>> Out of curiosity: Why?
> >>>> This is not (currently) possible with the other allocators (may change
> >>>> with christoph's unification patches), so you would be making your code
> >>>> slub-dependent.
> >>>>
> >>>
> >>> For slub itself, I think it's not good that: in some cases, the name
> >>> string could be kfreed ( if it was kmalloced ) immediately after calling
> >>> the cache create; in some other case, the name string needs to be kept
> >>> valid until some init calls finished. 
> >>>
> >>> I agree with you that it would make the code slub-dependent, so I'm now
> >>> working on the consistency of the other allocators regarding this name
> >>> string duplicating thing. 
> >>
> >> If you really need to kfree the string, or even if it is easier for you
> >> this way, it can be done. As a matter of fact, this is the case for me.
> >> Just that your patch is not enough. Christoph has a patch that makes
> >> this behavior consistent over all allocators.
> > 
> > Sorry, I didn't know that. Seems I don't need to continue the half-done
> > work in slab. If possible, would you please give me a link of the patch?
> > Thank you. 
> > 
> 
> Sorry for the delay. In case you haven't found it out yourself yet:
> 
> http://www.spinics.net/lists/linux-mm/msg36149.html

Thank you. I think it is better to have these things in the
slab_common.c. 

> 
> Please not this posted patch as is has a bug.
> 
> I do believe that your take on the aliasing code adds value to it. But
> as I've already said once, might have to dig a bit deeper in that to get
> to end of the rabbit hole.

With slab_common, I think my slab/slob modifications are not needed any
more. After I understand the common patches, I will check whether the
aliasing problem in slub still exists, and if yes, try to send a patch
based on that. 
