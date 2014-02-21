Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6107F2C0332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 11:11:36 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Fri, 21 Feb 2014 05:41:32 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C76A91258055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 05:43:30 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1L0BLVI67043582
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 05:41:21 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1L0BT9p020999
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 05:41:29 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Read opal error log and export it
 through sysfs interface.
In-Reply-To: <20131216095746.14595.64602.stgit@mars.in.ibm.com>
References: <20131216095746.14595.64602.stgit@mars.in.ibm.com>
Date: Fri, 21 Feb 2014 11:11:27 +1100
Message-ID: <87y515mij4.fsf@river.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
 > This patch adds support to read error logs from OPAL and export them
 > to userspace through sysfs interface /sys/firmware/opa/opal-elog.

 I think we could provide a better interface with instead having a file
 per log message appear in sysfs. We're never going to have more than 128
 of these at any one time on the Linux side, so it's not going to bee too
 many files.

 e.g. /sys/firmware/opal/elog/<id>

 that way, any new file in /sys/firmware/opal/elog/ means there's a new
 log entry available. I believe there's 

 To ack a log, you could just echo 'ack' to the file.

 The other option woudl be to more closely follow what sysfs is meant to
 be - ascii text. This would mean having more (any) of the parser in
 kernel for the error logs - which may/may not be a bad idea.

 However, it would make the end user code for consuming them much much
 simpler, and that may be a good thing.

 Having some way of getting some information out without a userspace
 parser is probably good though, I'm pretty sure having only a binary
 interface in /sys is at least partially frowned upon.

 > This is what user space tool would do:
 > - Read error log from /sys/firmware/opa/opal-elog.
 > - Save it to the disk.
 > - Send an acknowledgement on successful consumption by writing error log
 >   id to /sys/firmware/opa/opal-elog-ack.

 A userspace tool may want to explicitly *not* ack the log too, or only
 ack some entries, so the interface sohuld be sane for this use case too.

 e.g. we could display them in petitboot.

 > diff --git a/arch/powerpc/platforms/powernv/opal-elog.c
 > b/arch/powerpc/platforms/powernv/opal-elog.c
 [ 2 more citation lines. Click/Enter to show. ]
 > new file mode 100644
 > index 0000000..fc891ae
 > --- /dev/null
 > +++ b/arch/powerpc/platforms/powernv/opal-elog.c
 > @@ -0,0 +1,309 @@
 <snip>
 > +/* Maximum size of a single log on FSP is 16KB */
 > +#define OPAL_MAX_ERRLOG_SIZE	16384

 I've seen some conflicting things on this - is it 2kb or 16kb?

 > +
 > +struct opal_err_log {
 > +	struct list_head link;
 > +	uint64_t opal_log_id;

 why is this uint64_t and not uint32_t? It appears that the log id is 32bits.

 > +	size_t opal_log_size;
 > +	uint8_t data[OPAL_MAX_ERRLOG_SIZE];
 > +};
 > +
 > +/* Pre-allocated temp buffer to pull error log from opal. */
 > +static uint8_t err_log_data[OPAL_MAX_ERRLOG_SIZE];

 Why do we need temporary space? Why not just store directly into struct
 opal_err_log?

 > +/* Protect err_log_data buf */
 > +static DEFINE_MUTEX(err_log_data_mutex);
 [ 15 more citation lines. Click/Enter to show. ]
 > +
 > +static uint64_t total_log_size;
 > +static bool opal_log_available;
 > +static LIST_HEAD(elog_list);
 > +static LIST_HEAD(elog_ack_list);
 > +
 > +/* lock to protect elog_list and elog-ack_list. */
 > +static DEFINE_SPINLOCK(opal_elog_lock);
 > +
 > +static DECLARE_WAIT_QUEUE_HEAD(opal_log_wait);
 > +
 > +/*
 > + * Interface for user to acknowledge the error log.
 > + *
 > + * Once user acknowledge the log, we delete that record entry from the
 > + * list and move it ack list.
 > + */
 > +void opal_elog_ack(uint64_t ack_id)

 s/ack_id/log_id/

 > +
 > +static ssize_t elog_ack_store(struct kobject *kobj,
 [ 7 more citation lines. Click/Enter to show. ]
 > +					struct kobj_attribute *attr,
 > +					const char *buf, size_t count)
 > +{
 > +	uint32_t log_ack_id;
 > +	log_ack_id = *(uint32_t *) buf;
 > +
 > +	/* send acknowledgment to FSP */
 > +	opal_elog_ack(log_ack_id);
 > +	return 0;
 > +}

 This function has a few problems:

 Consider the following actions:
 $ echo 1 > /sys/firmware/opal/opal-elog-ack
 $ echo 'abcde' > /sys/firmware/opal/opal-elog-ack

 The former will read undefined memory and the latter will make a kernel
 thread, rsyslogd and systemd-journal all each a CPU each.

 Basically, the problems are:
 1) not endian safe
 2) not following store API of returning nr bytes read
 3) binary interface. Use sscanf to read numbers instead.

 > +/*
 > + * Show error log records to user.
 [ 9 more citation lines. Click/Enter to show. ]
 > + */
 > +static ssize_t opal_elog_show(struct file *filp, struct kobject *kobj,
 > +				struct bin_attribute *bin_attr, char *buf,
 > +				loff_t pos, size_t count)
 > +{
 > +	unsigned long flags;
 > +	struct opal_err_log *record, *next;
 > +	size_t size = 0;
 > +	size_t data_to_copy = 0;
 > +	int error = 0;
 > +
 > +	/* Display one log@a time. */

 use words, not @.

 > +	if (count > OPAL_MAX_ERRLOG_SIZE)
 > +		count = OPAL_MAX_ERRLOG_SIZE;
 [ 23 more citation lines. Click/Enter to show. ]
 > +	spin_lock_irqsave(&opal_elog_lock, flags);
 > +	/* Align the pos to point within total errlog size. */
 > +	if (total_log_size && pos > total_log_size)
 > +		pos = pos % total_log_size;
 > +
 > +	/*
 > +	 * if pos goes beyond total_log_size then we know we don't have any
 > +	 * new record to show.
 > +	 */
 > +	if (total_log_size == 0 || pos >= total_log_size) {
 > +		opal_log_available = 0;
 > +		if (filp->f_flags & O_NONBLOCK) {
 > +			spin_unlock_irqrestore(&opal_elog_lock, flags);
 > +			error = -EAGAIN;
 > +			goto out;
 > +		}
 > +		spin_unlock_irqrestore(&opal_elog_lock, flags);
 > +		pos = 0;
 > +
 > +		/* Wait until we get log from sapphire */
 > +		error = wait_event_interruptible(opal_log_wait,
 > +						 opal_log_available);
 > +		if (error)
 > +			goto out;
 > +		spin_lock_irqsave(&opal_elog_lock, flags);
 > +	}

 Why should we wait for there to be a log message? If there's not one
 then there's not one and that's fine.

 I also wonder if we really need total_log_size and opal_log_available,
 this information seems readily available from the list of events.

 Instead, for notification (as i understand it)  we should be using
 sysfs_notify() from kernel and then in userspace we can just call
 select() to wait for something to happen.

 > +/*
 > + * Pre-allocate a buffer to hold handful of error logs until user space
 [ 5 more citation lines. Click/Enter to show. ]
 > + * consumes it.
 > + */
 > +static int init_err_log_buffer(void)
 > +{
 > +	int i = 0;
 > +	struct opal_err_log *buf_ptr;
 > +
 > +	buf_ptr = vmalloc(sizeof(struct opal_err_log) * MAX_NUM_RECORD);

 This means we constantly use 128 * sizeof(struct opal_err_log) which
 equates to somewhere north of 2MB of memory (due to list overhead).

 I don't think we need to statically allocate this, we can probably just
 allocate on-demand as in a typical system you're probably quite
 unlikely to have too many of these sitting around (besides, if for
 whatever reason we cannot allocate memory at some point, that's okay
 because we can read it again later).

 Oh, I forgot to mention, since this is sysfs there should be
 documentation in Documentation/ABI/ somewhere.
