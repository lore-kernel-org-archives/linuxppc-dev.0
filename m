Message-ID: <37E6B438.974EEBFA@execpc.com>
Date: Mon, 20 Sep 1999 17:24:56 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: sound sleep
References: <Pine.LNX.3.96LJ1.1b7.990919205431.1091A-100000@ofey.inebraska.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
> Try changing the last argument of request_irq() in PMacIrqInit() and
> free_irq() in PMacIrqCleanup().  For example, change
>         request_irq(awacs_irq, pmac_awacs_intr, 0, "AWACS", 0)
> and
>         free_irq(awacs_irq, pmac_awacs_intr)
> to
>         request_irq(awacs_irq, pmac_awacs_intr, 0, "AWACS", (void *)awacs)
> and
>         free_irq(awacs_irq, (void *)awacs).
> I think that's what I did in order to get rid of the panic.

Wonderful!  it now works.  this fix should go into the kernel.

I would also like to note that with this now working,  with the sound as a
module, while sound still breaks when put to sleep on a wallstreet, it is
revived upon removing and reinstalling the module.  People may want to see if
this happens on a lombard as well.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
