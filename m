Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8E979DE119
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 01:30:47 +1100 (EST)
Date: Thu, 3 Apr 2008 18:30:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Message-ID: <20080403143052.GA5955@polina.dev.rtsoft.ru>
References: <20080311191744.GA10518@localhost.localdomain>
	<200804031545.51834.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804031545.51834.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 03:45:47PM +0200, Laurent Pinchart wrote:
> Hi Anton,
> 
> On Tuesday 11 March 2008 20:17, Anton Vorontsov wrote:
> > This is patch adds support for the FHCI USB controller, as found
> > in the Freescale MPC836x and MPC832x processors. It can support
> > Full or Low speed modes.
> > 
> > Quite a lot hardware is doing by itself (SOF generation, CRC generation
> > and checking), though scheduling and retransmission is on the software
> > shoulders.
> > 
> > This controller does not integrate the root hub, so this driver also
> > fakes an one-port hub. External hub is required to support more than
> > one device.
> 
> Would it be possible to use the driver for CPM2-based devices ?

Probably. But no one had tried this yet.

> The only 
> difference I found between the CPM2 and QE USB controllers is the SOF 
> handling. The QE USB controller increments the frame number itself, while the 
> CPM USB controller requires the host to increment the frame number.
> 
> At first sight the driver depends on qe_lib for:
> 
> - muram allocation (qe_muram_alloc/free, qe_muram_offset/addr)

Yeah, I already posted a patch to deal with it, see
http://ozlabs.org/pipermail/linuxppc-dev/2008-March/053249.html
(btw... Scott, Timur did you have a chance to look into this?)

> - GPIO access (qe_gpio_set_dedicated)

This is because of David Brownell. ;-) Specifically, unwillingness to
accept that set_dedicated is portable for some scope of GPIO controllers,
as well as GPIO users.

> - clock routing (qe_clock_source, qe_usb_clock_set)

Well, there is Linux CLK API (somewhat similar to GPIO API), but PowerPC
doesn't use it yet. Neither I can tell if CLK API is suitable for our
needs, or if it needs to be extended. Quick&dirty workarounds are
still possible though, but clk api is the right way to go.

> - QE commands execution (qe_issue_cmd)

No proper solution yet.

> It shouldn't be too difficult to abstract those operation in a fashion similar 
> to the cpm_uart driver.

Yup, but we still have ucc_serial (QE) and cpm_uart (CPM1/2) drivers as
separate matters though. ;-) I didn't look for the reasons of this split
but I assume there are and they're strong enough.

> Have you already worked on CPM2 support,

Nope, I don't have CPM2 board to work on.

> or thought about any particular issue 
> I should pay attention to ?

Nope, sorry.

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
