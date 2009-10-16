Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1327B7BF4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 05:03:52 +1100 (EST)
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20091016153330.GB11838@loki.buserror.net>
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910151305.47100.borntraeger@de.ibm.com>
	<20091015160906.GA3730@loki.buserror.net>
	<200910152041.26646.borntraeger@de.ibm.com>
	<4AD770A9.6070509@freescale.com> <1255668405.19032.13.camel@pasglop>
	<20091016153330.GB11838@loki.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 17 Oct 2009 05:03:24 +1100
Message-Id: <1255716204.19032.27.camel@pasglop>
Mime-Version: 1.0
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

On Fri, 2009-10-16 at 10:33 -0500, Scott Wood wrote:
> On Fri, Oct 16, 2009 at 03:46:45PM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2009-10-15 at 13:57 -0500, Scott Wood wrote:
> > > I'd say the dropping approach is quite undesirable (significant 
> > > potential for output loss unless the buffer is huge), unless there's 
> > > simply no way to safely spin.  Hopefully there are no such backends, but 
> > > if there are perhaps we can have them return some special code to 
> > > indicate that.
> > 
> > Should never spin.
> 
> Why is a hypervisor console different than a serial port in this regard?

Ah sorry, yeah, struct console can I suppose, it's the tty that
shouldn't.

> > Best is to keep a copy in the upper layer of the pending data and throttle
> > (not accept further data from tty layer) until we have managed to flush
> > out that "pending" buffer.
> 
> The data isn't coming from the tty layer -- we're talking about printk.  How
> do you throttle that without spinning?
> 
> I agree that it shouldn't spin when handling tty I/O.

Ben.
