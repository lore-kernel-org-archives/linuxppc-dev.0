Return-Path: <hch@lst.de>
Date: Sat, 10 May 2008 21:07:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robert Richter <robert.richter@amd.com>
Subject: Re: [Cbe-oss-dev] [PATCH] Updated: Reworked Cell OProfile: SPU	mutex
	lock fix
Message-ID: <20080510190759.GA16275@lst.de>
References: <1209587712.7531.42.camel@carll-linux-desktop>
	<20080509150759.GL24041@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080509150759.GL24041@erda.amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	oprofile-list <oprofile-list@lists.sourceforge.net>,
	cbe-oss-dev@ozlabs.org, Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +	/* Ignoring the return value from the unregister
> > +	 * call.  A failed return value simply says there
> > +	 * was no registered event.  Hence there will not
> > +	 * be any calls to process a switch event that
> > +	 * could cause a problem.
> > +	 */
> > +	spu_switch_event_unregister(&spu_active);
> 
> Better to use this here, to show the return value is ignored:
> 
>        (void)spu_switch_event_unregister(...)

Actually Linux style is to not add those casts.  But I don't think we
all the notifier_chain_unregister funtion should return error at all,
we should probably fix that up in the core code.
