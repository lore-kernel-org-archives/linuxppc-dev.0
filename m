Return-Path: <glommer@parallels.com>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 727BA2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 22:43:35 +1000 (EST)
Message-ID: <4FF439D0.1000603@parallels.com>
Date: Wed, 4 Jul 2012 16:40:48 +0400
From: Glauber Costa <glommer@parallels.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420>
 <alpine.DEB.2.00.1207031344240.14703@router.home>
 <alpine.DEB.2.00.1207031535330.14703@router.home>
 <1341392420.18505.41.camel@ThinkPad-T420>
In-Reply-To: <1341392420.18505.41.camel@ThinkPad-T420>
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

On 07/04/2012 01:00 PM, Li Zhong wrote:
> On Tue, 2012-07-03 at 15:36 -0500, Christoph Lameter wrote:
>> > Looking through the emails it seems that there is an issue with alias
>> > strings. 
> To be more precise, there seems no big issue currently. I just wanted to
> make following usage of kmem_cache_create (SLUB) possible:
> 
> 	name = some string kmalloced
> 	kmem_cache_create(name, ...)
> 	kfree(name);

Out of curiosity: Why?
This is not (currently) possible with the other allocators (may change
with christoph's unification patches), so you would be making your code
slub-dependent.
