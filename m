Date: Tue, 4 Sep 2001 15:26:08 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Dan Malek <dan@mvista.com>
Cc: John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405 enet changes (fwd)
Message-ID: <20010904152608.B14548@ecam.san.rr.com>
References: <Pine.LNX.4.30.0109031513110.21186-200000@hill.cs.ucr.edu> <3B9557CA.D76C70E2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B9557CA.D76C70E2@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 04, 2001 at 06:38:02PM -0400, Dan Malek wrote:
> John Tyner wrote:
> >
> > Is this patch going to be applied to the kernel? I haven't seen it in the
> > logs...
>
> I dunno.....from the code it doesn't look like you allow multiple
> device support (probe is only done once for one device).  If you
> have something that actually enables a new feature, add that too.
> Otherwise, it just looks like you added some additional indirection
> that doesn't add anything new and just adds overhead to the existing
> driver.  I'm also trying to determine why your patch seems to add
> things to the driver that should already be there.

Well we don't have the hardware to do multiple devices. I just know
that is possible in the future. I would prefer to go through the
pain of removing the static's now rather than later.

If you want to argue that we are just adding more redirection I will
be happy to send a patch to remove the entire struct ppc405_enet_private
to remove some more "useless" redirection. One of my biggest gripes
with the driver is that half of the stuff is kept as static and the
other half in the private sturct, for example ep_xmit_skb is in the
private stuct and ppc405_skb_rx is static. With things like this it
makes the entire driver hard to follow. I can't really think of an
explanation on why this is done in the driver. My only guess would
be that the person that did the driver has not done a linux network
driver before. There are other little clues throughout the driver
that point to this as well.

> We don't just blindly take stuff from people and patch it.  We
> actually have to believe it adds some benefits, we have to test
> it, and then it gets checked in.  This doesn't happen overnight.

No I don't expect the patch to go in quickly. I just wanted John
to start the process off. This patch does not do much to fix anything
but I would like to make any future changes off the new variable
names rather than what is in there now. Since this patch touches
so much stuff I think it would be better to keep any real changes
out of it until it gets tested.

So if you want to point to specific code that you don't like let
us know.

--
Thanks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
