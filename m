From: benh@kernel.crashing.org
To: Michael Zucca <mzucca@ne.mediaone.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.18 and dmasound and rebooting
Date: Mon, 4 Mar 2002 00:34:13 +0100
Message-Id: <20020303233413.32449@mailhost.mipsys.com>
In-Reply-To: <3C827800.67CC4435@ne.mediaone.net>
References: <3C827800.67CC4435@ne.mediaone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Ok, I tried 2.4.18 from kernel.org on my PowerCenter 132 and the DMA
>dead patch works. However, as a side note, it only seems to work if the
>sound code is compiled into the kernel. The same code in a module does
>not work and still causes the sound hang. As I recall, the way the
>emergency buffer was allocated was critical to it functioning properly.
>I usually compile in the sound driver so it's not a big deal for me but
>it might be for other folks.

Well, I see no problem with the way the buffer is allocated. However,
the emergency buffer code looks wrong: It should really contain a
branch command to branch back the DBDMA controller to the normal buffer.

>On another note, I've noticed that if I reboot my machine using shutdown
>-r the machine will reboot to a gray screen and then just hang there. It
>won't boot into MacOS. I've noticed that on 68k Macs, it is important to
>map the ROMs back into memory before rebooting or the machine just hangs
>around forever. Is it possible that we're not remapping stuff back to
>its usual place before rebooting on OldWorld machines? This has been a
>persistant problem for a long time on 2.4.

That is weird, I don't think we have to take care of any sort of MMU
mapping, looks more like some driver would need to be restored in some
"pristine" state (sound ?)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
