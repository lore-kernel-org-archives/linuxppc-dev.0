Message-ID: <012301bfec6a$b5474aa0$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: "Benjamin Herrenschmidt" <bh40@calva.net>,
        <linuxppc-dev@lists.linuxppc.org>
References: <20000712231905.23171@192.168.1.10> <20000712233159.26202@192.168.1.10>
Subject: Re: trackpad
Date: Wed, 12 Jul 2000 21:35:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> What I wrote can be a bit confusing. I meant:
>
>  - The new layer will create new devices that mix all mice (including
> trackpad) and route them to the new /dev/input/mice device. Of course,
> you need to create this device (with mknod) and eventually link /dev/
> mouse, /dev/adbmouse and /dev/usbmouse (yes, all 3 of them) to /dev/
> input/mice. There are some explanation on how to do that on my page.
> Those will output imps2 protocol.
>
Right, did that, and usbmice work fine. No, I made sure /dev/adbmouse still
had it's old major and minor, it is not a symlink to /dev/input/mice.

>  - The latest kernel (pre10-ben1) will keep the old /dev/adbmouse device
> alive. That means that if you don't set /dev/adbmouse to point to the new
> /dev/input/mice but instead keep it to it's old major/minor, you'll still
> get a busmouse-like device on /dev/adbmouse
>
In theory, but it isn't working that way. Or, at least, *something* isn't
working... I'm not lying here, the trackpad really isn't working :)

>  - I also added this new "adb_xpmac_compat" kernel command line option
> (at least until Xpmac is fixed). With this, the driver will, by default,
> enable sending of ADB mouse moves as fake keycodes to the console, like
> MkLinux, in a way compatible with Xpmac. The new driver won't do it any
> more unless you use that option or your do
>
> echo "1" >/proc/sys/dev/mac_hid/adb_mouse_sends_keycodes
>
I tried both using the kernel command line and/or setting this /proc flag,
but nothing works, in any combination. Sorry to seem... I don't know,
annoying (if I do) but this is a rather important bug to fix, I'd say...

Later,
Robbie Thompson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
