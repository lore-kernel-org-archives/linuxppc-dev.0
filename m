Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2229DDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 01:42:14 +1100 (EST)
Message-ID: <49C3AB35.4080700@freescale.com>
Date: Fri, 20 Mar 2009 09:41:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
References: <3A45394FD742FA419B760BB8D398F9ED29EB95@zch01exm26.fsl.freescale.net>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED29EB95@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang-R58472 wrote:
>> However, the code should treat "mem" as "standby" on chips 
>> that don't support deep sleep.  What does the device tree 
> 
> Well, shouldn't the valid() callback reject unsupported states instead
> of covering up?

I don't think so, in this case.  The user is not asking for "sleep" or 
deep sleep"; they are asking for a power state that meets the definition 
of "standby" (which sleep does) or which meets the definition of "mem" 
(which both sleep and deep sleep do).  When the user asks for "mem", we 
provide the lowest power mode that qualifies.

I'm willing to change it if there's substantial existing practice to the 
contrary, though.

-Scott
