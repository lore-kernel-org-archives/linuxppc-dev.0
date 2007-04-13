Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21C8CDDF28
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 05:25:39 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3DJPaGm003856
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 15:25:36 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3DJFo3e273882
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 15:17:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3DJC2pC022453
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 15:12:03 -0400
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 14:11:52 -0500
Message-Id: <1176491513.28514.66.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-13-04 at 17:47 +1000, Michael Ellerman wrote:
> Because this is a super tight performance critical inner loop I've
> changed it to use a shift instead of divide. So now it's more like 1.5%,
> but still the point is it increases faster as time passes.

Using a shift here is a good idea.  I had considered accelerating the
backoff value, but it got more complex than I wanted quickly.. I didnt
consider a shift. :-) 

> It'd be good if some more people can bang on this and see what they
> think of the interactivity.

Still works OK on my power4.   I can see the delay on my console, but
I'm specifically looking for it, I don't think it's an issue. 

> +#include <linux/debugfs.h>
> +static int hvc_debug_init(void)
> +{
> +	debugfs_create_u32("hvc_timeout", 0400, NULL, &timeout);
> +	return 0;
> +}
> +__initcall(hvc_debug_init);
> +

Is this part temporary for your graphing, or think it's something that
should go in? 
I used /proc/timer_stats output for my graphing, just dont have a good
public spot to upload the pics.. 

-will
