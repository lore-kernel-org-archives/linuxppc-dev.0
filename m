Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1EA867A5D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 15:15:43 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	<20050109151353.GA9508@suse.de>
	<1105956993.26551.327.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 15:11:15 +1100
Message-Id: <1106107876.4534.163.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-17 at 10:16 +0000, David Woodhouse wrote:
> On Sun, 2005-01-09 at 16:13 +0100, Olaf Hering wrote:
> > 
> > > ChangeSet 1.2347, 2005/01/08 14:02:27-08:00, hpa@zytor.com
> > > 
> > >       [PATCH] raid6: altivec support
> > >       
> > >       This patch adds Altivec support for RAID-6, if appropriately configured on
> > >       the ppc or ppc64 architectures.  Note that it changes the compile flags for
> > >       ppc64 in order to handle -maltivec correctly; this change was vetted on the
> > >       ppc64 mailing list and OK'd by paulus.
> > 
> > This fails to compile on ppc, enable_kernel_altivec() is an exported but
> > undeclared function. cpu_features is also missing.
> >

I sent Linus & Andrew a patch fixing the enable_kernel_altivec() thing
yesterday. cpu_features isn't missing, it's defined differently.

> > drivers/md/raid6altivec1.c: In function `raid6_altivec1_gen_syndrome':
> > drivers/md/raid6altivec1.c:99: warning: implicit declaration of function `enable_kernel_altivec'
> > drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
> > drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' in something not a structure or union
> > drivers/md/raid6altivec2.c: In function `raid6_altivec2_gen_syndrome':
> > drivers/md/raid6altivec2.c:110: warning: implicit declaration of function `enable_kernel_altivec'
> 
> This makes it compile on PPC, but highlights the difference between
> 'cur_cpu_spec' on ppc32 and ppc64. Why is 'cur_cpu_spec' an array on
> ppc32? Isn't 'cur' supposed to imply 'current'?

It's history. When I wrote that on ppc in the first place, I decided to
leave room for having slightly different CPUs so I defined it as an
array of NR_CPUs.

When we ported this to ppc64, we figured out we never actually used that
"feature", and that the way the dynamic patching works with CPU features
makes it mandatory to have identical feature sets anyway.

We should probably "backport" that simplification to ppc32...

Ben.
