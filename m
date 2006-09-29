Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ECF6167BC4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 02:42:48 +1000 (EST)
Date: Fri, 29 Sep 2006 09:42:45 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
Subject: Re: [PATCH] IBM GPIO driver for PowerPC 4xx is back from the dead
Message-ID: <20060929164245.GA17656@gate.ebshome.net>
References: <1159515965.5613.4.camel@jb-portable>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1159515965.5613.4.camel@jb-portable>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2006 at 09:46:04AM +0200, Jean-Baptiste Maneyrol wrote:
> Here is a patch for linux 2.6.18 that makes come back the old ibm gpio
> driver from 2.6.10.
> 
> It is mainly useful for compatibility with old linux 2.4 from Montavista
> I think, because direct memory access seems the new way to go.

In my opinion it should stay dead. And no, direct memory access isn't 
a way to go - how are you gonna provide synchronization in this case? 
Think about different processes mucking with GPIO registers.

I think such low-level functionality should never be exported to the 
user-space in the first place. If your user-space needs such access 
make it explicit through procfs/sysfs (e.g. 
/proc/sys/dev/my_board/reset_that_device for GPIO pin wired to some 
chip reset) or just make a specific driver for your hardware.

-- 
Eugene
