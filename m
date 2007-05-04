Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADE5BDDED1
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 06:10:27 +1000 (EST)
Date: Fri, 4 May 2007 13:09:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Re: 2.6.21-rc7-mm2 -- hvsi console driver registration
	failure
Message-Id: <20070504130952.b43fc676.akpm@linux-foundation.org>
In-Reply-To: <4fe4528cb20beb569a8f2ac817c776e5@pinky>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org>
	<4fe4528cb20beb569a8f2ac817c776e5@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, paulus@samba.org,
	linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 04 May 2007 12:38:58 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> 
> Trying to get 2.6.21-rc7-mm2 to boot on large PPC64 seems to be a
> bit of a challenge.  We have been seeing panics on boot from the
> hvsi driver:
> 
> 	Couldn't register hvsi console driver
> 
> Tracking this back, this seems to come from hvsi driver trying to
> register itself via tty_register_driver() with a zero units.
> 
> The failure is triggered by a change in semantics for kmalloc()
> between SLAB and SLUB; kmalloc(0) now returns NULL rather than an
> allocation at the smallest size.  Looking at the code in question
> even when the allocation succeeds we will not actually use the
> memory when device->num is zero.

OK, thanks for working that out.

Christoph, we should be emitting loud warnings so that this problem is easy
to debug.

Better, we should be emitting loud warnigns which then disable themselves
and then succeeding the allocation so that people can proceed with their
kernel testing.

When all the loud-warning sites have been fixed, we can take that code out
again.

The present situation is maximally tester-hostile.

> It is not clear to me if this is a bug in the hvsi driver in that
> it should specify some units.  It seems we will try and reserve zero
> devices in this case, which seems pointless.
> 
> I have tested with the patch below which seems safe to me and stops
> the errors and even seems to make the console work.  But perhaps
> someone with more driver fu, could verify if driver->num of zero
> has any meaning and kick this to the hvsi people if not.
> 
> -apw
> 
> === 8< ===
> tty_register_driver: only allocate tty instances when defined
> 
> If device->num is zero we attempt to kmalloc() zero bytes.
> When SLUB is enabled this returns a null pointer and take that as
> an allocation failure and fail the device register.  Check for no
> devices and avoid the allocation.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> ---
> diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> index 959a616..71c4579 100644
> --- a/drivers/char/tty_io.c
> +++ b/drivers/char/tty_io.c
> @@ -3724,7 +3724,7 @@ int tty_register_driver(struct tty_driver *driver)
>  	if (driver->flags & TTY_DRIVER_INSTALLED)
>  		return 0;
>  
> -	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM)) {
> +	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM) && driver->num) {
>  		p = kmalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
>  		if (!p)
>  			return -ENOMEM;
