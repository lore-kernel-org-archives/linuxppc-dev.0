Message-Id: <4.2.0.58.20010510211938.03423790@localhost>
Date: Thu, 10 May 2001 21:23:35 -0700
To: frowand@mvista.com, Gabriel Paubert <paubert@iram.es>
From: Paul Mielke <paulm@routefree.com>
Subject: Re: dcache BUG()
Cc: frowand@mvista.com, Brian Kuschak <brian.kuschak@skystream.com>,
	"'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3AFAE7A0.AE936C64@mvista.com>
References: <Pine.HPX.4.10.10105102042500.29518-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:10 PM 5/10/01 -0700, Frank Rowand wrote:

>So if the lwarx occurs,
>
>then an interrupt alters the flow of execution,
>and the interrupt handler uses a stw to implement atomic_set(),
>
>then the interrupt handler returns to the original flow of execution,
>
>then the stwcx. succeeds, even though the value of the semaphore was
>altered by the atomic_set().

Frank,

I don't see how the above example can actually cause a failure.  Isn't it
a fundamental assumption that any change of process context must
clear the reservation bit?  If you don't do that, then none of this works.

So just before the RFI at step 4) of your example, the reservation bit
should be cleared and then the stwcx in the interrupted context fails
as one would expect.

Paul Mielke                        paulm@routefree.com
RouteFree, Inc.                   (650) 739-5377


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
