In-Reply-To: <38349F1A.8AECF96F@wanadoo.fr>
Date: Fri, 19 Nov 1999 11:25:22 +0100
To: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Extreme swapping / new location of Paul's kernels [was Re: Kernel  debugging??]
Message-Id: <19991119112522.020925@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 19, 1999, Martin Costabel <costabel@wanadoo.fr> wrote:

>   kernel: Calibrating delay loop... 133.12 BogoMIPS 
>
>Booting with BootX-1.2b2, I get with the same kernels
>
>   kernel: Calibrating delay loop... 11.39 BogoMIPS
>
>This is repeatable, but for me quite incomprehensible.

Ouch. Could this be a problem with VIA-based calibration in the kernel ?

Paul ? Any clue ? I don't see what in BootX could cause this to happen,
probably MacOS playing tricks with the VIA behind my back... I just
looked at the calibration code, and it looks ok, except if interrupts are
enabled during the calibration (Actually, I don't know if MSR-EE is
enabled at this point, I should really add code to BootX that masks all
interrupts in the controller before launching the kernel anyway).

If I remember correctly, Martin, your machine has a 603. There is a
possibility that, for some reason, MacOS changes the PLL settings in HID1
(but I don't really see why this would happen with BootX 1.2x and not
with previous versions).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
