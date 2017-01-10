Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tybL44dShzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 02:19:56 +1100 (AEDT)
Message-ID: <1484061523.21117.16.camel@kernel.crashing.org>
Subject: Re: [PATCH 9/9] powerpc: A new cache shape aux vectors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Steven Munroe <munroesj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 09:18:43 -0600
In-Reply-To: <20170110131542.GK28613@gate.crashing.org>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
 <20170104051535.9454-9-benh@kernel.crashing.org>
 <20170110131542.GK28613@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-10 at 07:15 -0600, Segher Boessenkool wrote:
> On Wed, Jan 04, 2017 at 04:15:35PM +1100, Benjamin Herrenschmidt wrote:
> > + * For all these fields, a value of 0 means that the information
> > + * is not known.
> > +     if (sets == 0)
> > +             info->assoc = 0xffff;
> > +     else
> 
> ...
> 
> Is this correct?  A fully associative cache should be encoded as sets == 1,
> if there are buggy firmwares that set it to 0 instead it should do the same
> as 1 here I think?

No, I just made a stupid mistake I think. PAPR does say sets=1 is fully
associative which makes sense. Probably a typo.

>   Or is 0xffff indicating "unknown" here...  But in that
> case the comment above says assoc should be 0 instead.

No it's me.

Cheers,
Ben.
