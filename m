Return-Path: <strosake@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90849DDEA2
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 06:26:58 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAUJQqPt011353
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 14:26:52 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAUJQpIj114744
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 12:26:51 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAUJQpqD005094
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 12:26:51 -0700
Message-ID: <475063FA.50008@austin.ibm.com>
Date: Fri, 30 Nov 2007 13:26:50 -0600
From: Mike Strosaker <strosake@austin.ibm.com>
MIME-Version: 1.0
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
References: <20071120012815.GB7969@austin.ibm.com>	<1196208960.11297.26.camel@farscape.rchland.ibm.com>	<20071130165651.b1b7c16c.sfr@canb.auug.org.au>
	<1196439093.11297.52.camel@farscape.rchland.ibm.com>
In-Reply-To: <1196439093.11297.52.camel@farscape.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:
>>From my reading of the papr, I've got the impression that there are two
> possibilities.    
> 
> First, the os-term never returns, and it's up to the service processor
> to do whatever it's going to do.  (call home, dump, something else).
> Nothing we can do there. 
> 
> Second, os-term returns, and it's up to the OS to call into power-off or
> system-reboot.
> I think this is more likely.   I havn't followed the path back from
> machine_restart to see exactly how we got there, but probably means a
> bit more logic to decide whether to call into rtas_restart() or
> pSeries_power_off() after the call to machine_shutdown.

My understanding was that os-term is supposed to indicate an "abnormal" 
termination, which is why it was initially only associated with a panic.

The os-term behavior is kind of complex; there is both a standard behavior, and 
an "extended" behavior.  You can determine if the extended behavior will be used 
by looking for the ibm,extended-os-term property.  I think POWER5 largely uses 
the older behavior, and POWER6 uses the extended behavior.

I've never seen os-term return using the old behavior.  Whether the partition 
reboots after calling os-term depends on the setting of the 
partition_auto_restart RTAS parameter.  If partition_auto_restart is 1 when 
os-term is called, the hypervisor will restart the partition and reset 
partition_auto_restart to 0.  The OS is supposed to set partition_auto_restart 
back to 1 after it boots; that way, if the OS is failing to boot, the hypervisor 
won't continually try to restart the partition without any hope of success. 
That's why Linas sent a patch with a pSeries_auto_restart routine.

If the extended os-term behavior is used, the os-term call is supposed to return 
unless the ibm,configure-kernel-dump call was previously used (to prepare for a 
PHYP assisted dump).  Would that explain why Linas and Will are seeing different 
behaviors?  I may have missed it, but I don't see a check for 
ibm,extended-os-term anywhere.

- Mike
