Message-Id: <5.0.0.19.2.20000907142215.01e79ca0@mail.munich.netsurf.de>
Date: Thu, 07 Sep 2000 14:42:51 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: newer xfree86 4.0.1 patches
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10009071151320.461-100000@cassiopeia.home>
References: <20000906213248.A3749@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:53 07.09.00, Geert Uytterhoeven wrote:

>On Wed, 6 Sep 2000, Olaf Hering wrote:
> > There is also a keycode file for ps/2 based machines like PReP and CHRP,
> > called "powerpcps2". It is a workaround, the arrow keys and the page
> > up/down block are dead as example. I guess it is a kernel bug.
>
>So prefixed scancodes don't work? Sounds familiar. I guess this has something
>to do with the X server putting the keyboard in RAW mode (send raw scancodes,
>including prefixes) instead of MEDIUMRAW mode (send keycodes, 1 code for each
>key pres/release) or vice versa.

My xf4 work I did for the linux keycodes support fixes that. It's a
configurable option now (well, in 4.0.2 I hope). XkbModel "macintosh_old"
or XkbKeycodes "macintosh" for ADB keycodes/MEDIUMRAW mode, everything else
is Linux keycodes/RAW mode, or, if it can open the sysctl
/proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes, it tries to
autodetect. This will make PReP and CHRP users with PS2 keyboards happy I
hope :-).

On my TODO list, I still have to make chrp_setup.c and prep_setup.c use
machid_init_hw() and friends in machid.c.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
