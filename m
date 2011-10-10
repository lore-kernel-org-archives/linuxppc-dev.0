Return-Path: <eli@dev.mellanox.co.il>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3535EB7090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:29:35 +1100 (EST)
Received: by bkbzu17 with SMTP id zu17so7571687bkb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 02:29:31 -0700 (PDT)
Date: Mon, 10 Oct 2011 11:29:26 +0200
From: Eli Cohen <eli@dev.mellanox.co.il>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
Message-ID: <20111010092926.GO2681@mtldesk30>
References: <1318145118.29415.371.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AE78@saturn3.aculab.com>
 <20111010084726.GM2681@mtldesk30>
 <1318237284.29415.422.camel@pasglop>
 <20111010091611.GN2681@mtldesk30>
 <1318238645.29415.426.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318238645.29415.426.camel@pasglop>
Cc: netdev@vger.kernel.org, Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
 Eli Cohen <eli@mellanox.co.il>, David Laight <David.Laight@ACULAB.COM>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2011 at 11:24:05AM +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2011-10-10 at 11:16 +0200, Eli Cohen wrote:
> 
> > Until then I think we need to have the logic working right on ppc and
> > measure if blue flame buys us any improvement in ppc. If that's not
> > the case (e.g because write combining is not working), then maybe we
> > should avoid using blueflame in ppc.
> > Could any of the guys from IBM check this and give us feedback?
> 
> I don't have the necessary hardware myself to test that but maybe Thadeu
> can.
> 
> Note that for WC to work, things must be mapped non-guarded. You can do
> that by using ioremap_prot() with pgprot_noncached_wc(PAGE_KERNEL) or
> ioremap_wc() (dunno how "generic" the later is).

I use the io mapping API:

at driver statrt:
        priv->bf_mapping = io_mapping_create_wc(bf_start, bf_len);
        if (!priv->bf_mapping)
                err = -ENOMEM;

and then:
        uar->bf_map = io_mapping_map_wc(priv->bf_mapping, uar->index << PAGE_SHIFT);

        
Will this work on ppc?

> 
> >From there, you should get write combining provided that you don't have
> barriers between every access (ie those copy operations in their current
> form should do the trick).
> 
> Cheers,
> Ben.
> 
> > > Maybe it's time for us to revive those discussions about providing a
> > > good set of relaxed MMIO accessors with explicit barriers :-)
> > > 
> > > Cheers,
> > > Ben.
> > >  
> 
