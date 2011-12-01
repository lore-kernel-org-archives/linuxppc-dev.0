Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD4A2B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 15:28:37 +1100 (EST)
Message-ID: <1322713708.3729.15.camel@pasglop>
Subject: Re: lmb_alloc() and page memory overlap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prashant Bhole <prashantsmailcenter@gmail.com>
Date: Thu, 01 Dec 2011 15:28:28 +1100
In-Reply-To: <CAD6p20eX5uq=w5JU19+-x=bAPJ9tBSDanH46n22S6SFuFXbP_Q@mail.gmail.com>
References: <CAD6p20evHeESH1UwpB4rg8NTxndAtQW9C1S1bpJWFLmS-rOu5w@mail.gmail.com>
 <1322712006.3729.14.camel@pasglop>
 <CAD6p20eX5uq=w5JU19+-x=bAPJ9tBSDanH46n22S6SFuFXbP_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > This should have been fixed in memblock in recent kernel, at least I
> > believe it is. It looks like this is caused by overlapping lmb_reserve()
> > at boot (or lmb_reserve() overlapping an lmb_alloc'ated region which
> > boils down to the same thing).
> >
> > Old lmb didn't deal with that well at all and that lead to corruption of
> > the lmb list. We fixed that in
> >
> > 8f7a66051b7523108c5aefb08c6a637e54aedc47
> >
> >    mm/memblock: properly handle overlaps and fix error path
> >
> > Which got merged in 2.6.39.
> >
> > If you absolutely need to stick to 2.6.30, you can try backporting the
> > fix to lmb.
> >
> > Cheers,
> > Ben.
> >
> 
> I need to stick to 2.6.30, will try backporting the fix. Is this the same thing
> which is causing the wrong page (already allocated memory) allocation?

I can't say for sure but it looks like it could be.

Cheers,
Ben.
