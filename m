Return-Path: <stern@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id D5978DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 08:52:21 +1100 (EST)
Date: Mon, 12 Nov 2007 16:52:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Re: [RFC] powermac: proper sleep management
In-Reply-To: <1194900998.18185.57.camel@pasglop>
Message-ID: <Pine.LNX.4.44L0.0711121641320.5531-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Nov 2007, Benjamin Herrenschmidt wrote:

> I remember fixing various issues so that khubd would be safe when non
> frozen (among other things) a while ago. Did you guys break it all
> again ?

Sorry, I don't know what fixes you're referring to.  But come to 
think of it, some changes I added to the PM core a few months ago 
(locking every device prior to system sleep) would also make khubd 
and ksuspend_usbd safe, since they acquire the device lock before 
trying to resume anything.

So I take back what I said.  It's no longer true that those two USB 
kernel threads need to be frozen for system sleep.  (I should test and 
make sure that really works...)

But aren't there other kernel threads scattered around that still 
want to be frozen?  For instance, drivers/misc/tifm_core.c calls 
create_freezeable_workqueue().  And set_freezable() gets called in lots 
of places.

Alan Stern
