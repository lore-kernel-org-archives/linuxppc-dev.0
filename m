Message-Id: <200003241146.LAA17927@hyperion.valhalla.net>
Date: Fri, 24 Mar 2000 11:46:30 +0000
Subject: Re: Synchronous SCSI at 10MB/s on Lombard? (fwd)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Dan Bethe <dan_bethe@yahoo.com>
CC: "PPC-DEV" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> far on my Lombard. The throughput as reported by hdparm has
>> effectively
>> doubled (from 3.3 to 6.6 MB/s), so does anyone know whether this is
>> safe or there are any dangers implied when setting the transfer rate
>> that
>> high (if it only you could call this high!) on the external bus?
>
>  I second the question.  And what does "safe" mean?  Could these
> aggressive settings damage your data, your hardware, or both?  If it's
> just data, then that's okay for me to try.  I'll turn it off when I
> find corrupted data.
>  Thanks!

"Safe" is a bit tricky in this case - it is likely to be
temperature-dependent and subject to fairly random behaviour when you get
close to the limit.

Most likely the data is at highest risk - with the possibility of trashing
the entire disk (rather than just Linux partitions).

It is very hard to see a way in which the H/W could be damaged because most
aspects of the scsi transfer are negotiated.  You would have to work fairly
hard a finding a series of catastrophic failures resulting in overheating...

apropos the number of pins:
There are two reasons for more pins on scsi
1/ to use a differential bus - which was also an option on scsi-1

This allows longer interconnect and/or greater noise immunity.

2/ to have access to the UW/scsi-2/3 features

(e.g. more data or address bits).

AKAIK the Macs have never had any external (or 'standard' internal) busses
that were differential (although maybe the IIfx did).  There are some cards
like that that were installed as standard - e.g. on my G3/Minitower - but
it's usually link-selectable anyway.

apropos chaining different devices:
A number of scsi drivers (e.g. IIRC the ones one the suns) used to probe at
different rates (for sync operation) and back off to the lowest rate that
worked in the chain.

I don't know if this principle is used by the Linux drivers (but I'm sure
some guru will comment).

AFAIK this is necessary at some stages of the bus negotiation - although
once the transaction is agreed there may be the option of going faster (hmmm
seems a bit dodgy electrically).

Anyway this was/still is a good reason for separating high performance
devices from low.

Personally, the pain of dealing with an unreliable and unpredictable system
doesn't seem worth push one's luck ;-)

By far the best solution is to check the specs on the devices you have
(usually obtainable on the www), and take a peek at the ANSIs for SCSI
(although you might have to buy these or get them through a library).

Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
