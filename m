Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE182DDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 03:11:43 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAUGBYHD011581
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:11:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAUGBWYS195998
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 09:11:32 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAUGBW3i011399
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 09:11:32 -0700
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071130165651.b1b7c16c.sfr@canb.auug.org.au>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
	<20071130165651.b1b7c16c.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 10:11:32 -0600
Message-Id: <1196439093.11297.52.camel@farscape.rchland.ibm.com>
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


On Fri, 2007-11-30 at 16:56 +1100, Stephen Rothwell wrote:
> On Tue, 27 Nov 2007 18:15:59 -0600 Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
> >
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
> On my Power5+ box, I get an error (code B200A101) logged every time I
> reboot and about half the time, the machine does not reboot but need to
> be power cycled. Removing the cited patch makes the error not by logged
> and reboots work fine.
> 
> Paul and I have been having a look at this and Paul has asked the
> architects for clarification of when os-term should be used.

The architects will have the correct answer of course.   

>From my reading of the papr, I've got the impression that there are two
possibilities.    

First, the os-term never returns, and it's up to the service processor
to do whatever it's going to do.  (call home, dump, something else).
Nothing we can do there. 

Second, os-term returns, and it's up to the OS to call into power-off or
system-reboot.
I think this is more likely.   I havn't followed the path back from
machine_restart to see exactly how we got there, but probably means a
bit more logic to decide whether to call into rtas_restart() or
pSeries_power_off() after the call to machine_shutdown.
