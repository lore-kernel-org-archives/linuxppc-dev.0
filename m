Date: Thu, 9 May 2002 10:08:46 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	linuxppc-embedded@lists.linuxppc.org, paulus@samba.org
Subject: Re: Bogomips and loops_per_jiffy
Message-ID: <20020509100846.G16602@altus.drgw.net>
References: <20020508174302.29360@smtp.wanadoo.fr> <Pine.LNX.4.33.0205082335070.4031-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0205082335070.4031-100000@gra-lx1.iram.es>; from paubert@iram.es on Thu, May 09, 2002 at 12:13:21AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> > >	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0)
> > >{
> > >
> > >Now that next_dec is unsigned, this condition is always false.
>
> Yes I wrote this in the most possible compact way.  But I don't understand
> (yet) how this can cause problems. You have a security margin of about 2
> billion timbase ticks.

The problem occurs when calibrating the delay loop, and the timebase is
very large.

http://lists.linuxppc.org/linuxppc-embedded/200205/msg00040.html

We could probably just avoid all this and do 'set_tb(0,0)' in time_init
(since we go and try to sync the timebase on SMP systems anyway)

>
> > >
> > >Here is another patch I suggest to replace yours.
> > >Its in attachement to this email.
> > >I tested it, and it seems OK.
> > >
> > >I did not include your modification made to the type of local variables in
> > >function do_settimeofday().
> > >I do not see how it is related to our problem.
>
> That one is better for symmetry between gettimeofday and settimeofay,
> but OTOH the types in the timeval structures are defined as signed.
> (Wrongly IMHO)
>
> Could you please decribe exactly the problem or forward me the messages.
> (Which machine, processor and compiler just in case). It seems that I have
> been automagically dropped from linuxppc-embedded, unfortunately!
>
> 	Regards,
> 	Gabriel.
>
> P.S: please try to get patches attached as text. It appears as
> Application/BINARY which is quite annoying.
>
>
>
>

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
