Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4ECBDDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 10:20:13 +1100 (EST)
Date: Wed, 1 Apr 2009 10:10:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: sylvain.louchez@g4apps.com
Subject: Re: using IRQ1 in mpc5121ads
Message-ID: <20090331231000.GC23304@yookeroo.seuss>
References: <49d0d82a.09038e0a.585d.348b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49d0d82a.09038e0a.585d.348b@mx.google.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 10:33:11AM -0400, sylvain louchez wrote:
> Hello, I'm a newbie looking for where the documentation and implementation
> model can be found.
> 
>  
> 
> My custom driver is looking for an interrupt notification from the kernel -
> and it registers in the /proc/interrupts file as expected when installed,
> i.e.
> 
> $insmod custom_driver.ko gps_irq=<n>
> 
> **Note - this part's OK, I see the instance in /proc/interrupts after I load
> it**
> 
>  
> 
> On the hardware side the actual signal is a 1 Hz pulse (from GPS) routed to
> IRQ1 through the board's CPLD. This is the only interrupt on IRQ_1 so we can
> keep the logic simple i.e. on IRQ1 we can just jump to the service routine
> in a custom driver.
> 
>  
> 
> I understand 2 things have to be done:
> 
>  
> 
> 1. create an entry in the dts file; I think we've got this understood
> through advice already received - for example the new interrupt entry can be
> created in the dts file - something like:
> 
>  
> 
> gps@0 {      // there is no address so just make it 0
> 
>     compatible = "gps_interrupt";

Sorry, this is not relevant to your actual question, but this is not a
good 'compatible' value.  You should use the "vendor,model" convention
here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
