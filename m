Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 10FF2DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:14:19 +1100 (EST)
Date: Mon, 12 Mar 2007 17:14:18 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 1/2] [powerpc] export symbols for use by lparcfg
Message-ID: <20070312221418.GG18478@localdomain>
References: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
	<20070312202400.GE18478@localdomain>
	<1173737143.7716.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173737143.7716.22.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:
> On Mon, 2007-12-03 at 15:24 -0500, Nathan Lynch wrote:
> > Will Schmidt wrote:
> > > 
> > > +EXPORT_SYMBOL_GPL(vdso_data);
> > 
> > Hmm, I don't think lparcfg needs to access vdso_data at all.
> 
> It does via the reference here: 
> 
> 	partition_potential_processors = vdso_data->processorCount

I said lparcfg doesn't _need_ to access it :)

I was trying to show how the code could be changed to not use it:

> > 
> > In pseries_lparcfg_data we have:
> > 
> >         lrdrp = get_property(rtas_node, "ibm,lrdr-capacity", NULL);
> > 
> >         if (lrdrp == NULL) {
> >                 partition_potential_processors = vdso_data->processorCount;
> >         } else {
> >                 partition_potential_processors = *(lrdrp + 4);
> >         }
> > 
> >         partition_active_processors = lparcfg_count_active_processors();
> > 
> > But if there's no ibm,lrdr-capacity property then the system doesn't
> > support adding processors, so partition_potential_processors should be
> > equal to partition_active_processors.

Basically, calculate partition_active_processors first, then if !lrdrp,
partition_potential_processors = partition_active_processors.
