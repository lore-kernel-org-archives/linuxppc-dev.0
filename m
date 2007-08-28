Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D4B8DDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 05:13:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SJDCqq025251
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 15:13:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7SJDC9B485672
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 13:13:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7SJDBPT008876
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 13:13:12 -0600
Date: Tue, 28 Aug 2007 14:13:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/4] PowerPC 440EPx: Sequoia board support
Message-ID: <20070828141310.4e6bf2de@weaponx.rchland.ibm.com>
In-Reply-To: <20070828181437.GA14905@lixom.net>
References: <20070828170007.GA1605@ru.mvista.com>
	<20070828175022.GA7556@ru.mvista.com>
	<20070828181437.GA14905@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 13:14:37 -0500
Olof Johansson <olof@lixom.net> wrote:

> Hi,
> 
> On Tue, Aug 28, 2007 at 09:50:22PM +0400, Valentine Barshak wrote:
> 
> > diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
> > --- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-08-27 14:08:43.000000000 +0400
> > +++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-08-28 17:04:51.000000000 +0400
> > @@ -217,7 +217,7 @@
> >  	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
> >  	mtspr	SPRN_IVPR,r4
> >  
> > -#ifdef CONFIG_440EP
> > +#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
> >  	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
> >  	mfspr	r2,SPRN_CCR0
> >  	lis	r3,0xffef
> 
> This is obviously nothing urgent given that the ifdef already existed, but
> this looks like it really should be a runtime check instead. Multiplatform
> kernels will require it (if/whenever that becomes a priority for 44x).

Yep, indeed.  It's on my todo list, hopefully before 2.6.24.  Don't
think we need to hold up 440EPx in the meantime, since it's a slightly
larger issue. Thanks for the reminder!

josh
