Return-Path: <stern@rowland.harvard.edu>
Received: from netrider.rowland.org (firewall.rowland.harvard.edu
	[140.247.233.35]) by ozlabs.org (Postfix) with SMTP id ABF0D67A3A
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 08:12:45 +1100 (EST)
Date: Fri, 24 Nov 2006 16:06:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Fixed compiled issue tu to new of_platform.h header
In-Reply-To: <1164401315.5653.89.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0611241557080.16422-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>, sl@bplan-gmbh.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 25 Nov 2006, Benjamin Herrenschmidt wrote:

> Now, Nico, since the patch has obviously a problem (thouh the problem
> might be generic to the way the USB code handles multiple versions of an
> HCI), it cannot be merged as-is of course.
> 
> Alan, what is your approach there ? We can't have multiple module_init()
> in a single file it seems... the ugly fix is to have one with a serie of
> #ifdef calling into the various HCI's but that's a big horrid.

I haven't been following this very closely.  The problem is that you have 
a system with two different kinds of OHCI controllers, thus requiring two 
different and incompatible versions of the driver?

If the only source of incompatibility is the module_init() and 
module_exit() routines, then your suggestion would be a simple fix.  
Ugly, yes, but I don't think anyone will really mind.

Is there anything else to prevent you from combining multiple HCIs into a
single driver?

Alan Stern
