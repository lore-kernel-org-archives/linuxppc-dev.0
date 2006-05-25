Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id C4ABA67A66
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 05:14:25 +1000 (EST)
Date: Thu, 25 May 2006 15:14:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Make cpufreq_transition_notifier a raw notifier
In-Reply-To: <1148582489.11759.42.camel@johannes.berg>
Message-ID: <Pine.LNX.4.44L0.0605251512510.8473-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 May 2006, Johannes Berg wrote:

> On Thu, 2006-05-25 at 13:53 -0400, Alan Stern wrote:
> 
> > Here's the patch Andrew asked for.  I have no idea whether it will solve 
> > any of these problems, and I'm certain that in the long run we shouldn't 
> > keep it.  Perhaps it will at least help stabilize 2.6.17.
> > 
> > It's up to you guys to see if the patch helps at all and to decide whether 
> > or not it should be applied.
> 
> Maybe I should note that I don't actually have seen any problems because
> of this, the kernel just warns about it. I guess that's because the
> semaphore won't ever actually be contended at that point.

The problem isn't contention for the semaphore.  The problem is that 
down_read() will enable interrupts even when the semaphore is not in 
contention, but parts of the cpufreq notifier chain need to execute with 
interrupts disabled.

Alan Stern
