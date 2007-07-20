Return-Path: <dmitry.torokhov@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by ozlabs.org (Postfix) with ESMTP id 45679DDECA
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 03:47:39 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so834421nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 10:47:37 -0700 (PDT)
Message-ID: <d120d5000707201047y2d22167co882a10176d79fce4@mail.gmail.com>
Date: Fri, 20 Jul 2007 13:47:36 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <20070720164323.625963918@mail.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070720164043.523003359@mail.of.borg>
	<20070720164323.625963918@mail.of.borg>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Geert,

On 7/20/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>
> m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
>
> drivers/char/keyboard.c: In function 'kbd_keycode':
> drivers/char/keyboard.c:1142: error: implicit declaration of function 'mac_hid_mouse_emulate_buttons'
>
> The forward declaration of mac_hid_mouse_emulate_buttons() is not visible on
> m68k because it's hidden in the middle of a big #ifdef block.
>
> Move it to <linux/hid.h>, correct the type of the second parameter, and
> include <linux/hid.h> where needed.

linux/hid.h contains definitions needed for drivers speaking HID
protocol, I don't think we want to put quirks for legacy keyboard
driver there. I'd just move the #ifdef within drivers/char/keyboard.c
for now.

BTW, I don't think that mac button emulation will work well when x86
evdev-based driver gains popularity - it "grabs" the device and so no
event will flow through keyboard driver... We'd need a new solution...

-- 
Dmitry
