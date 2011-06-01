Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB69AB6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 08:24:21 +1000 (EST)
Date: Wed, 1 Jun 2011 17:24:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Message-ID: <20110601172412.761ff799@schlenkerla.am.freescale.net>
In-Reply-To: <201106012340.14237.arnd@arndb.de>
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: greg@kroah.com, kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, linux-console@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Jun 2011 23:40:14 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> > +static long ioctl_dtprop(struct fsl_hv_ioctl_prop __user *p, int set)
> > +{
> > +	struct fsl_hv_ioctl_prop param;
> > +	char __user *upath, *upropname;
> > +	void __user *upropval;
> > +	char *path = NULL, *propname = NULL;
> > +	void *propval = NULL;
> > +	int ret = 0;
> > +
> 
> I'm not convinced that an ioctl interface is the right way to work with
> device tree properties. A more natural way would be to export it as
> a file system, or maybe as a flattened device tree blob (the latter option
> would require changing the hypervisor interface, which might not be
> possible).

I wanted to have the hypervisor take an update dtb (we already have special
meta-properties for things like deletion as part of the hv config
mechanism).  But others on the project wanted to keep it simple, and so
get/set property it was. :-/

It's unlikely to change at this point without a real need.

As for a filesystem interface, it's not a good match either.  You can't
iterate over anything to read out the full tree from the hv.  You can't
delete anything.  You can't create empty nodes.  The hv interface was meant
to enable some specific management actions, rather than to provide general
device tree access.  This driver is a thin wrapper around the management
hcalls.

There would still be other ioctls needed for starting/stopping the
partition, etc.

> > +/**
> > + * fsl_hv_ioctl: ioctl main entry point
> > + */
> > +static long fsl_hv_ioctl(struct file *file, unsigned int cmd,
> > +			 unsigned long argaddr)
> > +{
> > +	union fsl_hv_ioctl_param __user *arg =
> > +		(union fsl_hv_ioctl_param __user *)argaddr;
> > +	long ret;
> > +
> 
> For an ioctl, please follow the normal pattern of defining a separate
> structure for each case, no union.

And have fsl_hypervisor.h provide the full set of proper ioctl numbers, with
the specific struct for each ioctl referenced, rather than having the client program do
"ioctl(f, _IOWR(0, cmd, union fsl_hv_ioctl_param), p)".

-Scott
