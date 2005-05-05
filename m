Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B3D367A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 23:19:45 +1000 (EST)
In-Reply-To: <427A1361.6060005@intracom.gr>
References: <4278DDBF.8080705@ru.mvista.com> <427A01B7.9090200@intracom.gr>
	<427A1423.3040509@ru.mvista.com> <427A1361.6060005@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb6d7d007dc9f75553f1390b86c5f72b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 5 May 2005 09:19:31 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice support
	for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 5, 2005, at 8:36 AM, Pantelis Antoniou wrote:

> In my experience it's much easier to configure these things once.
> Hunting down where the driver modifies pins & clocks is a nightmare, if
> you ever use a non standard configuration.

That doesn't quite work, as we have discussed before.  The problem with
setting them in the board set up is you can have loadable modules and
select among several different IO pin configurations depending upon
what you load.  So, the plan is to have the drivers make a generic
call out request using feature_call() to the supporting functions in the
board specific directory.  This is for more than just IO pin 
configurations,
since boards may have power management or other external logic that
has to be routed to the physical interface.  For example, the SCC 
Ethernet
driver will perform a feature_call() during set up requesting any 
necessary
configuration for SCC2.  The board specific function can chose to ignore
this and get the "default" configuration, or to do whatever is necessary
unique to the board to enable the external data path.  All that drivers 
know
is there are a couple of specific places where they need configuration
assistance, they don't care what the specific board has to do.

It's in the works and nearly done for a few example 85xx and 82xx
boards and CPM2 drivers.  I'll be checking it in shortly.  I just 
haven't
decided if I want a varargs list or a data structure for passing the
information and results.

Thanks.

	-- Dan
