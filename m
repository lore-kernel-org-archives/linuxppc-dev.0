Return-Path: <strosake@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55EDD67C5F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 04:33:57 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7PIXnwT020239
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 14:33:49 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7PIXpSU234536
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 14:33:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7PIXpAo008125
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 14:33:51 -0400
Message-ID: <44EF428B.8010100@austin.ibm.com>
Date: Fri, 25 Aug 2006 13:33:47 -0500
From: Mike Strosaker <strosake@austin.ibm.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] reboot when panic_timout is set
References: <20060821161132.GA31085@aepfle.de>
In-Reply-To: <20060821161132.GA31085@aepfle.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:

>Only call into RTAS when booted with panic=0 because the RTAS call does not return.
>The system has to be rebooted via the HMC or via the management console right now.
>This is cumbersome and not what the default panic=180 is supposed to do.
>  
>
The os-term call is supposed to indicate to the platform that it should 
follow it's abnormal OS termination policy.  I normally set my 
partitions to reboot immediately after an os-term call.  I believe that 
"/usr/sbin/serv_config -b" (installed with powerpc-utils-papr) is used 
to set that policy from the command line.

In general, I think it's best to have the OS follow the policy stored on 
the platform whenever possible.  Some systems can be configured to 
perform system administrator calls/pages, and there may be some other 
configurable options, too; it would be a shame to have a sysadmin set up 
an automatic reboot and a page, and have neither happen because he 
didn't know that the default OS policy of a three-minute reboot overrode 
the policy he just defined.

Thanks,
Mike

>Signed-off-by: Olaf Hering <olh@suse.de>
>
>---
> arch/powerpc/kernel/rtas.c |    3 +++
> 1 file changed, 3 insertions(+)
>
>Index: linux-2.6.18-rc4/arch/powerpc/kernel/rtas.c
>===================================================================
>--- linux-2.6.18-rc4.orig/arch/powerpc/kernel/rtas.c
>+++ linux-2.6.18-rc4/arch/powerpc/kernel/rtas.c
>@@ -628,6 +628,9 @@ void rtas_os_term(char *str)
> {
> 	int status;
> 
>+	if (panic_timeout)
>+		return;
>+
> 	if (RTAS_UNKNOWN_SERVICE == rtas_token("ibm,os-term"))
> 		return;
> 
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  
>
