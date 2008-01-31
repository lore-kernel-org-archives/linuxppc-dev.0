Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id CE2A0DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 10:12:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so221476anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 15:12:54 -0800 (PST)
Message-ID: <fa686aa40801311512l16b31df8q4d5bf940210389e@mail.gmail.com>
Date: Thu, 31 Jan 2008 16:12:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
In-Reply-To: <20080131223933.4DC0115B937D@mail113-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <871wa1xrhc.fsf@macbook.be.48ers.dk>
	<20080131184722.B5E1C1A600C4@mail138-dub.bigfish.com>
	<fa686aa40801311158u470981e9o6862767dea881f4b@mail.gmail.com>
	<20080131223933.4DC0115B937D@mail113-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/31/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> > Also, this isn't sufficient to prevent 2 processes from having the
> > device open.  If a process has already opened it and then calls
> > fork(), then *both* processes will have it opened even though the open
> > fop was only called once.  (It might not matter for this particular
> > driver as the use case is limited; but it is something you should be
> > aware of.)
>
> The fork I'm somewhat less concerned about, I think.  If someone calls
> fork(), then it's up to them to synchronize their code correctly and
> only call close() once.  The only reason to block the open is that it's
> the simplest way to keep track of the state between reads and writes.

<interesting trivia> You're thinking of threads; not fork.  When fork
is called you get a whole new process which has all the same file
descriptors open as the parent process.  This is what the timeline
would look like:

p1: open(/dev/hwcap0)
--- open fop called here (and struct file is allocated)
p1: fork()
--- p2 is created
p1: do stuff
p2: do stuff
p1: close()
p2: do more stuff
p2: close()
--- release fop called here (and struct file is released)

Notice how close is called twice (the correct behavour) yet release is
only called once?  :-)  That means there are 2 processes sharing the
same file structure.

> > > +static int __devinit hwicap_setup(struct device *dev, int id,
> > > +               const struct resource *regs_res,
> > > +               const struct hwicap_driver_config *config,
> > > +               const struct config_registers *config_regs)
> > > +{
> > > +       dev_t devt;
> > > +       struct hwicap_drvdata *drvdata = NULL;
> > > +       int retval = 0;
> > > +
> > > +       dev_info(dev, "Xilinx icap port driver\n");
> > > +
> > > +       if (id < 0) {
> > > +               for (id = 0; id < HWICAP_DEVICES; id++)
> > > +                       if (!probed_devices[id])
> > > +                               break;
> > > +       }
> > > +       if (id < 0 || id >= HWICAP_DEVICES) {
> > > +               dev_err(dev, "%s%i too large\n", DRIVER_NAME, id);
> > > +               return -EINVAL;
> > > +       }
> > > +       if (probed_devices[id]) {
> > > +               dev_err(dev, "cannot assign to %s%i; it is already
> in use\n",
> > > +                       DRIVER_NAME, id);
> > > +               return -EBUSY;
> > > +       }
> > > +
> > > +       probed_devices[id] = 1;
> >
> > Hmmm, I'm not thrilled with the fixed array of HWICAP devices.  That
> > sort of thing just ends up causing headaches down the road.  Can the
> > driver just allocate a new structure and the next available ID at
> > probe time?  (I hold my nose every time I write something like the
> > above because I know I'm going to regret it later).  sysfs/udev can
> > provide details about which one is which.
>
> Can you suggest a good driver to crib?

What I would do is use a static struct list_head to hold a list of all
instantiated devices.  When you register a new device you can use
list_for_each_entry to look for a free id.  That way you don't have to
preallocate an array for all the possible device numbers.

OTOH, how many of these devices are likely to be present on any one
bitstream?  If it is only 1 or 2 then it might be that the overhead
isn't worth the savings.  I won't complain if you decide it's better
the way it is now.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
