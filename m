Date: Wed, 28 Mar 2001 14:40:21 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>, <phandel@cise.ufl.edu>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
In-Reply-To: <20010328105501.E28EEDBA11@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.31.0103281418180.21345-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Mar 2001, Iain Sandoe wrote:

>
> > With a quick look it doesn't seem that it will work, you only need to return
> > if you restart the frame otherwise the driver will deadlock,
>
> we do restart the frame - with the:
>
>     /* may as well try anyway - I guess all bets are off now */
>     out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
>
> the difference from what you did is that I don't re-load the cmdptr register
> - we are just going to see if the current state can be resumed.
>
> It might lock up - but it's worth a try.

Nope it doesn't restart the frame, thats why we need to either reload it
and return or continue as if it played correctly.

I was wondering again today why we get the DEAD status in the powercomputing
machines everything was working fine until 2.2.9/10 (there were no changes
in dmasound at that point) so some other change is causing this i can't
imagine anything though :(

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
