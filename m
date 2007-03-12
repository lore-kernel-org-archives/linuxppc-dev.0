Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E930DDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:05:51 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2CM6XFg020465
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:06:33 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2CM5lGO125806
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:05:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2CM5kpA009051
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:05:47 -0400
Subject: Re: [PATCH 1/2] [powerpc] export symbols for use by lparcfg
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070312202400.GE18478@localdomain>
References: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
	<20070312202400.GE18478@localdomain>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 17:05:42 -0500
Message-Id: <1173737143.7716.22.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-03 at 15:24 -0500, Nathan Lynch wrote:
> Will Schmidt wrote:
> > 
> > Updates the Kconfig to allow lparcfg to be built as a module, and
> > add the necessary EXPORT_SYMBOLS needed for a successful build.
> 
> Well, almost exactly a year ago lparcfg was changed to bool.  Do the
> reasons for that change still stand?
Hi Nathan, 

Thanks for pointing this out to me.  I was not aware there was a
specific and deliberate change to bool from tristate.   I thought it was
due to a sloppy change that neglected to export required symbols.

> commit 82dfdcae0d57c842e02f037758687eef42fb7af6
> Author: Paul Mackerras <paulus@samba.org>
> Date:   Tue Mar 14 11:35:37 2006 +1100
> 
>     powerpc: Disallow lparcfg being a module
>     
>     The lparcfg code needs several things which are pretty arcane internal
>     details and which we don't want to export, which means that lparcfg
>     doesn't work when built as a module.  This makes it a bool instead of
>     a tristate in the Kconfig so that users can't try to build it as a
>     module.
> 
> > +EXPORT_SYMBOL_GPL(lppaca);
> 
> > +EXPORT_PER_CPU_SYMBOL_GPL(cpu_usage_array);
> 
> > +EXPORT_SYMBOL_GPL(vdso_data);
> 
> Hmm, I don't think lparcfg needs to access vdso_data at all.

It does via the reference here: 

	partition_potential_processors = vdso_data->processorCount


> 
> In pseries_lparcfg_data we have:
> 
>         lrdrp = get_property(rtas_node, "ibm,lrdr-capacity", NULL);
> 
>         if (lrdrp == NULL) {
>                 partition_potential_processors = vdso_data->processorCount;
>         } else {
>                 partition_potential_processors = *(lrdrp + 4);
>         }
> 
>         partition_active_processors = lparcfg_count_active_processors();
> 
> But if there's no ibm,lrdr-capacity property then the system doesn't
> support adding processors, so partition_potential_processors should be
> equal to partition_active_processors.
