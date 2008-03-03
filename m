Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 6C6A5DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:40:52 +1100 (EST)
Date: Mon, 3 Mar 2008 15:40:28 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2 v2] [POWERPC] Ignore disabled serial ports
Message-ID: <20080303214028.GE4712@localdomain>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301081746.689a0a17@zod.rchland.ibm.com>
	<200803030443.43346.arnd@arndb.de>
	<20080302224317.15f259ca@zod.rchland.ibm.com>
	<20080303190925.GA6735@loki.buserror.net>
	<20080303132107.67200634@weaponx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080303132107.67200634@weaponx>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Mon, 3 Mar 2008 13:09:25 -0600
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > On Sun, Mar 02, 2008 at 10:43:17PM -0600, Josh Boyer wrote:
> > > On Mon, 3 Mar 2008 04:43:42 +0100
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > > > I wonder whether we should move the check for "used-by-rtas" into the
> > > > of_device_is_available function. I understand that used-by-rtas is
> > > > another way of expressing the idea that the kernel is not supposed to
> > > > access the specific device. In this case, the device is physically
> > > > present, but is not available to the OS.
> > > 
> > > I'd rather not at the moment.  My intention was to only look at the
> > > status property for now.  I'd like to avoid this function growing into
> > > a huge switch statement for $random_firmware's way of flagging
> > > something as "don't touch".
> > 
> > Better that than having the "huge" list of tests in every driver...
> 
> Perhaps.
> 
> This isn't set in stone.  I'd rather get what's in the patch in-tree
> now and massage it as we go.  Otherwise this bike shed will wind up
> being rainbow colored yet totally useless because it's a never-ending
> patch rework.

I agree.  Josh's patch is immediately useful to other code as-is.

used-by-rtas is powerpc-specific and doesn't belong in drivers/of IMO.
