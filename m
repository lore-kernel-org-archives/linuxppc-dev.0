Date: Wed, 15 Mar 2000 16:09:55 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: michdaen@iiic.ethz.ch, Alan Hourihane <alanh@fairlite.demon.co.uk>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
In-Reply-To: <Pine.LNX.4.10.10003151054180.24581-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0003151544550.3091-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Mar 2000, Michael Schmitz wrote:

>
> > > I guess it all boils down to PCI messups.
> >
> > How do you come to this conclusion? Why should it influence ioctls?
>
> Because these ioctls will, ultimately, write to the card again? If the X
> server actually messes with the PCI bridges, the card might no longer be
> mapped?
> I admit that I understand next to nothing about PCI, or how the X server
> uses PCI. Makes it a bit harder to spot the flaky code :-)
>
> Anyway, the X server appears to complete screen init OK but I never
> actually get to see the cross hatch pattern.


  The X server has played with the cards mappings, since it believed the
old ones were wrong. atyfb will still try to access the card in the old
location and thats what gives you the hard locks.

  The question is why the X server doesn't like the old mappings ?
If you can send me the /var/log/XFree86.0.log and lspci output i'll
forward it in the xfree devel list and see what answers we can get from
there.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
