In-Reply-To: <Pine.LNX.3.96LJ1.1b7.991006082634.2962A-100000@ofey.inetnebr.com>
Date: Wed, 6 Oct 1999 18:25:56 +0200
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: update on macserial/DMA
Message-Id: <19991006182556.021225@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 6, 1999, Takashi Oe <toe@unlserve.unl.edu> wrote:

>I've just tried your fix, and, as expected, it causes no harm for PMac
>7600.  Thanks.  It's not a big problem, but I think we don't want the
>"fake" channel to take up "/dev/ttyS3" or such in case another serial
>driver is to be used concurrently.

I beleive this could be acheived by changing line 2404 to pass
zs_channels_found-1. Not pretty but not less than my fix anyway... The
fake zs_soft exist only because of the assumption zs_channel[i] matches
zs_soft[i], I didn't take time to check if this assumption exist only in
the probe code or not. I'll try to do something better next week-end if I
find some spare time.

>I think ehternet/modem combo is only for the US model of PowerBook
>3400/3500.  If Paul had it, the combo should be working a long ago. :)

Yes, you are certainly right ;)

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
