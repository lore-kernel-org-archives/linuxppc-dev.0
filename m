Date: Thu, 9 May 2002 00:13:21 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	"'Troy Benjegerdes'" <hozer@drgw.net>,
	<linuxppc-embedded@lists.linuxppc.org>, <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
In-Reply-To: <20020508174302.29360@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0205082335070.4031-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 8 May 2002, Benjamin Herrenschmidt wrote:

> Hi Paul & Gabriel !
>
> We indeed have some weird stuff mixing signed & unsigned in the
> arch/ppc/kernel/time.c code. The patch enclosed, from Jean-Denis
> Boyer, seems the right fix, except for one thing: I'd rather
> change the test from >= to > (which in the old could would mean
> changing the while (... < 0 to <= 0) as I see no reason to trigger
> a new decrementer interrupt in ... 0 ticks !

This was done on purpose in case the decrementer is way slower than the
processor. It's nitpicking but I believed that some processors have a very
slow decrementer (in this case a true fractional phaselock would be
necessary to get the HZ you want with some precision).

> Can you confirm it's ok to push ?

I'm not yet sure. I don't understand what happened in the first place.

> >	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0)
> >{
> >
> >Now that next_dec is unsigned, this condition is always false.

Yes I wrote this in the most possible compact way.  But I don't understand
(yet) how this can cause problems. You have a security margin of about 2
billion timbase ticks.

> >
> >Here is another patch I suggest to replace yours.
> >Its in attachement to this email.
> >I tested it, and it seems OK.
> >
> >I did not include your modification made to the type of local variables in
> >function do_settimeofday().
> >I do not see how it is related to our problem.

That one is better for symmetry between gettimeofday and settimeofay,
but OTOH the types in the timeval structures are defined as signed.
(Wrongly IMHO)

Could you please decribe exactly the problem or forward me the messages.
(Which machine, processor and compiler just in case). It seems that I have
been automagically dropped from linuxppc-embedded, unfortunately!

	Regards,
	Gabriel.

P.S: please try to get patches attached as text. It appears as
Application/BINARY which is quite annoying.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
