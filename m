In-Reply-To: <Pine.LNX.4.10.10003241715130.21215-100000@opal.biophys.uni-duesseldorf.de>
Date: Fri, 24 Mar 2000 18:17:46 +0100
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000324181746.026025@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 24, 2000, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:


>I'd like to reach a point where I understand what's happening in the
>XFree PCI code before getting into that sort of discussion. And the X
>source is way too convoluted for me to achieve that right now.
>
>I'll stick to pre-4.0 XFree rather.

I spent some time discussion with Egbert. The result is basically that in
order to support all archs, bogus BIOS, legacy cards, softbooting, etc...
XF must take over the PCI the way it does it. There are lots of reasons
for that, I could try to summarize them if you really want the gory
details, I beleive Egbert is bored of repeating himself all the time ;)

I suggested making that optional (and relying, for example, only on fbdev
or disabling the re-assignement when the appropriate option is set in
XF86Config), but Egbert thinks that would be a support nightmare with
users playing with the config options.

He agrees that things are not perfect, especially since the way we handle
PIO and iobase is bogus (see other discussions about this). Also, the
current remapping scheme can make the kernel (and fbdev) quite confused
with new hot-swap PCI, Cardbus, etc... He plans to rework the PCI
interface of XFree so that better cooperation with the kernel can be
implemented. On another hand, I think _we_ should find a definitive
solution for the PIO problem before he can begin adapting XFree. There
are lots of changes to be done to legacy drivers (VGA) to make them grok
a notion of iobase (since iobase can be different per-device, it can't be
handled inside inb/outb and friends).

Note that XF will always have to disable IO response on VGA cards when
more than one card is present in the machine since that's the only way to
prevent 2 VGA cards from trying to hard-decode legacy VGA addresses at
the same time. We need to find a way to make the kernel (and the fbdev)
aware of what's going on.

No time do give more details now, tell me if you need more precisions on
one of these specific points.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
