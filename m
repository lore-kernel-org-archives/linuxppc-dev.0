Return-Path: <cbouatmailru@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id AAE90DDDF7
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 23:10:38 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so530573fgg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 04:10:36 -0800 (PST)
Date: Sun, 23 Dec 2007 14:59:35 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] [POWERPC] FSL UPM: routines to manage FSL UPMs
Message-ID: <20071223115935.GB5643@zarina>
References: <20071221203552.GA4738@localhost.localdomain>
	<20071221203925.GA4829@localhost.localdomain>
	<20071223132457.a40e8100.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071223132457.a40e8100.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 01:24:57PM +1100, Stephen Rothwell wrote:
> On Fri, 21 Dec 2007 23:39:25 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +int fsl_upm_get_for(struct device_node *node, const char *name,
> > +		    struct fsl_upm *upm)
> > +{
> > +	int ret;
> > +	struct device_node *lbus;
> > +	struct resource lbc_res;
> > +	ptrdiff_t mxmr_offs;
> > +
> > +	lbus = of_get_parent(node);
> > +	if (!lbus) {
> > +		pr_err("FSL UPM: can't get parent local bus node\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	ret = of_address_to_resource(lbus, 0, &lbc_res);
> 
> of_node_put(lbus) as of_get_parent() gets a reference.

Thanks, will fix.

> > +static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u32 pat_offset)
> > +{
> > +	spin_lock_irqsave(&upm_lock, upm_lock_flags);
> 
> I may be wrong, but don't we need the "flags" argument to
> spin_lock_irqsave to be on the stack?  And the save and restore to be in
> the same function?

In general case, yes. Here, not exactly. We have to grab a lock at the
start(), do runs(), and release a lock at the end():

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
