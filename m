Date: Wed, 8 May 2002 13:06:06 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: trini@mvista.com, mgreer@mvista.com,
	"'Jim Thompson'" <jim@musenki.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bogomips and loops_per_jiffy
Message-ID: <20020508130606.E16602@altus.drgw.net>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFFA000@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA000@mail.mediatrix.com>; from jdboyer@mediatrix.com on Wed, May 08, 2002 at 12:53:39PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 08, 2002 at 12:53:39PM -0400, Jean-Denis Boyer wrote:
>
> Troy,
> with the patch, now, it completely hangs.
> The reason is that in timer_interrupt()
>
> 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0)
> {
>
> Now that next_dec is unsigned, this condition is always false.

Yeah, I was a little too quick to go messing with tb_delta. Benh and I
were talking on IRC and the original code does a bunch of signed vs
unsigned stuff and should probably be made more explicit as to what it's
actually doing. (Especially since I don't completely understand the
intention of this code yet)

> Here is another patch I suggest to replace yours.
> Its in attachement to this email.
> I tested it, and it seems OK.
>
> I did not include your modification made to the type of local variables in
> function do_settimeofday().
> I do not see how it is related to our problem.
>

I got carried away cleaning up stuff ;)

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
