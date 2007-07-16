Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A6CCDDF4C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 03:22:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6GHMbuw017645
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 13:22:37 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6GHMbrA352418
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 13:22:37 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6GHMbcn013560
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 13:22:37 -0400
Date: Mon, 16 Jul 2007 12:22:36 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] crash in 2.6.22-git2 sysctl_set_parent()
Message-ID: <20070716172236.GA5771@austin.ibm.com>
References: <20070713200515.GS5549@austin.ibm.com>
	<m13azreqtr.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m13azreqtr.fsf@ebiederm.dsl.xmission.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 07:06:56PM -0600, Eric W. Biederman wrote:
> >  			.data		= &ipv4_devconf.loop,
> >  			.maxlen		= sizeof(int),
> >  			.mode		= 0644,
> > +			.child	= 0x0,
> >  			.proc_handler	= &proc_dointvec,
> >  		},
> Where did this entry above in devinet_sysctl come from?

My bad.
I habitually apply the "send-to-self" patch, since some of the 
network testing that I do is easiest if I load up the all of the 
adapters in the same box. (If you're not familiar with this patch ... 
its great, and I wish it was integratedd into mainline. It allows
one to drive network traffic through the physical devices, even
if they are in the same box.  Without it, the network stack is
too clever, and won't allow you to do this.)

> > +		{
> > +			.ctl_name	= 0,
> > +			.procname	= 0,
> > +		},
> I probably would have just done:
> +		{},

Yes, in retrospect, this would have been the simplest solution.

> What added the additional entry to devinet_root_dir?  I don't see that
> in Linus' tree?
> 
> The result may be fine but if it isn't named in a per network device
> manner we are adding duplicate entries to the root /proc/sys directory
> which is wrong.
> 
> Actually come to think of it I am concerned that someone added a
> settable entry into /proc/sys/ it should at least be in /proc/sys/net/
> where it won't conflict with other uses of that directory.  Especially
> as things like network devices have user controlled names.

Sigh. Silly me. Haste makes waste.

--linas
