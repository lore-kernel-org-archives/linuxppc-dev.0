Return-Path: <dmitry.torokhov@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id 36553DDF0D
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:51:04 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so850435nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 11:51:03 -0700 (PDT)
Message-ID: <d120d5000707201151q433f1f3eteb479109291a54bd@mail.gmail.com>
Date: Fri, 20 Jul 2007 14:51:02 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <20070720183503.GC3801@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070720164043.523003359@mail.of.borg>
	<20070720164323.625963918@mail.of.borg>
	<d120d5000707201047y2d22167co882a10176d79fce4@mail.gmail.com>
	<20070720183503.GC3801@stusta.de>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/20/07, Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Jul 20, 2007 at 01:47:36PM -0400, Dmitry Torokhov wrote:
> > Hi Geert,
> >
> > On 7/20/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> From: Geert Uytterhoeven <geert@linux-m68k.org>
> >>
> >> m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
> >>
> >> drivers/char/keyboard.c: In function 'kbd_keycode':
> >> drivers/char/keyboard.c:1142: error: implicit declaration of function
> >> 'mac_hid_mouse_emulate_buttons'
> >>
> >> The forward declaration of mac_hid_mouse_emulate_buttons() is not visible
> >> on
> >> m68k because it's hidden in the middle of a big #ifdef block.
> >>
> >> Move it to <linux/hid.h>, correct the type of the second parameter, and
> >> include <linux/hid.h> where needed.
> >
> > linux/hid.h contains definitions needed for drivers speaking HID
> > protocol, I don't think we want to put quirks for legacy keyboard
> > driver there. I'd just move the #ifdef within drivers/char/keyboard.c
> > for now.
> >...
>
> If you only move it you will keep the bug of the wrong second parameter.
>
> But if you move it to any header file gcc is able to figure out such
> errors itself instead of them being nasty runtime errors.
>
> Such prototypes in C files are really bad since (like in this case) they
> prevent the finding of bugs. It doesn't matter which header file you put
> the prototype into (it can even be a new one), but it belongs into a
> header file.
>

I am OK with adding a new header file. I was just saying that placing
that declaration in linux/hid.h makes about the same sense as putting
it into linux/scsi.h

-- 
Dmitry
