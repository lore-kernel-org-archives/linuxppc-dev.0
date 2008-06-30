Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61A3CDE256
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:22:26 +1000 (EST)
In-Reply-To: <1214795032.9125.7.camel@pek-cluo>
References: <1214795032.9125.7.camel@pek-cluo>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <34080997e6c29d809a38331f88caf3cf@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] mpc7448hpc2.dts: remove chosen node from dts
Date: Mon, 30 Jun 2008 18:22:09 +0200
To: chunbo.luo@windriver.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Modern versions of u-boot create a chosen node automatically.  So if
> we set the chosen node in the dts file, there will be 2 chosen nodes
> passed in to the kernel,

That's a bug in uboot, then: when it creates a property, it should
delete an already existing property with the same name in that node.

> and the kernel command line will be taken from
> the wrong node.  So, remove the extra chosen node from the dts file.

This will cause a regression for people using an older version of
uboot.  No idea how important that is.


Segher
