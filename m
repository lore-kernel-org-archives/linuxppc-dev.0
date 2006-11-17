Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2407F67BAC
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 05:05:05 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAHI4wkp014440
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 13:04:58 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAHI4wmN403774
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 11:04:58 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAHI4vjK001047
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 11:04:58 -0700
Date: Fri, 17 Nov 2006 12:04:57 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
Message-ID: <20061117180456.GG23600@austin.ibm.com>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061117033638.0E24B67BCE@ozlabs.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: srinivasa@in.ibm.com, ego@in.ibm.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Anton Blanchard <anton@samba.org>, ntl@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 02:36:35PM +1100, Michael Ellerman wrote:
> The pseries cpu hotplug code is currently spread between ./kernel/rtas.c,
> ./platforms/pseries/smp.c and ./platforms/pseries/setup.c. Some of it is
> not #ifdef CONFIG_HOTPLUG_CPU, but it should be.
> 
> So move all the cpu hotplug code into platforms/pseries/hotplug-cpu.c

Yes, much cleaner this way.

> +	/* Isolation and deallocation are definatly done by
                                        ^^^^^^^^^
typo

> +	 * drslot_chrp_cpu.  If they were not they would be
> +	 * done here.  Change isolate state to Isolate and
> +	 * change allocation-state to Unusable.
> +	 */
> +	paca[cpu].cpu_start = 0;

I can't figure out what the comment means with respect 
to this code ... 

--linas
