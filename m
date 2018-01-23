Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR2305PhwzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 08:47:40 +1100 (AEDT)
Date: Tue, 23 Jan 2018 15:47:00 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/mm: Enhance 'slice' for supporting PPC32
Message-ID: <20180123214659.GG21977@gate.crashing.org>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <87vafyz265.fsf@linux.vnet.ibm.com>
 <84dc1df4-db2f-be11-c1f3-5dddd1e44983@c-s.fr>
 <b4d8f01b-9ee1-ec34-aa0d-5a353064438c@linux.vnet.ibm.com>
 <28c3ba39-ef31-5ff3-7672-3e9d1942be94@c-s.fr>
 <c9ab9a1b-4c77-fdfc-50d1-974388cc3b10@linux.vnet.ibm.com>
 <e2f36c99-1b5d-acf5-12c8-b2b48701011a@c-s.fr>
 <36e8d873-4021-4266-bf5f-287f396ba9e1@c-s.fr>
 <20180120175655.GY21977@gate.crashing.org>
 <52c000dd-1625-a205-8ad1-04376beed2ab@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52c000dd-1625-a205-8ad1-04376beed2ab@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 22, 2018 at 08:52:53AM +0100, Christophe LEROY wrote:
> >Just make sure to declare all functions, or define it to some empty
> >thing, or #ifdeffery if you have to.  There are many options, it is
> >not hard, and if it means you have to pull code further apart that is
> >not so bad: you get cleaner, clearer code.
> 
> Ok, if I understand well, your comment applies to the following indeed, 
> so you confirm the #ifdef is necessary.

As I said, not necessary, but it might be the easiest or even the
cleanest here.  Something for you and the maintainers to fight about,
I'll stay out of it :-)

> However, my question was related to another part of the current 
> patchset, where the functions are always refined:
> 
> 
> On PPC32 we set:
> 
> +#define SLICE_LOW_SHIFT		28
> +#define SLICE_HIGH_SHIFT	0
> 
> On PPC64 we set:
> 
>  #define SLICE_LOW_SHIFT		28
>  #define SLICE_HIGH_SHIFT	40
> 
> We define:
> 
> +#define slice_bitmap_zero(dst, nbits) \
> +	do { if (nbits) bitmap_zero(dst, nbits); } while (0)
> 
> 
> We have a function with:
> {
> 	slice_bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
>  	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> }

SLICE_NUM_xx is not the same as SLICE_xx_SHIFT; I don't see how any of
those shift values give nbits == 0.

> So the question is to find the better approach. Is the above approach 
> correct, including performance wise ?

If slice_bitmap_zero is inlined (or partially inlined) it is fine.  Is it?


Segher
