Date: Thu, 19 Dec 2002 10:02:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hans Feldt <Hans.Feldt@uab.ericsson.se>
Cc: Shen Rong <rshen@udtech.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupts again
Message-ID: <20021219170201.GD852@opus.bloom.county>
References: <3DD254F0.3050701@uab.ericsson.se> <01a901c28c85$22aa99a0$e600a8c0@udtech.net> <3DD4D6EE.5000902@uab.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DD4D6EE.5000902@uab.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 15, 2002 at 12:13:50PM +0100, Hans Feldt wrote:

> On 11/15/02 09:58 AM, Shen Rong wrote:
>
> >    I have the same problem like you, and I added a "sync" at the last
> >    line in
> >m8260_mask_and_ack like you, and it solves the ploblem. But it is
> >interesting
> >that if I add a "sync" above the last line, it's also ok, that's
>
> Well its the write to SIMR that needs a sync before enabling external
> interrupts, not the sipnr variable.
>
> >So I think there should be a time delay when we do mask&ack(&following
> >operation maybe).
>
> Don't agree, I believe the missing sync is a bug. I talked a Motorola
> FAE yesterday and he says the same thing. It doesn't really matter if
> you have the 8260 as a slave or not.
>
> What does the maintainers of this code (Tom Rini?) think about it?

Sorry it took so long to get back to this thread, I'm not sure.  I don't
think I know enough about this code to say either way.  But I'm inclined
to think the sync is needed regardless as well.

If someone would post a patch vs current linuxppc_2_4 and linuxppc-2.5,
I'll apply it as there definatly seems to be a problem here.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
