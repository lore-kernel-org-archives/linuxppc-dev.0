Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 982271A0072
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 08:08:10 +1000 (AEST)
Date: Fri, 22 May 2015 16:39:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Cc: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 2/2] powerpc: add support for csum_add()
Message-ID: <20150522213956.GC7305@gate.crashing.org>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
 <1432323162.27761.274.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432323162.27761.274.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 22, 2015 at 02:32:42PM -0500, Scott Wood wrote:
> > I'd also have thought that the 64bit C version above would be generally 'good'.
> 
> It doesn't generate the addc/addze sequence.  At least with GCC 4.8.2,
> it does something like:
> 
> 	mr	tmp0, csum
> 	li	tmp1, 0
> 	li	tmp2, 0
> 	addc	tmp3, addend, tmp0
> 	adde	csum, tmp2, tmp1
> 	add	csum, csum, tmp3

Right.  Don't expect older compilers to do sane things here.

All this begs a question...  If it is worth spending so much time
micro-optimising this, why not pick the low-hanging fruit first?
Having a 32-bit accumulator for ones' complement sums, on a 64-bit
system, is not such a great idea.


Segher
