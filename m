Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4F2CB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 05:27:54 +1100 (EST)
Received: by gyg8 with SMTP id 8so227571gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Feb 2011 10:27:50 -0800 (PST)
Date: Wed, 9 Feb 2011 10:27:40 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110209182740.GC23867@core.coreip.homeip.net>
References: <1297208267-27087-1-git-send-email-iws@ovro.caltech.edu>
	<1297208267-27087-2-git-send-email-iws@ovro.caltech.edu>
	<20110209083325.GA7256@core.coreip.homeip.net>
	<20110209173532.GB21766@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110209173532.GB21766@ovro.caltech.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2011 at 09:35:32AM -0800, Ira W. Snyder wrote:
> On Wed, Feb 09, 2011 at 12:33:25AM -0800, Dmitry Torokhov wrote:
> > > +
> > > +	/* Warn if we are running in a degraded state, but do not fail */
> > > +	if (priv->num_buffers < MAX_DATA_BUFS) {
> > > +		dev_warn(priv->dev, "Unable to allocate one second worth of "
> > > +				    "buffers, using %d buffers instead\n", i);
> > 
> > The latest style is not break strings even if they exceed 80 column
> > limit to make sure they are easily greppable.
> > 
> 
> I usually just follow checkpatch warnings. I'll combine the strings onto
> one line.

Does it still warn? I think they tried to fix it so it recognizes long
messages.

> > 
> > OTOH, we can't have more than 1 in-flight buffer, can we? Should
> > we even have a list?
> > 
> 
> This looks like a good change. I didn't know about list_move_tail()
> before you mentioned it. Good catch.
> 
> You are correct that it is not possible to have more than one in flight
> buffer at the same time. It was previously possible in an earlier
> version of the driver. That was before I was forced to come up with the
> ugly IRQ disabling scheme due to the hardware design.
> 
> What would you replace the inflight list with? A "struct data_buf
> *inflight;" in the priv structure?
> 

Yes. Then one would not worry of it is safe to always mark first element
of in-flight list as "complete"

> > 
> > Have you considered enabling the device when someone opens the device
> > node and closing it when last user drops off?
> > 
> > 
> 
> Yes. Unfortunately it is not possible. Blame my userspace software
> engineers, who refused this model of operation.
> 
> I must meet the requirement that the device must remain open while the
> DATA-FPGAs are reconfigured. This means that the FPGAs are completely
> powered down, and a new FPGA bitfile is loaded into them.
> 
> After a reconfiguration, the data buffer size may change.
> 
> The userspace coders were willing to use a sysfs file to enable/disable
> reading from the device, but they were not willing to open/close the
> device each time. It was the best compromise they would accept.
> 
> I'm not happy about it either.

I see.

> 
> > > +
> > > +/*
> > > + * FPGA Realtime Data Character Device
> > > + */
> > > +
> > > +static int data_open(struct inode *inode, struct file *filp)
> > > +{
> > > +	/*
> > > +	 * The miscdevice layer puts our struct miscdevice into the
> > > +	 * filp->private_data field. We use this to find our private
> > > +	 * data and then overwrite it with our own private structure.
> > > +	 */
> > > +	struct fpga_device *priv = container_of(filp->private_data,
> > > +						struct fpga_device, miscdev);
> > > +	struct fpga_reader *reader;
> > > +	int ret;
> > > +
> > > +	/* allocate private data */
> > > +	reader = kzalloc(sizeof(*reader), GFP_KERNEL);
> > > +	if (!reader)
> > > +		return -ENOMEM;
> > > +
> > > +	reader->priv = priv;
> > > +	reader->buf = NULL;
> > > +
> > > +	filp->private_data = reader;
> > > +	ret = nonseekable_open(inode, filp);
> > > +	if (ret) {
> > > +		dev_err(priv->dev, "nonseekable-open failed\n");
> > > +		kfree(reader);
> > > +		return ret;
> > > +	}
> > > +
> > 
> > I wonder if the device should allow only exclusive open... Unless you
> > distribute copies of data between all readers.
> > 
> 
> I wish to allow multiple different processes to mmap() the device. This
> requires open(), followed by mmap(). I only care about a single realtime
> data reader (which calls read()). Splitting the two use cases into two
> drivers seemed like a big waste of time and effort. I have no idea how
> to accomplish a single read()er while allowing multiple mmap()ers.

I see.

> 
> > > +	return 0;
> > > +}
> > > +
> > > +static int data_release(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct fpga_reader *reader = filp->private_data;
> > > +
> > > +	/* free the per-reader structure */
> > > +	data_free_buffer(reader->buf);
> > > +	kfree(reader);
> > > +	filp->private_data = NULL;
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t data_read(struct file *filp, char __user *ubuf, size_t count,
> > > +			 loff_t *f_pos)
> > > +{
> > > +	struct fpga_reader *reader = filp->private_data;
> > > +	struct fpga_device *priv = reader->priv;
> > > +	struct list_head *used = &priv->used;
> > > +	struct data_buf *dbuf;
> > > +	size_t avail;
> > > +	void *data;
> > > +	int ret;
> > > +
> > > +	/* check if we already have a partial buffer */
> > > +	if (reader->buf) {
> > > +		dbuf = reader->buf;
> > > +		goto have_buffer;
> > > +	}
> > > +
> > > +	spin_lock_irq(&priv->lock);
> > > +
> > > +	/* Block until there is at least one buffer on the used list */
> > > +	while (list_empty(used)) {
> > 
> > I believe we should stop and return error when device is disabled so the
> > condition should be:
> > 
> > 	while (!reader->buf && list_empty() && priv->enabled)
> > 
> > 
> 
> The requirement is that the device stay open during reconfiguration.
> This provides for that. Readers just block for as long as the device is
> not producing data.

OK, you still need to make sure you do not touch free/used buffer while
device is disabled. Also, you need to kick readers if you unbind the
driver, so maybe a new flag priv->exists should be introduced and
checked.

> 
> > > +		spin_unlock_irq(&priv->lock);
> > > +
> > > +		if (filp->f_flags & O_NONBLOCK)
> > > +			return -EAGAIN;
> > > +
> > > +		ret = wait_event_interruptible(priv->wait, !list_empty(used));
> > 
> > 		ret = wait_event_interruptible(priv->wait,
> > 					!list_empty(used) || !priv->enabled);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		spin_lock_irq(&priv->lock);
> > > +	}
> > > +
> > 
> > 	if (!priv->enabled) {
> > 		spin_unlock_irq(&priv->lock);
> > 		return -ENXIO;
> > 	}
> > 
> > 	if (reader->buf) {
> > 		dbuf = reader->buf;
> > 	} else {
> > 		dbuf = list_first_entry(used, struct data_buf, entry);
> > 		list_del_init(&dbuf->entry);
> > 	}
> > 
> > > +	/* Grab the first buffer off of the used list */
> > > +	dbuf = list_first_entry(used, struct data_buf, entry);
> > > +	list_del_init(&dbuf->entry);
> > > +
> > > +	spin_unlock_irq(&priv->lock);
> > > +
> > > +	/* Buffers are always mapped: unmap it */
> > > +	data_unmap_buffer(priv->dev, dbuf);
> > > +
> > > +	/* save the buffer for later */
> > > +	reader->buf = dbuf;
> > > +	reader->buf_start = 0;
> > > +
> > > +	/* we removed a buffer from the used list: wake any waiters */
> > > +	wake_up(&priv->wait);
> > 
> > I do not think anyone waits on this...
> > 
> > > +
> > > +have_buffer:
> > > +	/* Get the number of bytes available */
> > > +	avail = dbuf->size - reader->buf_start;
> > > +	data = dbuf->vb.vaddr + reader->buf_start;
> > > +
> > > +	/* Get the number of bytes we can transfer */
> > > +	count = min(count, avail);
> > > +
> > > +	/* Copy the data to the userspace buffer */
> > > +	if (copy_to_user(ubuf, data, count))
> > > +		return -EFAULT;
> > > +
> > > +	/* Update the amount of available space */
> > > +	avail -= count;
> > > +
> > > +	/* Lock against concurrent enable/disable */
> > > +	ret = mutex_lock_interruptible(&priv->mutex);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Mutex is not needed here, we shall rely on priv->lock. Map buffer
> > beforehand, take lock, check if the device is enabled and if it still is
> > put the buffer on free list. Release lock and exit if device was
> > enabled; otherwise dispose the buffer.
> > 
> > > +
> > > +	/* Still some space available: save the buffer for later */
> > > +	if (avail != 0) {
> > > +		reader->buf_start += count;
> > > +		reader->buf = dbuf;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/*
> > > +	 * No space is available in this buffer
> > > +	 *
> > > +	 * This is a complicated decision:
> > > +	 * - if the device is not enabled: free the buffer
> > > +	 * - if the buffer is too small: free the buffer
> > > +	 */
> > > +	if (!priv->enabled || dbuf->size != priv->bufsize) {
> > > +		data_free_buffer(dbuf);
> > > +		reader->buf = NULL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The buffer is safe to recycle: remap it and finish
> > > +	 *
> > > +	 * If this fails, we pretend that the read never happened, and return
> > > +	 * -EFAULT to userspace. They'll retry the read again.
> > > +	 */
> > > +	ret = data_map_buffer(priv->dev, dbuf);
> > > +	if (ret) {
> > > +		dev_err(priv->dev, "unable to remap buffer for DMA\n");
> > > +		count = -EFAULT;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/* Add the buffer back to the free list */
> > > +	reader->buf = NULL;
> > > +	spin_lock_irq(&priv->lock);
> > > +	list_add_tail(&dbuf->entry, &priv->free);
> > > +	spin_unlock_irq(&priv->lock);
> > > +
> > > +out_unlock:
> > > +	mutex_unlock(&priv->mutex);
> > > +	return count;
> > > +}
> > > +
> > > +static unsigned int data_poll(struct file *filp, struct poll_table_struct *tbl)
> > > +{
> > > +	struct fpga_reader *reader = filp->private_data;
> > > +	struct fpga_device *priv = reader->priv;
> > > +	unsigned int mask = 0;
> > > +
> > > +	poll_wait(filp, &priv->wait, tbl);
> > > +
> > > +	spin_lock_irq(&priv->lock);
> > > +
> > 
> > Like I mentioned, the spinlock is not useful here - all threads will get
> > woken up and will try to read since you are not resetting the wakeup
> > condition.
> > 
> 
> Whoops, I forgot this from your previous review. Sorry.
> 
> > > +	if (!list_empty(&priv->used))
> > > +		mask |= POLLIN | POLLRDNORM;
> > 
> > I think you should also add:
> > 
> > 	if (!priv->)
> > 		mask |= POLLHUP | POLLERR;
> > 
> > to tell the readers that they should close their file descriptors. 
> > 
> 
> Did you mean "!priv->enabled"? If so, see the comments above about
> keeping the device open across reconfiguration.

The new !priv->exists then.

Thanks.

-- 
Dmitry
