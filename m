Date: Thu, 6 Mar 2003 10:05:52 -0800
From: curt brune <curt@acm.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK and wireless LAN PCMCIA card
Message-ID: <20030306100552.B28587@curtisb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

It works, with 40-bit WEP!  It took a little longer than it should
have though.  I was using iwconfig to the set the key like this:

  iwconfig eth1 key s:secur

"iwconfig eth1" showed that the key was set with the correct hex
bytes, matching my access point.  At first, however, it did not work.
After much head scratching, reading and experimenting I figured out
that I also needed to do this:

  iwconfig eth1 key on

which enabled encryption.  After that it just worked.  I am a little
disappointed (not with you) that "iwconfig eth1" does not show the
state of "key on/off" -- if it did, it would have saved me a day of
experimenting.  It's a poor interface that overloads the meaning the
verb "key" to both set the keys and to enable encryption ... should have
been a different verb all together.  OK, I'm done ranting.

So the good news is it works on the 823e RPXLite board -- chalk up
another supported board.

Currently I am having one small problem with the hotplug, however.
When I insert the card the cardmgr loads the appropriate modules and
runs "./network start eth1", but nothing happens.  Currently I run a
script I wrote by hand that calls "ifconfig eth1 ..." and a bunch of
calls to "iwconfig ....".

Isn't something supposed to call /etc/pcmcia/wireless (which sources
/etc/pcmcia/wireless.opts) ? Where does that occur?

looking at /etc/pcmcia/network I see the following comment for the
"start" action:

  #
  # We don't do *anything* here. We get a hotplug event when the
  # ethX device is registered, and we bring the device up there
  #

Do I need to put a script in /etc/sysconfig/network-scripts/ ?  As I
am not a RedHat user I am not familiar with /etc/sysconfig/....

Of course I can do something hack-ish like putting my hand-made script
in /etc/pcmcia/network, but I would like to do it "the right way".

Cheers,
Curt


On Mon, Mar 03, 2003 at 07:30:21PM +0100, Wolfgang Denk wrote:
> Dear Curt,
>
> in message <20030303081702.A24793@curtisb.com> you wrote:
> > Indeed.  Shortly after my previous email I figured this out.  It seems
> > to be working now -- that is iwconfig shows the board and I can bring
> > up eth1.  Once I set the ESSID correctly I could see good link
> > quality and signal level from 'cat /proc/net/wireless'.
>
> Congrats!
>
> > My issue now is setting the WEP key correctly -- I'm sure after
> > reading the iwconfig documentation carefully this should be easy.
> >
> > Thanks for all your help.  The suggestion about increasing the bus
> > timeout value really got me over the hump.
>
> You are welcome.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "Once they go up, who cares where  they  come  down?  That's  not  my
> department."                                       - Werner von Braun
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
