Message-ID: <39C8E538.B9F0DA84@mvista.com>
Date: Wed, 20 Sep 2000 12:26:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Rainer Kloud <rainer.kloud@siemens.at>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 FCC Ethernet driver, cpm_8260.h
References: <39C1DE70.F1D90668@siemens.at> <39C24395.756E3252@mvista.com> <39C8C584.D845678A@siemens.at>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rainer Kloud wrote:

> But one further question:
> After compelation of your driver I was able to send some
> data (bootp request), but I couldn't receive any.

Check to make sure you are using the same pins for clocks as
the driver has.  That is a common problem.

> So setting the desired events in the FCC mask register has
> no effect!

Well, you have to be a little careful here.  I don't have the
book handy to look up the details, but there are several places
where things are assigned 32-bit address alignments, but only
the upper 8 or 16 are valid.  In some cases, these also have
to be accessed as 16-bit operations on the 32-bit aligment.
One of the reasons is an attempt to use legacy microcode from
the 8xx, which is a 16/20/32-bit CPM architecture in a fully 32-bit
CPM of the 8260....

The code that is posted works on Rev. A parts on several platforms.
I am sure there are some mistakes, but look at it carefully....:-)

> What do you think about this?

I guess I better take a closer look.....

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
