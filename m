Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E58BD1A003C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 07:54:53 +1000 (AEST)
Message-ID: <1432331679.27761.278.camel@freescale.com>
Subject: Re: [PATCH v3 2/2] powerpc: add support for csum_add()
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: David Laight <David.Laight@ACULAB.COM>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Christophe
 Leroy" <christophe.leroy@c-s.fr>
Date: Fri, 22 May 2015 16:54:39 -0500
In-Reply-To: <20150522213956.GC7305@gate.crashing.org>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
 <1432323162.27761.274.camel@freescale.com>
 <20150522213956.GC7305@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-05-22 at 16:39 -0500, Segher Boessenkool wrote:
> On Fri, May 22, 2015 at 02:32:42PM -0500, Scott Wood wrote:
> > > I'd also have thought that the 64bit C version above would be generally 'good'.
> > 
> > It doesn't generate the addc/addze sequence.  At least with GCC 4.8.2,
> > it does something like:
> > 
> > 	mr	tmp0, csum
> > 	li	tmp1, 0
> > 	li	tmp2, 0
> > 	addc	tmp3, addend, tmp0
> > 	adde	csum, tmp2, tmp1
> > 	add	csum, csum, tmp3
> 
> Right.  Don't expect older compilers to do sane things here.
> 
> All this begs a question...  If it is worth spending so much time
> micro-optimising this, why not pick the low-hanging fruit first?
> Having a 32-bit accumulator for ones' complement sums, on a 64-bit
> system, is not such a great idea.

That would be a more intrusive change -- not (comparatively) low-hanging
fruit.  Plus, the person submitting these patches is focused on 32-bit.

-Scott
