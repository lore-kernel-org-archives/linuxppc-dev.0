In-Reply-To: <27B62C328BF6D2119C3C0008C709CF57A4DDD3@torontoexch.toronto.falconbridge.com>
Date: Mon, 18 Oct 1999 17:57:40 +0200
To: "Neugebauer, Bob" <bneugebauer@falconbridge.com>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Support for Sawtooth (New G4) Motherboards
Message-Id: <19991018175740.027184@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 18, 1999, Neugebauer, Bob <bneugebauer@falconbridge.com> wrote:

> am currently looking into buying a new G4 for myself, however I do need to
>run Linux on it. I am curious if anyone could give a rough estimate of when
>the new motherboards might be supported. I am a competent C/C++ programmer
>and would be quite willing to help, but I have never done any kernel
>hacking.
> 
>I know that this is an impossible question to answer, but any estimate would
>be appreciated.

I'm working on it right now, with an iBook (but the main ASICs are the same).

I can't tell for sure when I'll have a first version available, so far, I
have the PCI code working, but still a couple of issues with the OpenPIC
and the new PMU, I'm still working on them. That's for the basic support.

I didn't try to find details about the "gmac" ethernet chip yet, but
looking at OF methods, it looks like a classical ring descriptor based
chip. It has a mii interface to the external phy, for which we have the
reference (I don't have it in mind), there are OF methods for accessing
it, so I beleive I'll be able to figure out.

I didn't look in depth at the IDE neither, but since it's an IDE, I
beleive I should get basic support quite quickly once I have finished
with the core stuffs. Then, we'll need to look at this Ultra/ATA thing.

The SCC (modem) is apparently the same escc we are used to (and the modem
looks like the usual cobalt modem too)
All DMA for IDE and SCC is done via the good old dbdma controllers. USB
is on the PCI directly, ethernet too (eth. is on it's own bus inside the
north brige).

The USB looks pretty standard (and was detected at boot the last time I
tried), the video is some kind of ATI (I beleive your's will be a rage
128 derivative), it works in "no video driver" mode, but I beleive we'll
need some AGP support for a full driver. I'll also try to get OF booting
asap, I'd like to see Linux appear in this nice boot-chooser Apple made
in the ROM of the new machines ;)

Finally, there is the sound, which is on an i2s bus. I don't know how
such a bus looks like, and so I don't know if I'll be able to make a
driver for this one, at least not immediately.

If you have a desktop G4, then first send me a dump of the name registry
(ask me for the tool if you don't know what it is once you have the
machine). Then, we'll try to get it working.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
