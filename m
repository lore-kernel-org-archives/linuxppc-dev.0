Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A98F7DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 03:21:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l94HLX7a009307
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 13:21:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l94HLXEk433982
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 11:21:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l94HLWBp022737
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 11:21:32 -0600
Date: Thu, 4 Oct 2007 12:21:32 -0500
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Stdout console clogging => 300ms blocked
Message-ID: <20071004172132.GF4338@austin.ibm.com>
References: <8D433CD511BE4646B47F8B31C900818ECB97AF@kndmex01.barco.com>
	<fe0v88$dt5$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe0v88$dt5$1@sea.gmane.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Bernard,

On Wed, Oct 03, 2007 at 08:49:12PM +0000, Hollis Blanchard wrote:
> On Tue, 02 Oct 2007 09:41:28 +0200, Willaert, Bernard wrote:
> 
> > Problem:
> > When we log debug output via the serial console on a multithreaded
> > application, the console throughput may get clogged and then we
> > experience a >300ms deadlock.
> > 
> > #define THREAD_DELAY 1000
> > 		usleep(THREAD_DELAY);
> > 		fprintf(stdout," <----- thread 1\n");

[...]
> > 
> > 		usleep(THREAD_DELAY);
> > 		fprintf(stdout," <----- thread 2\n");
> > 
> > baudrate=115200

OK, lets do the math. 115200 baud == approx 115200 bits per second
assuming 8N1 for stop & parity bits, I get approx 9 bits per byte
so your serial port is capable of 115.2/9 = 12.8KBytes per second.

Now, every millisecond, you are attempting to print

" <----- thread 1\n"

Lets see, thats 17 bytes. And also " <----- thread 2\n" for
a grand total of 34 bytes per millisecond.

And you are attempting to jam this through a serial line capable
of 12.8 Bytes per millisecond?  Well, of course it won't fit!

> > Real output on the console:
> > 
> > .... /\ ........
> >  <----- thread 1
> >  <----- thread 2
> >  <----- thread 1
> >  <----- thread 2
> >  <----- thread 1
> >  <----- thread 2
> > !!!!!!!!!!! thread2 interval timeout = 335 ms

Well, thread 1 clearly also had a delay of 335 milliseconds
for a total of 670 milliseconds delay.

Now, theoretically, we should have seen a delay equal to 
   (34 - 12.8)/34 = 0.623 seconds

I'd say that theory and practice match up pretty damned well;
I see no evidence of any problem at all.

> Could you not post HTML please? Thanks.

Agreed.

--linas
