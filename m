Message-ID: <396D5403.23A8B739@amulet.co.jp>
Date: Thu, 13 Jul 2000 14:30:43 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Robert Thompson <rothomp3@vt.edu>
CC: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: trackpad
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu><4.3.2.7.2.20000711172513.03963320@mail.munich.netsurf.de><00e801bfeb51$d19bf300$1a6a1504@strayer.edu> <00071122541602.00729@enzo.bigblue.local> <008301bfec55$bc40c580$1a6a1504@strayer.edu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert Thompson wrote:
>
> > All looks fine..., no idea what's going wrong for you. A new binary kernel
> > will be on Ben's page in a hour or so, please try that one.
>
> OK, I've tried it. No function from the trackpad still. I downloaded the
> sources and recompiled. Still no trackpad. I turned off "Enable new input
> layer" and make dep'd make clean make vmlinux etc and *still* no trackpad!
> I'm on the Yellow Dog list, and people are starting to report similar
> problems with 2000 "Pismo" PowerBooks and these kernels...

I have a Pismo here. It has a trackpad. The trackpad works, both in gpm
and in XF4, with the new input layer stuff. Both programs are set to use
protocol "IMPS/2". Both programs use /dev/mouse, which is a symlink to
/dev/input/mice, which is a device with major 13 minor 63.

Your problem after disabling the new input layer is most likely because
/dev/mouse is still a symlink to the new input layer device; you can't
have it both ways.

If the precompiled kernel doesn't work that suggests there's something
wrong in your configuration, like your /dev setup or the protocol that X
and gpm are expecting or the device X and gpm are reading from.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
