Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id A4F0ADDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 22:07:29 +1100 (EST)
Date: Tue, 14 Oct 2008 13:07:23 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: [OT] Re: Floating inputs on unused GPIO pins
Message-ID: <20081014110723.GA2184@iram.es>
References: <200810131156.59477.laurentp@cse-semaphore.com>
	<c384c5ea0810130308q5cfa2c2ld8ea5eafec99bba3@mail.gmail.com>
	<200810131304.41435.laurentp@cse-semaphore.com>
	<48F34922.503@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48F34922.503@billgatliff.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[Marked off-topic because it is exclusively hardware related]

On Mon, Oct 13, 2008 at 08:12:02AM -0500, Bill Gatliff wrote:
> Laurent Pinchart wrote:
> 
> > 
> > There are no internal pull-up or pull-down resistors on the MPC8248 GPIO pins. I know our hardware engineer has a valid point theoretically. Does the point stand practically, or does the MPC8248 "state-of-the-art"(tm)(c)(whatever) technology make floating inputs safe ?
> 
> Well, Freescale's own layout recommendations recommend pullups or pulldowns for
> all input pins, but it's isn't clear what motivates that suggestion.
> 
> The block diagram, Figure 37-21, is less than helpful.  :)  I recall a doc
> somewhere that showed the input protection circuitry ends up providing a modest
> pullup/down, so the line never truly "floats".  

It's most of the time a couple of reverse biased diodes, one pulling to
the ground and the other to the I/O supply for that pin (there may be
several differnt I/O voltages in addition to a core voltage but I
digress). This prevents the input from going outside the ground to I/O
supply range (plus/minus diode threshholds) but can be considered
as essentially free floating inside that range.

The input may well end up floating at mid-level turning on both
transistors of the input gate (actually if the diodes are well matched,
it will, but don't try to measure it with a voltmeter).

> But it's a very high-impedance path, 

True and that's why it cannot be depended upon. The DC voltage
(not taking into account pickup to which it will be very sensitive)
and the impedance will depend on several internal (diode characteristics
and matching), ambient (temperature) and external factors (resistive pick
up through sub pA level surface currents from neighboring pins/tracks). 
Especially the effective impedance of the diode drops very rapidly with 
temperature (or if you prefer their leakage current increases with increasing 
temperature). This makes the circuit much more sensitive to AC pickup at
very low temperatures.

In this case the only sane solution is, unfortunately, adding external pullup
and or pulldown resistors. The resistor value can be high (47k to 1M) to limit
current waste when the signal does not have the default value. If you
expect most of your signals to be low most of the time, use pull-down
resistors, else use pull-ups (or select on a signal by signal basis if 
you can afford it, but this rule does not apply to the GPIO pin used
as a presence detect if there is one). 

	Regards,
	Gabriel
