Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0104.outbound.protection.outlook.com [65.55.169.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC1E21A0D57
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 05:42:51 +1000 (AEST)
Message-ID: <1432669355.7862.16.camel@freescale.com>
Subject: Re: [PATCH v3 2/2] powerpc: add support for csum_add()
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 26 May 2015 14:42:35 -0500
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB3EB5F@AcuExch.aculab.com>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
 <1432323162.27761.274.camel@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3EB5F@AcuExch.aculab.com>
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

On Tue, 2015-05-26 at 13:57 +0000, David Laight wrote:
> From: Scott Wood ...
> > > I'd also have thought that the 64bit C version above would be 
> > > generally 'good'.
> > 
> > It doesn't generate the addc/addze sequence.  At least with GCC 
> > 4.8.2,
> > it does something like:
> > 
> >     mr      tmp0, csum
> >     li      tmp1, 0
> >     li      tmp2, 0
> >     addc    tmp3, addend, tmp0
> >     adde    csum, tmp2, tmp1
> >     add     csum, csum, tmp3
> 
> I was thinking of all 64bit targets, not 32bit ones.

Oh, you mean move it out of arch/powerpc?  Sounds reasonable, but 
someone should probably check what the resulting code looks like on 
other common arches.  OTOH, if we're going to modify non-arch code, 
that might be a good opportunity to implement Segher's suggestion and 
move to a 64-bit accumulator.

-Scott
