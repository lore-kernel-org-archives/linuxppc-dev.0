Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD563DDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:31:04 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1FKUnkm000314
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:30:49 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45D4C2CB.2080703@246tNt.com>
Date: Thu, 15 Feb 2007 21:30:03 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: Why do the rh_alloc functions return a pointer?
References: <45D4B486.7030409@freescale.com>
In-Reply-To: <45D4B486.7030409@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The rh_alloc functions (rh_alloc, rh_alloc_fixed, rh_alloc_align) all return a 
> "void *".  However, the actual value passed is an offset into a block of memory. 
>   In most cases, the first time rh_alloc is called, it returns zero.
>
> There are several wrapper functions for rh_alloc, and all of them cast the 
> return value to an unsigned integer.
>
> So my question is, why do the rh_alloc functions return a pointer?  Shouldn't 
> they all return a u32 or uint?
>   
I talked about it with Panto on IRC a few days ago.

And he agrees that the function could be changed to user "unsigned long"
instead of "void *".

Note the long and not int. Because an user may want it to manage pointer
directly so
it must stiff be able to handle pointer even in 64 bits.
But since all current user use rh to manage offset changing it to
"unsigned long" and
getting rid of the unnecessary casts would be a good idea IMHO.


    Sylvain
