In-Reply-To: <199906110543.HAA00297@piglet.cpu.lu>
Date: Fri, 11 Jun 1999 18:08:11 +0200
To: linuxppc-dev@lists.linuxppc.org, mlan@cpu.lu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Q: control is a C&T 65550?
Message-Id: <19990611180811.016528@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 11, 1999, Michel Lanners <mlan@cpu.lu> wrote:

>Unfortunately, as to the registers that control the appearance of the
>cursor (visible/not visible; its colors, etc...), I have no iddea where
>exactly on RaDaCal they are, and how to identify them except by poking
>at registers from a distance...

This could probably be found by tracing Apple's control driver. There are
a few video driver calls used to control the hw cursor, they are
documented, and I know at least two ways of tracing that: one is the
mac-on-linux emulator, and the other is Apple's serial-based 2 machines
debugger using the ROM stub. (It should be downloadable on Apple site
along with other ETO/MPW stuffs). This debugger can debug HW device
drivers loaded at very early boot time or hardware interrupts, and so
should have no problem tracing the control driver.

>What a shame! After all, the control hardware can be seen as a legacy
>device, being surpassed by any and all current video chips... or might
>Apple be hiding some really cool and powerful feature deep inside
>control? I doubt it....

I don't think so. There is however some kind of "graphic accelerator" for
control in MacOS, It's quite small, I don't know if it only provides
better blit routines optimised for non-cachable space, or eventually
hacks the MMU to make the fb space cahable (for bursts), I don't think
there's anything like a blitter or a DMA engine in control.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
