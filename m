Mime-Version: 1.0
Message-Id: <p04330100b63ca26f7c74@[192.168.0.1]>
In-Reply-To: 
 <Pine.LNX.3.96L.1001118150530.15284H-100000@MOTRIN.WEH.ANDREW.CMU.EDU>
References: 
 <Pine.LNX.3.96L.1001118150530.15284H-100000@MOTRIN.WEH.ANDREW.CMU.EDU>
Date: Sat, 18 Nov 2000 16:33:08 -0500
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: aic7xxx panic in 2.2.18pre21
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > C000F508:
>>	c000f4f4 T ioremap
>>	c000f518 T __ioremap
>>
>>  C013CAC8:
>>	c013b454 t aic7xxx_load_seeprom
>>	c013c444 T aic7xxx_detect
>  >	c013d9f8 t aic7xxx_allocate_negotiation_command

<snip>

>The backtrace is in reverse order; the topmost item is the most recent
>function called. So ioremap is crashing near the end, after being called
>by aic7xxx_detect.

And indeed, I just compiled a kernel without the aic7xxx driver. It
breezed right through the previous panic point and found the mesh
(internal) and external scsi busses, but of course could not mount
the root partition.


>And yes, you can find aic7xxx_detect() in the
>sources, probably in linux/drivers/scsi/aic7xxx.c


I'm off to find ioremap.c. What's the difference between ioremap and
__ioremap? Should I add kernel messages in ioremap.c to find out
exactly where the crash occurs? I assume if I diff the old (2.2.17)
versus new (2.2.18pre21) ioremap.c, the culprit will jump out pretty
quick? Or might the error be more subtle than that? Does anyone know
if ioremap.c has been the subject of a lot of changes recently? I
doubt seriously I can just take the old ioremap and use it in place
of the new...

Thanks Hollis. I feel a bit less helpless now...


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
