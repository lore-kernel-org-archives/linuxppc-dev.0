Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 896E6DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 01:20:26 +1000 (EST)
Message-ID: <49F5CD10.9010801@freescale.com>
Date: Mon, 27 Apr 2009 10:19:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andres Marquez <amarquez@edgeaccess.net>
Subject: Re: Enable Serial Management Controller (SMC) in MPC8265
References: <1240530625.31311.20.camel@localhost.localdomain>
	<1240839625.3643.19.camel@localhost.localdomain>
In-Reply-To: <1240839625.3643.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Nirmala Kakkuppi <nkakkuppi@edgeaccess.net>, linuxppc-dev@ozlabs.org,
	Haysam Rachid <hrachid@edgeaccess.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andres F Marquez wrote:
>      After struggling for several days with this issue we have finally
> taken a different approach to solve our problem. We wanted to interface
> our CPU (MPC8265) with a FPGA through a serial connection. Now, we are
> using a parallel interface through the data bus (defining a new memory
> region in uboot -an additional chip select).

That sounds much better.

>      We tried enabling SCC's and SMC's through the kernel configuration
> in ltib,

LTIB doesn't alter device trees AFAIK...  Unless you have more than two 
CPM serial nodes, you won't get more than ttyCPM0 and ttyCPM1.

> but we were always getting the same tty devices device under
> "/dev". No matter how many SCC's or SMC's we enable we were always
> getting only /dev/ttyCPM0 and /dev/ttyCPM1. 

Do you have a static /dev, or are you running mdev or udev?  If the 
latter, then any changes in the kernel or device tree are not going to 
automatically show up in /dev.

-Scott
