Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2622BDDF01
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 09:44:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Xilinx: hwicap driver
Date: Thu, 31 Jan 2008 14:39:30 -0800
In-Reply-To: <fa686aa40801311158u470981e9o6862767dea881f4b@mail.gmail.com>
References: <871wa1xrhc.fsf@macbook.be.48ers.dk>
	<20080131184722.B5E1C1A600C4@mail138-dub.bigfish.com>
	<fa686aa40801311158u470981e9o6862767dea881f4b@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080131223933.4DC0115B937D@mail113-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Thursday, January 31, 2008 11:59 AM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; jacmet@sunsite.dk
> Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
>=20
> On 1/31/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
wrote:
> > This includes code for new fifo-based xps_hwicap in addition to the
> > older opb_hwicap, which has a significantly different interface.
The
> > common code between the two drivers is largely shared.
> >
> > Significant differences exists between this driver and what is
> > supported in the EDK drivers.  In particular, most of the
> > architecture-specific code for reconfiguring individual FPGA
resources
> > has been removed.  This functionality is likely better provided in a
> > user-space support library.  In addition, read and write access is
> > supported.  In addition, although the xps_hwicap cores support
> > interrupt-driver mode, this driver only supports polled operation,
in
> > order to make the code simpler, and since the interrupt processing
> > overhead is likely to slow down the throughput under Linux.
> >
> > Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
>=20
> Comments below...
>=20
> Also, I'm not sure if drivers/char/xilinx_hwicap is the best place for
> this driver.  drivers/misc/ might be better (but I'm not sure; poll
> other people on this)

I don't have strong opinions on this...  If someone wants to say it
should be in drivers/misc, I'm more than happy to move it.  However, it
doesn't seem like there is anything else that is a pure character device
there.

> Finally, buffer_icap and fifo_icap are not huge blocks of code.  Will
> they be used by any other drivers?  Can they be rolled into the
> xilinx_hwicap.c file?

They're not huge, but they are really independent from eachother.
Furthermore, I expect that future cores will have DMA capability to
increase bandwidth, which would result in a dma_icap file.

> Style comment: reverse the condition and bail with return -EINVAL at
> the test point.  It will simplify the code and better match with
> common practice in the kernel.

good point, I'll fix them all.

> > +static ssize_t
> > +hwicap_read(struct file *file, char *buf, size_t count, loff_t
*ppos)
> > +{
> > +       struct hwicap_drvdata *drvdata =3D file->private_data;
> > +       ssize_t bytes_to_read =3D 0;
> > +       u32 *kbuf;
> > +       u32 words;
> > +       u32 bytes_remaining;
> > +       int status;
> > +
> > +       if (drvdata->is_accessing)
> > +               return -EBUSY;
> > +
> > +       drvdata->is_accessing =3D 1;
>=20
> Race condition, you need to use a semaphore.  Otherwise it is possible
> to get two processes (or even two threads of the same process) in the
> read() hook.

good point.  On thinking about this more, does the whole function need
to be in a semaphore to protect against PREEMPT kernels?

> > +static int hwicap_open(struct inode *inode, struct file *file)
> > +{
> > +       struct hwicap_drvdata *drvdata;
> > +       int status;
> > +
> > +       drvdata =3D container_of(inode->i_cdev, struct =
hwicap_drvdata,
cdev);
> > +       if (drvdata->is_open)
> > +               return -EBUSY;
> > +
> > +       drvdata->is_open =3D 1;
>=20
> Also a race condition.  Use a semaphore.
>=20
> Also, this isn't sufficient to prevent 2 processes from having the
> device open.  If a process has already opened it and then calls
> fork(), then *both* processes will have it opened even though the open
> fop was only called once.  (It might not matter for this particular
> driver as the use case is limited; but it is something you should be
> aware of.)

The fork I'm somewhat less concerned about, I think.  If someone calls
fork(), then it's up to them to synchronize their code correctly and
only call close() once.  The only reason to block the open is that it's
the simplest way to keep track of the state between reads and writes.

> > +static int __devinit hwicap_setup(struct device *dev, int id,
> > +               const struct resource *regs_res,
> > +               const struct hwicap_driver_config *config,
> > +               const struct config_registers *config_regs)
> > +{
> > +       dev_t devt;
> > +       struct hwicap_drvdata *drvdata =3D NULL;
> > +       int retval =3D 0;
> > +
> > +       dev_info(dev, "Xilinx icap port driver\n");
> > +
> > +       if (id < 0) {
> > +               for (id =3D 0; id < HWICAP_DEVICES; id++)
> > +                       if (!probed_devices[id])
> > +                               break;
> > +       }
> > +       if (id < 0 || id >=3D HWICAP_DEVICES) {
> > +               dev_err(dev, "%s%i too large\n", DRIVER_NAME, id);
> > +               return -EINVAL;
> > +       }
> > +       if (probed_devices[id]) {
> > +               dev_err(dev, "cannot assign to %s%i; it is already
in use\n",
> > +                       DRIVER_NAME, id);
> > +               return -EBUSY;
> > +       }
> > +
> > +       probed_devices[id] =3D 1;
>=20
> Hmmm, I'm not thrilled with the fixed array of HWICAP devices.  That
> sort of thing just ends up causing headaches down the road.  Can the
> driver just allocate a new structure and the next available ID at
> probe time?  (I hold my nose every time I write something like the
> above because I know I'm going to regret it later).  sysfs/udev can
> provide details about which one is which.

Can you suggest a good driver to crib?

> Cheers,
> g.

Thanks!
