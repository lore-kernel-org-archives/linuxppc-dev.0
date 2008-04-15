Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 2BEE1DE282
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 23:40:09 +1000 (EST)
Date: Tue, 15 Apr 2008 17:40:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC] GPIO-based flow control in the cpm_uart driver
Message-ID: <20080415134007.GA17096@polina.dev.rtsoft.ru>
References: <200804151522.36884.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804151522.36884.laurentp@cse-semaphore.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2008 at 03:22:33PM +0200, Laurent Pinchart wrote:
> Hi everybody,
> 
> I'm implementing flow control and modem control lines support in the cpm_uart 
> driver.
> 
> The implementation is based on the GPIO lib. Modem control lines are described 
> in the device tree as GPIO resources and accessed through the OF GPIO 
> bindings. The I/O ports have to be initialized as GPIOs in the 
> platform-specific code.
> 
> Reading and writing the modem control lines isn't an issue, but activating 
> hardware flow control is more complex. The driver needs to turn dedicated 
> functions on and off for the RTS and CTS signals, and the GPIO API doesn't 
> provide a way to access the PPAR* registers (which does make sense - although 
> arguably - as PPAR* control specific functions, not GPIOs).
> 
> Hardcoding RTS and CTS lines control in the driver is not an option I want to 
> consider. Extending the GPIO API to handled special functions has been nacked 
> in the past (see 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051241.html). An 
> option would be to export gpio_to_chip from drivers/gpio/gpiolib.c and use 
> cpm1/2_set_pin in the cpm_uart driver.

Since you have successfuly ported QE USB controller onto CPM USB
hardware, now it's obvious that we will need generic gpio_set_dedicated()
function. So I would rather beg David to accept gpio_set_dedicated()
approach instead of exporting gpio_to_chip(). That way we'll kill two
birds with one stone.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
