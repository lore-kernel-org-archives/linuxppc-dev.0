Date: Sat, 18 Nov 2000 15:09:48 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Stefan Jeglinski <jeglin@4pi.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panic in 2.2.18pre21
In-Reply-To: <p04330100b63c8a1a240a@[192.168.0.1]>
Message-ID: <Pine.LNX.3.96L.1001118150530.15284H-100000@MOTRIN.WEH.ANDREW.CMU.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 18 Nov 2000, Stefan Jeglinski wrote:
>
[snip]
>
> C000F508:
> 	c000f4f4 T ioremap
> 	c000f518 T __ioremap
>
> C013CAC8:
> 	c013b454 t aic7xxx_load_seeprom
> 	c013c444 T aic7xxx_detect
> 	c013d9f8 t aic7xxx_allocate_negotiation_command
>
> C01FABC0:
> 	c01fab0c T scsi_init
> 	c01fad08 T st_setup
>
> C01FA8EC:
> 	c01fa840 T scsi_luns_setup
> 	c01fa884 T scsi_dev_init
> 	c01fab0c T scsi_init		[yes, same as above]
>
> C01F6058:
> 	c01f6038 T device_setup
> 	c01f61ec T rd_init
>
> C01EC9E4:
> 	c01ec910 t do_basic_setup
> 	c01ecafc T pmac_display_supported
>
> C0004434:
> 	c0004420 t init
> 	c00045c8 T machine_restart
>
> C00095EC:						[last in backtrace]
> 	c00095c0 T kernel_thread
> 	c00095f8 T idle
>
[snip]
> As you may have guessed, I'm not in front of the box at this moment
> to check it directly, but can I do a search through the source to
> find, for example, "aic7xxx_detect"?
>
> It almost looks like it went -through- the scsi setup fine and went
> on to something else related to the display? Or is it possible that
> my problems started all the way back at ioremap and finally caught up
> with me?

The backtrace is in reverse order; the topmost item is the most recent
function called. So ioremap is crashing near the end, after being called
by aic7xxx_detect.

And yes, you can find aic7xxx_detect() in the
sources, probably in linux/drivers/scsi/aic7xxx.c

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
