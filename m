Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D0B92C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 03:23:30 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Wed, 5 Sep 2012 11:23:27 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 18A9C3E4005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 11:23:19 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q85HMpXX266370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2012 11:22:59 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q85HOGu1002635
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2012 11:24:17 -0600
Message-ID: <1346865903.12872.37.camel@footlong>
Subject: Re: [PATCH V3 1/3] drivers/char/tpm: Add new device driver to
 support IBM vTPM
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Sep 2012 12:25:03 -0500
In-Reply-To: <1346816407.2257.37.camel@pasglop>
References: <1344987282.4430.26.camel@footlong>
 <1345670263.25124.7.camel@footlong>
 <20120822214217.GB13519@linux.vnet.ibm.com>
 <1346816407.2257.37.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 adlai@us.ibm.com, Kent Yoder <key@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben.,

Thank you so much for the comments.  Please see my response below.

> > > + */
> > > +static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > > +{
> > > +	struct ibmvtpm_dev *ibmvtpm;
> > > +	u16 len;
> > > +
> > > +	ibmvtpm = (struct ibmvtpm_dev *)chip->vendor.data;
> > > +
> > > +	if (!ibmvtpm->rtce_buf) {
> > > +		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
> > > +		return 0;
> > > +	}
> > > +
> > > +	wait_event_interruptible(wq, ibmvtpm->crq_res.len != 0);
> > > +
> > > +	if (count < ibmvtpm->crq_res.len) {
> 
> That doesn't look right. The "other side" as far as I can tell is:
> 
> > > +		case VTPM_TPM_COMMAND_RES:
> > > +			ibmvtpm->crq_res.valid = crq->valid;
> > > +			ibmvtpm->crq_res.msg = crq->msg;
> > > +			ibmvtpm->crq_res.len = crq->len;
> > > +			ibmvtpm->crq_res.data = crq->data;
> > > +			wake_up_interruptible(&wq);
> 
> That looks racy to me. At the very least it should be doing:
> 
> 			ibmvtpm->crq_res.data = crq->data;
> 			smp_wmb();
> 			ibmvtpm->crq_res.len = crq->len;
> 
> IE. Ensure that "len" is written last, and possibly have an
> corresponding smp_rmb() after wait_event_interruptible() in the receive
> case.

Good catch. I agreed len should be written last and adding memory
barrier is a good idea.

> 
> Also, I dislike having a global symbol called "wq". You also don't seem
> to have any synchronization on access to that wq, can't you end up with
> several clients trying to send messages & wait for responses getting all
> mixed up ? You might need to make sure that at least you do a
> wake_up_interruptible_all() to ensure you wake them all up (inefficient
> but works). Unless you can track per-client ?

The TPM layer above allows only one request at any given point in time.
Therefore we don't need to wake_up_interruptible_all().  I can move wq
to the private structure.

> 
> Or is the above TPM layer making sure only one command/response happens
> at a given point in time ?

You are right.  See above.
> 
> You also do an interruptible wait but don't seem to be checking for
> signals (and not testing the result from wait_event_interruptible which
> might be returning -ERESTARTSYS in this case).
> 
Good point.  I will check for signal in the next version.

> That all sound a bit wrong to me ...
> > > +static irqreturn_t ibmvtpm_interrupt(int irq, void *vtpm_instance)
> > > +{
> > > +	struct ibmvtpm_dev *ibmvtpm = (struct ibmvtpm_dev *) vtpm_instance;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&ibmvtpm->lock, flags);
> > > +	vio_disable_interrupts(ibmvtpm->vdev);
> > > +	tasklet_schedule(&ibmvtpm->tasklet);
> > > +	spin_unlock_irqrestore(&ibmvtpm->lock, flags);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> 
> Tasklets ? We still use those things ? That's softirq iirc, do you
> really need to offload ? I mean, it allows to limit the amount of time
> an interrupt is disabled, but that's only useful if you assume you'll
> have quite a lot of traffic here, is that the case ?
> 
> You might be actually increasing latency here in favor of throughput, is
> that what you are aiming for ? Also keep in mind that
> vio_disable/enable_interrupt() being an hcall, it can have significant
> overhead. So again, only worth it if you're going to process a bulk of
> data at a time.

My original thought was to have the bottom half process the crq data
while the top half can service another request.  There is some work in
processing crq data but not that bad. You are right the
vio_disable/enable_interrupt() can have significant overhead.  I will
remove tasklet in the next version.

> 
> Cheers,
> Ben.
> 
> 

Thanks,
--Ashley Lai
