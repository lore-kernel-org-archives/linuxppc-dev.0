Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 5A4FE67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 23:43:20 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j45Dls5t014654
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 5 May 2005 16:47:54 +0300 (EEST)
Message-ID: <427A1F54.5020108@intracom.gr>
Date: Thu, 05 May 2005 16:27:48 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <4278DDBF.8080705@ru.mvista.com> <427A01B7.9090200@intracom.gr>
	<427A1423.3040509@ru.mvista.com> <427A1361.6060005@intracom.gr>
	<fb6d7d007dc9f75553f1390b86c5f72b@embeddededge.com>
In-Reply-To: <fb6d7d007dc9f75553f1390b86c5f72b@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Dan Malek wrote:
> 
> On May 5, 2005, at 8:36 AM, Pantelis Antoniou wrote:
> 
>> In my experience it's much easier to configure these things once.
>> Hunting down where the driver modifies pins & clocks is a nightmare, if
>> you ever use a non standard configuration.
> 
> 
> That doesn't quite work, as we have discussed before.  The problem with
> setting them in the board set up is you can have loadable modules and
> select among several different IO pin configurations depending upon
> what you load.  So, the plan is to have the drivers make a generic
> call out request using feature_call() to the supporting functions in the
> board specific directory.  This is for more than just IO pin 
> configurations,
> since boards may have power management or other external logic that
> has to be routed to the physical interface.  For example, the SCC Ethernet
> driver will perform a feature_call() during set up requesting any necessary
> configuration for SCC2.  The board specific function can chose to ignore
> this and get the "default" configuration, or to do whatever is necessary
> unique to the board to enable the external data path.  All that drivers 
> know
> is there are a couple of specific places where they need configuration
> assistance, they don't care what the specific board has to do.
> 

Sounds nice. I'm a much simpler guy it seems :)

> It's in the works and nearly done for a few example 85xx and 82xx
> boards and CPM2 drivers.  I'll be checking it in shortly.  I just haven't
> decided if I want a varargs list or a data structure for passing the
> information and results.
> 

Mind sharing?

> Thanks.
> 
>     -- Dan
> 
> 
> 

Regards

Pantelis
