Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91229DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:47:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AGlOvn021993
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 12:47:24 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AGlOcU205758
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:47:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AGlNYl029056
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:47:23 -0600
Subject: Re: [PATCH] Consolidate mm_context_t definition in mmu.h
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707101836.26413.arnd@arndb.de>
References: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
	<200707101836.26413.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 10 Jul 2007 11:47:22 -0500
Message-Id: <1184086042.32199.11.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-10 at 18:36 +0200, Arnd Bergmann wrote:
> On Tuesday 10 July 2007, Josh Boyer wrote:
> > +#ifdef CONFIG_PPC64
> > +typedef unsigned long mm_context_id_t;
> > +
> > +typedef struct {
> > +       mm_context_id_t id;
> > +       u16 user_psize;         /* page size index */
> > +
> > +#ifdef CONFIG_PPC_MM_SLICES
> > +       u64 low_slices_psize;   /* SLB page size encodings */
> > +       u64 high_slices_psize;  /* 4 bits per slice for now */
> > +#else
> > +       u16 sllp;               /* SLB page size encoding */
> > +#endif
> > +       unsigned long vdso_base;
> > +} mm_context_t;
> > +
> > +#else /* !CONFIG_PPC64 */
> > +
> > +typedef struct {
> > +       unsigned long id;
> > +       unsigned long vdso_base;
> > +} mm_context_t;
> > +
> > +#endif /* CONFIG_PPC64 */
> 
> 
> It seems to me that you can easily consolidate this further, if you
> allow the mm_context_id_t on 32 bit, or remove it on 64 bit:

Hm... good point.  Though...

> 
> +typedef unsigned long mm_context_id_t;
> +
> +typedef struct {
> +       mm_context_id_t id;
> +       u16 user_psize;         /* page size index */
> +
> +#ifdef CONFIG_PPC64

This needs to be moved up to encompass the u16 user_psize member as
well, yes?

> +#ifdef CONFIG_PPC_MM_SLICES
> +       u64 low_slices_psize;   /* SLB page size encodings */
> +       u64 high_slices_psize;  /* 4 bits per slice for now */
> +#else
> +       u16 sllp;               /* SLB page size encoding */
> +#endif
> +#endif
> +       unsigned long vdso_base;
> +} mm_context_t;

josh
