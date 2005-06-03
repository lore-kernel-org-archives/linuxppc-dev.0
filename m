Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 9D01367A05
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 17:10:14 +1000 (EST)
Date: Fri, 3 Jun 2005 00:20:27 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050603072027.GD30292@kroah.com>
References: <20050602140359.B24818@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050602140359.B24818@cox.net>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/5] RapidIO support: core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2005 at 02:03:59PM -0700, Matt Porter wrote:
> +static struct device rio_bus = {
> +	.bus_id = "rapidio",
> +};

Why do you need this device?  You shouldn't have a static struct device
to start with.  Or you just don't like having your root rio device
showing up in /sys/devices/ ?
If so, just create a kobject and put it there, and then base your
devices off of it, no need for a real device.

Oh wait, that's what the platform and system code does.  bah,
nevermind...

thanks,

greg k-h
