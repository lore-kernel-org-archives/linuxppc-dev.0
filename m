Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49D8BB7BC8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 02:33:52 +1100 (EST)
Date: Fri, 16 Oct 2009 10:33:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
Message-ID: <20091016153330.GB11838@loki.buserror.net>
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910151305.47100.borntraeger@de.ibm.com>
	<20091015160906.GA3730@loki.buserror.net>
	<200910152041.26646.borntraeger@de.ibm.com>
	<4AD770A9.6070509@freescale.com>
	<1255668405.19032.13.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255668405.19032.13.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	brueckner@linux.vnet.ibm.com, Timur Tabi <timur@freescale.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 16, 2009 at 03:46:45PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2009-10-15 at 13:57 -0500, Scott Wood wrote:
> > I'd say the dropping approach is quite undesirable (significant 
> > potential for output loss unless the buffer is huge), unless there's 
> > simply no way to safely spin.  Hopefully there are no such backends, but 
> > if there are perhaps we can have them return some special code to 
> > indicate that.
> 
> Should never spin.

Why is a hypervisor console different than a serial port in this regard?

> Best is to keep a copy in the upper layer of the pending data and throttle
> (not accept further data from tty layer) until we have managed to flush
> out that "pending" buffer.

The data isn't coming from the tty layer -- we're talking about printk.  How
do you throttle that without spinning?

I agree that it shouldn't spin when handling tty I/O.

-Scott
