From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
Date: Sat, 3 Jun 2000 11:16:01 +0200
Content-Type: text/plain
References: <200005312243.AAA00661@piglet.grunz.lu>
In-Reply-To: <200005312243.AAA00661@piglet.grunz.lu>
MIME-Version: 1.0
Message-Id: <00060311160100.00693@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Thu, 01 Jun 2000 schrieb Michel Lanners:

> > Hi list,
>
> I've finally gotten bored by control's VRAM detection code that is only
> semi-functional (either 7x00 or 8x00 VRAM is incorrectly detected).
> Until somebody comes up with a failsafe method to detect VRAM, I've
> added a command line option to control the amount of VRAM used:
>
> - either kernel command line (compiled-in):
>
> 	video=controlfb:vram:3
>
> - or insmod option (no idea whether controlfb works as module):
>
> 	insmod controlfb vram=3
>
> Possible values are:
>
> 	0 = autodetect (default)
> 	1 = 2MB bank1
> 	2 = 2MB bank2
> 	3 = 4MB (most useful; 4MB doesn't always get detected right)
>
> Larger values get cropped to bits 0 & 1.
>
> If I hear no opposition, I'll send this off to Alan; it might make it
> into 2.4.0-final.

Hi,

if you don't mind, would you try to replace the "dcbi" assembler instructions
in the detection code with "dcbf" instructions? It seems Dan inherited my bug
I had in the platinumfb driver...

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
