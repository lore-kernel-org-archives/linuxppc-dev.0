Date: Sun, 24 Aug 2003 21:44:34 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Linux PPC <linuxppc-dev@lists.linuxppc.org>,
	linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz
Subject: Re: [PATCH] Fix compilation problem with 2.6.0-test2 on PPC
Message-ID: <20030824194434.GA32724@ucw.cz>
References: <1060114295.1914.6988.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060114295.1914.6988.camel@jma1.dev.netgem.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 05, 2003 at 10:11:36PM +0200, Jocelyn Mayer wrote:
> Hi,
>
> There is a compilation issue in driver/input/evdev.c
> due to the fact a "complex" expression is used as an argument
> for an inline assembly construction (get_user)
> The fix I done is to use a temporary variable to get the argument
> and then use this variable for get_user.
>
> --
> Jocelyn Mayer <jma@netgem.com>

> --- evdev.c.orig	Mon Jun 16 06:39:02 2003
> +++ evdev.c	Thu Jul 31 02:41:35 2003
> @@ -208,7 +208,7 @@
>  	struct evdev *evdev = list->evdev;
>  	struct input_dev *dev = evdev->handle.dev;
>  	struct input_absinfo abs;
> -	int i, t, u;
> +	int i, t, u, v;
>
>  	if (!evdev->exist) return -ENODEV;
>
> @@ -240,7 +240,8 @@
>  			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
>  			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
>  			u = INPUT_KEYCODE(dev, t);
> -			if (get_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
> +                        v = INPUT_KEYCODE(dev, t);
> +			if (get_user(v, ((int *) arg) + 1)) return -EFAULT;
>
>  			for (i = 0; i < dev->keycodemax; i++)
>  				if(INPUT_KEYCODE(dev, t) == u) break;

Thanks, similar patch applied.

--
Vojtech Pavlik
SuSE Labs, SuSE CR

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
