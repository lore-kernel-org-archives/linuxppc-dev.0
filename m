In-Reply-To: <Pine.LNX.3.96LJ1.1b7.991005234830.1210A-100000@ofey.inetnebr.com>
Date: Wed, 6 Oct 1999 10:35:27 +0200
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: update on macserial/DMA
Message-Id: <19991006103527.016707@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 6, 1999, Takashi Oe <toe@unlserve.unl.edu> wrote:

>Hi,
>
>I re-wrote the serial DMA support code today and put the patch against
>samba/vger linux-2.2.12 source trees (as of tonight) at
>ftp://ppc.linux.or.jp/pub/users/toe/serial/.
>I think the patch includes most of macserial patches (Ben's and Lou's
>are in there, for sure) that I know of.

It breaks (crash) on the wallstreet's internal modem. The reason is that
this machines has two SCCs (4 channels) but the device tree only declares
channel A on the second SCC (so we have only 3 channels visible). This
breaks the channel cross-references you use to access channel B's
registers. I'll try to make a simple fix if I find some time today and I
think I'll just rewrite the probe code by the end of the week or next
week end since it's too much dependent on the device tree layout.

BTW. Paul: The patches on my test page (url below + .../test.html)
include among other things support for the PowerBooks 3400/3500
ethernet/modem combo interrupt. It looks like there is a second ohare
chip with cascaded interrupt controller either in the combo itself or on
the motherboard (or a chip that mimmics the ohare chip). It's not
referenced by name in the device tree but by vendorid/deviceid. I'm
wondering if it might contains also an SCC cell for the modem but I can't
test, I don't have access to one of those machines. I think you have a
3400, don't you ? I'll make sure my new probe code can easily be used to
declare SCC cells for this kind of cases (but just passing the addresses
in) just in case...

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
