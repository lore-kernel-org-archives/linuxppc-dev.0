Return-Path: <anton@samba.org>
Date: Wed, 20 Jul 2011 09:46:40 +1000
From: Anton Blanchard <anton@samba.org>
To: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 4/4] powerpc: Enable lockup and hung task detectors in
	pseriesand ppc64 defeconfigs
Message-ID: <20110720094640.5c2145a5@kryten>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ADE3@saturn3.aculab.com>
References: <20110706231337.327165192@samba.org>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ADE3@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi David,

> > As a result of changes to Kconfig files, we no longer enable
> > the lockup and hung task detectors. Both are very light weight
> > and provide useful information in the event of a hang, so
> > reenable them.
> ...
> > +CONFIG_LOCKUP_DETECTOR=y
> > +CONFIG_DETECT_HUNG_TASK=y
> 
> Is one of thise responsible for generating a kernel stack traceback
> when a process has been sleeping uninterruptably for a 'long' time?
> 
> We have a kernel subsystem that has several 'worker' threads,
> these always sleep uninterruptable (they are shut down by explicit
> request) and, at times, can be idle for long periods.
> 
> Perhaps it should be possible to disable the check either on
> a per-process of per sleep basis?

I don't see any runtime options other than disabling it completely via:

/proc/sys/kernel/hung_task_timeout_secs

Anton
