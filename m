Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCA5A67BEA
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 17:53:53 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAR741X1202080
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 18:04:05 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAR6tQfV116106
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 17:55:50 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAR6pw8D006610
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 17:51:58 +1100
Message-ID: <456A9E2A.7030606@in.ibm.com>
Date: Mon, 27 Nov 2006 13:43:30 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
References: <20061123021132.B03F767C18@ozlabs.org>
In-Reply-To: <20061123021132.B03F767C18@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ego@in.ibm.com, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ntl@pobox.com,
	linas@boardhead.austin.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Currently we unconditionally hookup pSeries_mach_cpu_die to ppc_md.cpu_die,
> even if we don't have CONFIG_HOTPLUG_CPU enabled. This is wrong, as it
> signals the sysfs code to create the online attribute for cpu nodes,
> allowing the user to attempt an offline when it's not actually supported.
>
> There is also a problem on systems that don't have the correct RTAS tokens
> available to do RTAS-based cpu hotplug, we still indicate via sysfs that
> we support cpu hotplug - and then attempt to do so with missing RTAS tokens.
>
> Both problems are solved by conditionally registering the cpu hotplug
> callbacks, only when CONFIG_HOTPLUG_CPU is enabled, and only after we've
> found the requisite RTAS tokens.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>
> Updated to printk if we can't find the RTAS tokens, and to remove the
> comment about drslot_chrp_cpu etc.
>
> Linas, Srinivasa, can you test that this addresses the problems you
> were seeing. It should, but it'd be good if you could test it.
>   
I tested your patch,it works fine. I didn't see "online" file on my JS20 
system.

Thanks
 Srinivasa DS
 Linux technology centre
 IBM-ISL Bangalore
 


 
> cheers
>
>   
