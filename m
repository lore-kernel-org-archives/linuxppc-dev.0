Return-Path: <jschopp@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FA70DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Sep 2008 05:17:50 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8QJHf9P011262
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 15:17:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8QJHbxN128380
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 13:17:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8QJHa4H003706
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 13:17:37 -0600
Message-ID: <48DD3546.3030109@austin.ibm.com>
Date: Fri, 26 Sep 2008 14:17:26 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
References: <bug-11629-10286@http.bugzilla.kernel.org/>	
	<20080923143057.e3e54536.akpm@linux-foundation.org>
	<1222332986.10563.35.camel@johannes.berg>
In-Reply-To: <1222332986.10563.35.camel@johannes.berg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	bugme-daemon@bugzilla.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> From: Johannes Berg <johannes@sipsolutions.net>
> Subject: powerpc: fix shutdown
>
> I tracked down the shutdown regression to CPUs not dying
> when being shut down during power-off. This turns out to
> be due to the system_state being SYSTEM_POWER_OFF, which
> this code doesn't take as a valid state for shutting off
> CPUs in.
>
> This has never made sense to me, but when I added hotplug
> code to implement hibernate I only "made it work" and did
> not question the need to check the system_state. Thomas
> Gleixner helped me dig, but the only thing we found is
> that it was added with the original commit that added CPU
> hotplug support.
>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joel Schopp <jschopp@austin.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>   
Tested this patch on a Power6 partition with cpu hotplug online/offline 
and some shutdown and reboot cycles.  Didn't see any ill effects.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>
