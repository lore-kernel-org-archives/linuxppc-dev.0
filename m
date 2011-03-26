Return-Path: <richardcochran@gmail.com>
Date: Sat, 26 Mar 2011 14:12:29 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH V12 1/4] ptp: Added a brand new class driver for ptp
	clocks.
Message-ID: <20110326131229.GA23260@riccoc20.at.omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<bf964489f4c6ee51bd8a2ab818cd6a5e2f544627.1298878618.git.richard.cochran@omicron.at>
	<1300915160.848.33.camel@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300915160.848.33.camel@work-vm>
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 23, 2011 at 02:19:20PM -0700, John Stultz wrote:
> On Mon, 2011-02-28 at 08:57 +0100, Richard Cochran wrote:
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -0,0 +1,320 @@
> [snip]
> > +static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
> > +				       struct ptp_clock_event *src)
> > +{
> > +	struct ptp_extts_event *dst;
> > +	unsigned long flags;
> > +	u32 remainder;
> > +
> > +	dst = &queue->buf[queue->tail];
> 
> Doesn't the lock need to happen before you access the
> queue->buf[queue->tail] ? 
> 
> For example: What happens if two cpus enter the function at the same
> time, both get the same tail index, one overwrite the other's data, then
> both take turns bumping up the tail pointer?

Yes, thanks for that catch.

> > +struct timestamp_event_queue {
> > +	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
> > +	int head;
> > +	int tail;
> > +	spinlock_t lock;
> > +};
> > +
> > +struct ptp_clock {
> > +	struct posix_clock clock;
> > +	struct device *dev;
> > +	struct ptp_clock_info *info;
> > +	dev_t devid;
> > +	int index; /* index into clocks.map */
> > +	struct pps_device *pps_source;
> > +	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
> > +	struct mutex tsevq_mux; /* one process at a time reading the fifo */
> > +	wait_queue_head_t tsev_wq;
> > +};
> > +
> > +static inline int queue_cnt(struct timestamp_event_queue *q)
> > +{
> > +	int cnt = q->tail - q->head;
> > +	return cnt < 0 ? PTP_MAX_TIMESTAMPS + cnt : cnt;
> > +}
> 
> q->tail and head access probably need to happen only when locked. 
> 
> So probably need a comment that queue_cnt must be called only when
> holding the proper lock.

In this case, calling without a lock is allowed. However, I'll add
comment like the following.

 * The function queue_cnt() is safe for readers to call without
 * holding q->lock. Readers use this function to verify that the queue
 * is nonempty before proceeding with a dequeue operation. The fact
 * that a writer might concurrently increment the tail does not
 * matter, since the queue remains nonempty nonetheless.

Thanks for your feedback,

Richard
