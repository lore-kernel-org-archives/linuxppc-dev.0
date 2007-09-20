Return-Path: <johnstul@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07CF5DE05E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 03:43:12 +1000 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l8KGaoQL031703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:36:50 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8KGXf5W026394
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:33:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KGXf15321146
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:33:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KGXerG016602
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:33:41 -0400
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
From: john stultz <johnstul@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
References: <20070919064947.4B5A1399910@thor>
	<1190216594.11899.3.camel@imap.mvista.com>
	<18161.50240.599267.768383@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 09:35:10 -0700
Message-Id: <1190306110.14264.7.camel@localhost>
Mime-Version: 1.0
Cc: Realtime Kernel <linux-rt-users@vger.kernel.org>,
	Daniel Walker <dwalker@mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-09-20 at 10:52 +1000, Paul Mackerras wrote:
> Daniel Walker writes:
> 
> > If you switch to the rtc do the shift and mult need to change?
> 
> You can't switch; any given CPU chip will have either the RTC or the
> timebase but not both.

I think what Daniel is pointing out is that the clocksource read
function isn't the place for the __USE_RTC() conditional. 

It would likely be better instead of the timebase clocksource managing
multiple type of hardware (timebase and RTC), to have a separate simple
RTC clocksource, and then conditionally register one or the other at
init time.

thanks
-john
