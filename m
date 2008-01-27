Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B002DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 16:31:51 +1100 (EST)
Date: Sat, 26 Jan 2008 21:36:06 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix powerpc vio_find_name to not use devices_subsys
Message-ID: <20080127053606.GA24306@kroah.com>
References: <18331.54314.379281.960297@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18331.54314.379281.960297@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 27, 2008 at 11:45:30AM +1100, Paul Mackerras wrote:
> This fixes vio_find_name() in arch/powerpc/kernel/vio.c, which is
> currently broken because it tries to use devices_subsys.  That is bad
> for two reasons: (1) it's doing (or trying to do) a scan of all
> devices when it should only be scanning those on the vio bus, and
> (2) devices_subsys was an internal symbol of the device system code
> which was never meant for external use and has now gone away, and
> thus the kernel fails to compile on pSeries.
> 
> The new version uses bus_find_device() on the vio bus (vio_bus_type).
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Greg, do you want to send this to Linus or will I do that?  Or do you
> have a better version? :)

I'll send it to him, with a minor change (I'm going to make this a core
function, as others also use the same functionality, no need for
everyone to re-invent the wheel all the time.

I also have some other patches to send him to fix up the fall-out of
these driver core changes :)

thanks,

greg k-h
