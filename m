Date: Thu, 8 Mar 2001 19:07:34 -0800
From: David Schleef <ds@schleef.org>
To: Dan Malek <dan@mvista.com>
Cc: Oliver Brown <obrown@adventnetworks.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
Message-ID: <20010308190734.A7116@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
References: <CD5CA14300A9D54A8D13D58CD3C87B422DD729@advcorp-exc01.advent.com> <3AA82575.D6C1CAF2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AA82575.D6C1CAF2@mvista.com>; from dan@mvista.com on Thu, Mar 08, 2001 at 07:36:05PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 08, 2001 at 07:36:05PM -0500, Dan Malek wrote:
>
> Oliver Brown wrote:
>
> > I can't generate any traffic on the fast ethernet port.
>
> The CTX-1170 worked at one time on the EST board.  Unfortunately,
> I had to make little changes for just about every different 8260
> board I have seen.  Further, my EST boards have all failed in some
> way or another so I can't even test this anymore.
>
> Even when it "worked", I had trouble with some 10/100 switches.

I've noticed this as well.  In my case, the problem was
because the PHY was advertising and connecting full-duplex
and the CPM was doing half-duplex -- yet another problem due
to inadequate PHY communication.

Also, there is a problem with the 8260 CPM generating spurious
TX underrun errors and late collisions -- the driver does things
according to the spec, but there is an errata about this problem.
I'm about halfway through a fix for this.  The problem only
seems to occur on 10 Mbit hubs.




dave...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
