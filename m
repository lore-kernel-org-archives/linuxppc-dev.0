Return-Path: <hollis@penguinppc.org>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64745679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 01:33:09 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.esmtp.ibm.com [9.14.4.133])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j51FV4uS004908
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2005 11:31:05 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j51FUwMK566182
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2005 11:30:59 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j51FUwMM127794
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2005 09:30:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j51FUvgR016464
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jun 2005 09:30:58 -0600
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2D@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2D@exnet.3il.fr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <df1a94db40adc6c8e7e0d4baa12be9c4@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Wed, 1 Jun 2005 10:31:09 -0500
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: copy_from_user( ) problem...help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 1, 2005, at 9:00 AM, Garcia J=E9r=E9mie wrote:

> Hi everybody,
> I'm tryin to write some device drivers modules in order to manage some=20=

> of our devices of our ppc405EP based board.
> I read the Allessandro Rubini book (Linux Kernel device drivers) in=20
> order to help me.
> Before going on difficult stuff, I'd like to make some basic training=20=

> and experiments.
> What I want to do seems to be very easy (but...):
>  - a user space programm has a global structure and contains an=20
> integer and a char
>  - the user space programm loads the module with a parameter: the=20
> structure address
>  - during the init_module(),I check that the address can be accessed=20=

> in R/W mode with the access_ok()
>  - the module copies the user structure in its own context and prints=20=

> the values retreived

When you do your copy_from_user, what guarantee do you have that the=20
user process is your test application? If anything, I would expect it=20
to be insmod (you can printk current->comm to see). Instead you could=20
implement a write method and create a device node for the user app to=20
open and write to.

However, for this specific example that's not in good style. If all you=20=

really want to do is communicate settings to a kernel module, have a=20
look at sysfs.

-Hollis=
