Date: Tue, 27 Mar 2001 17:35:31 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage
In-Reply-To: <20010327213129.672B0DBA03@atlas.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010327165548.84494A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Mar 2001, Iain Sandoe wrote:

> I wish I knew whether it would resume... it's not clear from the
> documentation I've got... (the IBM stuff).

It may be implementation dependent.  MACE driver stops tx dma and resumes
afterwards, so tx side of dbdma on MACE must support it.

I have no idea if how AWACS' tx dbdma behaves, but it may be necessary to
make the write to control register multi-step or something, i.e., clear
RUN [in order to clear DEAD bit] and wait until RUN bit is cleared by hw,
then set RUN|WAKE..

> If it would, then we could save all this hassle completely...
>
> BTW: I don't *think* it does because one of my testers tried a similar
> method to the one you proposed and said it chopped up/repeated sound.

Hmm, I think it has to be either "chopped up" or "repeated" not both..  As
far as dbdma is concerned, those two are quite different effects.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
