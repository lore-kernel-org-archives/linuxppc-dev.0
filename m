Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A750DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 16:26:43 +1100 (EST)
Date: Fri, 25 Jan 2008 21:24:54 -0800
From: Greg KH <gregkh@suse.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 063/196] kset: convert /sys/devices to use kset_create
Message-ID: <20080126052454.GA27403@suse.de>
References: <20080125071127.GA4860@kroah.com>
	<1201245134-4876-63-git-send-email-gregkh@suse.de>
	<20080126034055.GA28786@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080126034055.GA28786@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Kay Sievers <kay.sievers@vrfy.org>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 09:40:55PM -0600, Olof Johansson wrote:
> On Thu, Jan 24, 2008 at 11:10:01PM -0800, Greg Kroah-Hartman wrote:
> > Dynamically create the kset instead of declaring it statically.  We also
> > rename devices_subsys to devices_kset to catch all users of the
> > variable.
> 
> Guess what, you broke powerpc again!

I did this ON PURPOSE!!!

The linux-kernel archives hold the details, and I was told by the PPC64
IBM people that they would fix this properly for 2.6.25, and not to hold
back on my changes.  This has been known for many months now.

> olof@quad:~/work/linux/k.org $ git grep devices_subsys
> arch/powerpc/kernel/vio.c:extern struct kset devices_subsys; /* needed for vio_find_name() */
> arch/powerpc/kernel/vio.c:      found = kset_find_obj(&devices_subsys, kobj_name);
> 
> Obviously causes build failues, even of ppc64_defconfig.
> 
> (I can unfortunately not boot test, since I lack hardware that uses vio)
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 19a5656..ee752ab 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -37,7 +37,7 @@
>  #include <asm/iseries/hv_call_xm.h>
>  #include <asm/iseries/iommu.h>
>  
> -extern struct kset devices_subsys; /* needed for vio_find_name() */
> +extern struct kset *devices_kset; /* needed for vio_find_name() */

No, this just papers over the real problem here.  For some reason, the
vio code thinks it is acceptable to walk the whole device tree and match
by a name and just assume that they got the correct device.  You call
this "enterprise grade"?  :)

You need to just put your device on a real bus, and then just walk the
bus.  That's the ONLY way you can guarantee the proper name will return
what you want, and you get the pointer that you really think you are
getting.

There is a reason that devices_kset is not exported, don't make me go
and have to name it something like:
	devices_kset_dont_touch_this_or_gregkh_will_make_fun_of_you

Or I'll just mush 3 files in the driver core together and keep the
symbol from being accessible at all.

So no, I'm going to leave the build broken for this code, because that
is what it really is.

Please fix it correctly.

thanks,

greg k-h
