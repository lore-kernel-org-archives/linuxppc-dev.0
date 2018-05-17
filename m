Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mtBW2MdZzF27l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:56:19 +1000 (AEST)
Date: Thu, 17 May 2018 08:55:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant
 sizes
Message-ID: <20180517135551.GT17342@gate.crashing.org>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 17, 2018 at 12:49:58PM +0200, Christophe Leroy wrote:
> In my 8xx configuration, I get 208 calls to memcmp()
> Within those 208 calls, about half of them have constant sizes,
> 46 have a size of 8, 17 have a size of 16, only a few have a
> size over 16. Other fixed sizes are mostly 4, 6 and 10.
> 
> This patch inlines calls to memcmp() when size
> is constant and lower than or equal to 16
> 
> In my 8xx configuration, this reduces the number of calls
> to memcmp() from 208 to 123
> 
> The following table shows the number of TB timeticks to perform
> a constant size memcmp() before and after the patch depending on
> the size
> 
> 	Before	After	Improvement
> 01:	 7577	 5682	25%
> 02:	41668	 5682	86%
> 03:	51137	13258	74%
> 04:	45455	 5682	87%
> 05:	58713	13258	77%
> 06:	58712	13258	77%
> 07:	68183	20834	70%
> 08:	56819	15153	73%
> 09:	70077	28411	60%
> 10:	70077	28411	60%
> 11:	79546	35986	55%
> 12:	68182	28411	58%
> 13:	81440	35986	55%
> 14:	81440	39774	51%
> 15:	94697	43562	54%
> 16:	79546	37881	52%

Could you show results with a more recent GCC?  What version was this?

What is this really measuring?  I doubt it takes 7577 (or 5682) timebase
ticks to do a 1-byte memcmp, which is just 3 instructions after all.


Segher
