Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19B222C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 11:41:36 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 5 Jul 2012 07:11:32 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q651fTdZ000394
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 07:11:29 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q657BGNn028650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 17:11:17 +1000
Message-ID: <1341452486.18505.49.camel@ThinkPad-T420>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Glauber Costa <glommer@parallels.com>
Date: Thu, 05 Jul 2012 09:41:26 +0800
In-Reply-To: <4FF439D0.1000603@parallels.com>
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420>
 <alpine.DEB.2.00.1207031344240.14703@router.home>
 <alpine.DEB.2.00.1207031535330.14703@router.home>
 <1341392420.18505.41.camel@ThinkPad-T420> <4FF439D0.1000603@parallels.com>
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

On Wed, 2012-07-04 at 16:40 +0400, Glauber Costa wrote:
> On 07/04/2012 01:00 PM, Li Zhong wrote:
> > On Tue, 2012-07-03 at 15:36 -0500, Christoph Lameter wrote:
> >> > Looking through the emails it seems that there is an issue with alias
> >> > strings. 
> > To be more precise, there seems no big issue currently. I just wanted to
> > make following usage of kmem_cache_create (SLUB) possible:
> > 
> > 	name = some string kmalloced
> > 	kmem_cache_create(name, ...)
> > 	kfree(name);
> 
> Out of curiosity: Why?
> This is not (currently) possible with the other allocators (may change
> with christoph's unification patches), so you would be making your code
> slub-dependent.
> 

For slub itself, I think it's not good that: in some cases, the name
string could be kfreed ( if it was kmalloced ) immediately after calling
the cache create; in some other case, the name string needs to be kept
valid until some init calls finished. 

I agree with you that it would make the code slub-dependent, so I'm now
working on the consistency of the other allocators regarding this name
string duplicating thing. 
