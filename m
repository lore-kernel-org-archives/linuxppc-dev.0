Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c
Date: Wed, 23 Oct 2002 13:32:32 -0200
References: <200210230751.g9N7pN4d024262@blooper.utfors.se>
In-Reply-To: <200210230751.g9N7pN4d024262@blooper.utfors.se>
MIME-Version: 1.0
Message-Id: <02102313323200.01073@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 23 October 2002 05:51, Joakim Tjernlund wrote:
> On Monday 21 October 2002 15:13, Joakim Tjernlund wrote:
> > Hi
> >
> > Here is a patch to drop the expensive memcpy of received ethernet frames
> > in interrupt context. I have not done any bench marking, but mounting a
> > NFS rootfs feels faster.
> >
> > I am using a heavily modified enet.c in my system, but I think I got the
> > patch correct.
> >
> > Also fixed a bug in set_multicast_list(), move the dmi list forward when
> > walking it(dmi = dmi->next;)
> >
> > Comments? Anyone care to do some benchmarking?
>
> No comments so far, no one interested in this?
I'm interested! Indeed, I adapted and tested your patch in a 8260 FCC fast
ethernet driver and it worked fine  I had a 20% increase in routing
throughput with the  patch installed!

The bug fix in set_multicast_list worked too. But, since there's a continue
clause inside the for command in this routine, I would suggest that the
(dmi=dmi->next) command go inside the for increment clause, instead of the
place you've put it; that is:
	for (...;...; i++, dmi = dmi->next) {...}
>
> A question, why do enet.c pass bad frames to netif_rx? Only late collisions
> are disregarded, the rest is passed on.
IMHO, this is another bug...

>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
