Date: Thu, 11 Apr 2002 09:59:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020411165908.GA19157@opus.bloom.county>
References: <20020411152458.GB15663@opus.bloom.county> <0204111616.AA28753@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204111616.AA28753@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 09:16:08AM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> Also I'm not even using ppc-linux-boot any more, in 2_4_alt I've made a
> zImage.ppcstar that runs directly from the (completely Linux-unaware) StarMON
> console. As you can see it isn't that hard.

Of course it's not hard.  That's what the 'simple' stuff does. :)  Runs
directly from the (completely Linux-unaware) DINK/PMON/What-have-you.

> The incentive, for me at least, is to sell boards and to have standard Linux
> and BSD distributions shipping with them to make them sell better.

Then get an OF license (I hear OpenBIOS is adding OF stuffs) and yaboot
will Just Work and booting from CD will probably just work too.
Otherwise StarMON is no more standard than the rest of the bunch.

> I don't
> think any company would be particularly happy about cutting, testing,
> archiving, distributing, etc. 20 different CD variants for each release of an
> OS because you have to have a different one for each slightly different CPU
> board model, even if the difference is one byte.

That's a rather large exageration.  If a vendor doesn't test their
distribution on a model but is going to claim it works, it's going to
upset someone when they find out it doesn't.


> > Hell, it could probably run on StarMON (I suspect it'd just need to have
> > the ELF header stripped off and loaded into a 'good' location). :)
>
> Yes, it would run, except on boards where somewhere along the way you make an
> assumption about some hardware (like the interrupt controller or IDE) being in
> a certain state on entry, which is the state established by some other
> firmware but not StarMON.

It's a good thing it doesn't rely on the firmware having done anything
for us.  Linux may or may not, but the bootwrapper certainly doesn't[1],
except:

> I remember problems of that sort on K2.

So do I, and things (except for Spruce) have been cleaned up to not do
any of that in the firmware and to do it in the kernel (which was a
known ugliness at the time it was done and which is why it was cleaned
up).

> Also in your current
> EV-64260 port the wrapper assumes that the GT registers are at 0x14000000,
> while StarMON puts them at the much more reasonable 0xF1000000.

>From what I recall on this, someone from the BSD camp popped up and said
they wanted to relocate things and that's why it has to be delt with
(and I _think_ the _galileo tree does handle it, but I don't know).  But
anyhow, that's a galileo issue..

> But I did
> indeed boot your EV-64260 zImage from StarMON, I just wrote a tiny program
> that remaps the GT registers back to 0x14000000 and jumps to 0x800000
> where zImage lives.

Did you have to strip the ELF header off or no?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
