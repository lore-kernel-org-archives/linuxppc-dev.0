Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F4322BDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 09:54:02 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <41ACE8B0.8090307@246tNt.com>
References: <41ACE8B0.8090307@246tNt.com>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 09:53:44 +1100
Message-Id: <1101855224.5174.17.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Implementing PowerManagment for a ppc target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2004-11-30 at 22:40 +0100, Sylvain Munaut wrote:
> Hi,
> 
> I'm trying to implement Deep Sleep support for a ppc platform based on 
> 5200 and I have some questions :
> 
>  - How should I "integrate" it to linux, what the proper way ? I've been 
> trying #defining CONFIG_PM and
>    using the set_pm_ops operation but my call backs never get called 
> when doing a echo standby > /sys/power/state
> 
> It justs says :
> 
> $ echo standby > 
> /sys/power/state                                                                     
> 
> Stopping tasks: 
> ===                                                                                   

Looks like a kernel thread isn't properly stopping ... note that on
pmac, I don't call that PM core, I do my own salad which does not
involve stopping tasks...

>  stopping tasks failed (2 tasks 
> remaining)                                                           
> Restarting tasks...<6> Strange, init not 
> stopped                                                     
>  Strange, sh not 
> stopped                                                                              
> 
>  done                                                                                                 
> 
> Stopping tasks: 
> ===                                                                                   
> 
>  stopping tasks failed (2 tasks 
> remaining)                                                           
> Restarting tasks...<6> Strange, init not 
> stopped                                                     
>  Strange, sh not 
> stopped                                                                              
> 
>  done                 
> 
> I've been trying to look at Documentation/ and the sources but still I'm 
> not sure ...
> 
> 
>  - How can I ensure that one of my function runs out of I Cache ? Some 
> pieces of assembler needs to not
>    acces memory when the last 'orders' are sent. Does just keeping it 
> small and aligned enough ?

Can you explain more precisely why and what are your precise
requirements ? (You can catch me on irc eventually) 
 
> 
> Thanks,
> 
>     Sylvain Munaut
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
