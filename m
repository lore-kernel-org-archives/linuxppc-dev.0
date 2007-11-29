Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A50F5DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 04:20:13 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lATHK9o5020161
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 12:20:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lATHK8hL119486
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:20:08 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lATHK8tn014210
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:20:08 -0700
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>, Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20071128201838.GH19584@austin.ibm.com>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
	<20071128201838.GH19584@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 11:19:50 -0600
Message-Id: <1196356790.11297.36.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-28 at 14:18 -0600, Linas Vepstas wrote:
> On Tue, Nov 27, 2007 at 06:15:59PM -0600, Will Schmidt wrote:
> > (resending with the proper "from" addr this time). 
> > 
> > 
> > I'm seeing some funky behavior on power5/power6 partitions with this
> > patch.    A "/sbin/reboot" is now behaving much more like a
> > "/sbin/halt".
> > 
> > Anybody else seeing this, or is it time for me to call an exorcist for
> > my boxes? 
> 
> I beleive the patch
> http://www.nabble.com/-PATCH--powerpc-pseries:-tell-phyp-to-auto-restart-t4847604.html
> 
> will cure this problem.

It does not.   this code is getting called, but still turns the box into
a doorstop at /sbin/reboot. 

It does clear up if I apply this patch, which is a revert of part of
your earlier patch.

My js2X also turns into a doorstop after /sbin/reboot..     Though I'm
not going through a panic path, I wonder if the panic portion is OK and
this is what Olaf is hitting.  

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fdeefe5..c9fac5a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -508,7 +508,7 @@ define_machine(pseries) {
 	.power_off		= pSeries_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_panic_msg,
-	.machine_shutdown	= rtas_os_term,
+/*	.machine_shutdown	= rtas_os_term,*/
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
