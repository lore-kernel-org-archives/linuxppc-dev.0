Date: Wed, 12 Jul 2000 12:21:46 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Reply-To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <20000711165125.12731@mailhost.mipsys.com>
Message-ID: <Pine.SOL.3.95.1000712114903.21439A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Benjamin Herrenschmidt wrote:

> >
> >What's more strange, the crashes even seem to affect OF, especially when
> >I tried to boot with yaboot. Afterwards, I noticed the Mac didn't find
> >the boot volume and searched for a while til it found my MacOS system
> >folder. I discovered that all OF boot vars had been set back to defaults,
> >maybe PRAM had been zapped completely, because also the function keys
> had been
> >set back to Brightness/Volume keys etc.
> >This happened several times after a crash, does anyone know how to avoid
> >this?
>
> Can you resync and tell me what's up ?
>
> If you still get the crash, then copy me the xmon report again and send
> me the System.map of the kernel you compiled.
>
No crash on startup with yesterday's rsync, neither with mol- nor with
dma-patch. The dma-patch indeed seems to help with xmms, I didn't notice
any drop-outs this time.

_But_ after some hours of sleep, the machine would not wake up properly.
First, the backlight didn't switch on. I tried the usual tricks of playing
with the brightness control, but to no effect. The machine was running at
first, as I could tell from the usual disk activity caused by slocate.
I also could dimly see the desktop, but at that point it finally seemed
to be frozen, because console switching didn't do anything.
I then shut the lid to put it to sleep again -- successfully, but when I
tried to wake it up once more, it immediately switched off.
After the restart, same symptoms: my ofboot script did not work, it searched
for a bootable volume for a while and rebooted into MacOS.
I have to add that I experienced something similar once with the precompiled
2.2.17pre9-benh1 kernel. In that case, there seemed to be problems with
the pmu while the machine was still running, because wmapm and gkrell
would not start up. I issued a snooze to check if pmud was running, with
basically the same effects: sleep, no wakeup, power-off.
That time, I tried to boot back into linux with yaboot by setting back
the OF variables first, but the kernel failed to boot, immediately shutting
off the power again. I just could see a message about something like
"PMU not properly initialized with this kernel..." briefly flashing up.
After rebooting into MacOS, everything seemed to be back in a proper
state.
I did not extensively test all kernel versions yet, but I put the PB
to sleep very briefly with the 2.2.17pre10-benh1+mol-patch yesterday,
and had no problems then. The kernel that would not wake up to day
was 2.2.17pre10-benh1 + mol-patch + dma-patch, but as I said, it was
after a much longer period of sleep. The battery was fully charged
however.
I am a bit worried if this might rather be a hardware problem, but I've
never seen anything like this in MacOS (I've put it to sleep from MacOS
this morning, to check this out again).

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
