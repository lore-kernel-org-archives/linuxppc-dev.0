Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18733.56480.373527.669097@cargo.ozlabs.ibm.com>
Date: Thu, 27 Nov 2008 10:32:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH v2] of_gpio: Return GPIO flags from of_get_gpio()
In-Reply-To: <Pine.LNX.4.64.0811261423120.5161@t2.domain.actdsltmp>
References: <20081030111500.GB22008@oksana.dev.rtsoft.ru>
	<1225418589-8545-1-git-send-email-tpiepho@freescale.com>
	<20081126162033.GA13397@oksana.dev.rtsoft.ru>
	<18733.49643.63081.163437@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0811261423120.5161@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho writes:

> > Alternatively you could add a new function (called, for instance,
> > of_get_gpio_flags) with the extra parameter to eliminate the need to
> > change any drivers at this stage, since they all seem to pass NULL for
> > the flags argument.
> 
> But if we did this every time any exported function needs to change, think
> how bloated the API would be with cruft.

I don't buy the argument that we can't add one thing because if we
added a hundred that would be too much.  You could add
of_get_gpio_flags, get that upstream, then get the driver patches
upstream, then submit a patch to remove of_get_gpio.  Alternatively
you could make of_get_gpio a macro or inline function in of_gpio.h.

If you really want to change everything in one hit you'll have to get
acks + agreement for the change to go upstream via my tree from all
the relevant driver maintainers first.  I don't see any particular
advantage to doing it that way, though.

Paul.
