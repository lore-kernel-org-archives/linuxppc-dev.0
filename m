Return-Path: <richardcochran@gmail.com>
Date: Sat, 26 Mar 2011 14:23:48 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH V12 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
Message-ID: <20110326132348.GB23260@riccoc20.at.omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<aa97e94c82ebd8953d83b53f64cbfef66c81b7be.1298878618.git.richard.cochran@omicron.at>
	<1300915804.848.40.camel@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300915804.848.40.camel@work-vm>
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

On Wed, Mar 23, 2011 at 02:30:04PM -0700, John Stultz wrote:
> On Mon, 2011-02-28 at 08:57 +0100, Richard Cochran wrote:
> > +/*
> > + * Register access functions
> > + */
> 
> So what are the locking rules on the functions below? I assume the
> etsects->lock needs to be held prior to calling, so that should be made
> explicit in a comment.

Yes, you are right. I'll add comments.

> > +	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl);
> > +	gfar_write(&etsects->regs->tmr_add,    etsects->tmr_add);
> > +	gfar_write(&etsects->regs->tmr_prsc,   etsects->tmr_prsc);
> > +	gfar_write(&etsects->regs->tmr_fiper1, etsects->tmr_fiper1);
> > +	gfar_write(&etsects->regs->tmr_fiper2, etsects->tmr_fiper2);
> > +	set_alarm(etsects);
> > +	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl|FS|RTPE|TE);
> 
> Does any of the above need a lock should an irq land in the middle of
> the writes?

Since these interrupts first must be enabled, I think it unlikely that
an IRQ could occur. However, it can't hurt to add the lock, either.

Thanks,

Richard
