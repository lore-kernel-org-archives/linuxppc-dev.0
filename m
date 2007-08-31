Return-Path: <dale@farnsworth.org>
Date: 31 Aug 2007 09:43:43 -0700
Message-ID: <20070831164343.452.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: joachim.bader@diehl-aerospace.de, Linuxppc-embedded@ozlabs.org
Subject: Re: [linux kernel 2.6.19] ethernet driver for Marvell bridge GT-64260
In-Reply-To: <OF71BAC825.59CE0529-ONC1257348.0056D44E-C1257348.0057BBA0@diehl-gruppe.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> I am porting linux kernel 2.6.19 on a platform based on PPC750FX together 
> with a Marvell GT64260.
> I use a patched 643xx driver which is back ported to 64260 by Steven J. 
> Hill.
> I have ethernet now up and running, but only if I switch debug on, which 
> generates a big bunch of screen messages.
> As soon as I switch debug off, I get the message "Virtual device %s asks 
> to queue packet!" on every transmission request.
> 
> This happens on ping an other system.
> 
> Has anyone experience in such an event? Is there anything how I can speed 
> up performance with the 64260?
> Is there a similar problem known with the 64360?

No, this does not happen on the mv64360.  As I recall, that message occurs
when something attempts to queue a packet to a driver that has called
netif_stop_queue() but hasn't yet called netif_wake_queue().  I would
guess that when you turn debug on, you are changing the driver logic
in addition to the timing.

-Dale
