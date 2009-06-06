Return-Path: <b.spranger@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32D2CB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 07:32:35 +1000 (EST)
Received: from clark.bene.spranger.biz (p5B17E358.dip.t-dialin.net
	[91.23.227.88]) (authenticated bits=0)
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id
	n56KpDIX030808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Jun 2009 22:51:14 +0200
Date: Sat, 6 Jun 2009 22:51:11 +0200
From: Benedikt Spranger <b.spranger@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: how can i send real-time signal?
Message-ID: <20090606225111.254af971@clark.bene.spranger.biz>
In-Reply-To: <23892580.post@talk.nabble.com>
References: <23892580.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Fri, 5 Jun 2009 10:41:56 -0700 (PDT)
schrieb wael showair <showair2003@yahoo.com>:

> My aim is : Each time the DSP-core interrupts the MPC8555 processor, a
> process in the user space will be informed by the arrival of this each
> interrupt.
You should have a look at drivers/uio...

> So i decided to use sw signals, in the ISR of the DSP-core interrupt
> i send a SW signal to the user space process? Is this the best
> solution? are there any better suggestion to achieve my aim? 
signals are expensive. Look at the UIO-Framework for a cheaper solution.
preallocated RT-Signals on the other Hand are fragile. Blocking reads
are cheaper and in case of preempt-RT, but not resticted to it, much
easier to handle.

Bene
