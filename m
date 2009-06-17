Return-Path: <nhorman@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8C3DB72C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 23:04:46 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 4D7B0DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 23:04:45 +1000 (EST)
Date: Wed, 17 Jun 2009 09:04:13 -0400
From: Neil Horman <nhorman@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617130413.GB2774@localhost.localdomain>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245241595.4269.15.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, miltonm@bga.com,
	Simon Horman <horms@verge.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 10:26:35PM +1000, Michael Ellerman wrote:
> On Wed, 2009-06-17 at 17:29 +0530, M. Mohan Kumar wrote:
> > Do not inline putprops function
> > 
> > With the recent kexec-tools git tree, both kexec and kdump kernels hang (i.e
> > kexec -l and kexec -p respectively). This happened after the patch "ppc64:
> > cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
> > reverting each hunk and then found out that retaining following lines in
> > fs2dt.c makes kexec/kdump work.
> > 
> > -static unsigned *dt_len; /* changed len of modified cmdline
> > -                           in flat device-tree */
> > 
> > [....]
> > 
> > -               dt_len = dt;
> > 
> > I don't have any clue why removing a unused variable would cause the kexec
> > kernel to hang. After further investigation, I observed that if the putprops
> > function is not inlined, kexec/kdump kernel would work even after removing
> > the above lines.
> > 
> > This patch directs gcc to not inline the putprops function. Now we could
> > invoke kexec and kdump kernels.
> 
> What compiler version are you using? Does the behaviour change if you
> use a newer/older compiler? It sounds to me like there's some deeper bug
> and your patch is just papering over it.
> 
Agreed, this doesn't make any sense. Try changing the compiler version to see if
the problem goes away or stops.  It might also be worthwhile to dump the
contents of the device tree at the start and end of the kexec process.  If the
changing of how a function is inlined is causing a hang, its likely changing how
the putprops function is writing information to the device tree.  Understanding
what that change is will likely provide clues to how the code has changed.

Neil

> cheers



> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
