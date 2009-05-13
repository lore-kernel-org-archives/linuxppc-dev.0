Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AC5F1DDFFC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 05:45:11 +1000 (EST)
Message-ID: <4A0B233B.8010105@nortel.com>
Date: Wed, 13 May 2009 13:44:59 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: question about softirqs
References: <20090512081237.GA16403@elte.hu> <4A09933B.8010606@nortel.com>
	<874ovpmmdq.fsf@basil.nowhere.org> <4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
	<alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
	<87my9hkrmw.fsf@basil.nowhere.org> <4A0AE19D.9040509@nortel.com>
	<20090513170122.GZ19296@one.firstfloor.org>
	<4A0B19A9.1090206@nortel.com>
	<20090513191354.GB19296@one.firstfloor.org>
In-Reply-To: <20090513191354.GB19296@one.firstfloor.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andi Kleen wrote:
> On Wed, May 13, 2009 at 01:04:09PM -0600, Chris Friesen wrote:
>> Andi Kleen wrote:
>>
>>> network packets are normally processed by the network packet interrupt's
>>> softirq or alternatively in the NAPI poll loop.
>> If we have a high priority task, ksoftirqd may not get a chance to run.
> 
> In this case the next interrupt will also process them. It will just
> go more slowly because interrupts limit the work compared to ksoftirqd.

I realize that they will eventually get processed.  My point is that the
documentation (in-kernel, online, and in various books) says that
softirqs will be processed _on the return from a syscall_.  As we all
agree, this is not necessarily the case.

Chris
