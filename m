From: benh@kernel.crashing.org
To: Matthias Grimm <joker@cymes.de>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] PowerBook button device control back to user space
Date: Tue, 5 Feb 2002 14:18:55 +0100
Message-Id: <20020205131855.29699@mailhost.mipsys.com>
In-Reply-To: <3C5EE8D9.1000408@cymes.de>
References: <3C5EE8D9.1000408@cymes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi Ben,
>
>The following patch removes a unlucky shortcut from keyboard device to
>the PMU backlight
>device from the kernel and gives control back to user space.
>
>The Apple PowerBooks have a special button device to control special
>functions like
>display brightness, speaker volume, etc. The Keys for volume control
>generate keycodes,
>which were sent to user space. The keys for controlling the display
>brightness were
>directly handled by the kernel. This is not consequent and additionally
>an unlucky
>cross reference between different and independent parts of the kernel.

Hi Matthias. The presence of direct backlight handling in the kernel
is an artifact of old days ;) Actually, other controls (sound, CD eject)
of new powerbooks are sent to the even device and a userland daemon
already exist (ikeyd) for taking care of those events.

The problem currently is that not all powerbook models send those
as ADB keycodes, some are obtained via special PMU events directly
in via-pmu. So before backlight handling is moved to an ikeyd-like
daemon, we should first fix the kernel to properly send those
events on all models. I don't suggest changing this in the 2.4
timeframe though.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
