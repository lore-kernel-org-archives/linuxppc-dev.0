In-Reply-To: <00032021464800.00801@localhost.localdomain>
Date: Tue, 21 Mar 2000 12:11:20 +0100
To: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128 and Rage128Pros
Message-Id: <20000321121120.009795@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 20, 2000, Kevin Hendricks <khendricks@ivey.uwo.ca> wrote:

>These patches have been tested and work fine on my B+W G3 rev 2, my brand new
>G4 with Rage128Pro card, and on Ben's older G4 with the non-pro card.
>
>We still need to test this on a B+W G3 revision 1 just to be complete
(but Ben
>will do that soon).

Apparently, it works on all machines. I just tested on a B&W G3 rev. 1
and an iMac DV. It works also on the M3 (new r128 mobility in pismo).

However, I noticed that in all cases (or almost all cases), we have the
same XCLK as MacOS (and probably the same MCLK, I didn't verify), but we
obtain it using a lower divider. For example, on the B&W rev. 1, we have
0x1f for the ref. div, and I have 0x38 (instead of 0x3b used by MacOS).

I don't know if there's a real impact (less precise pixel clock ?). At
least, now it works on all machines, which was not the case previously.

My rsync tree contains the same kernel as Paul's latest stable tree with
a backport of 2.3.x current aty128fb with your changes (and other pismo
powerbook support stuffs). I didn't add Ani Joshi patches yet.

I'll post pre-compiled once I feel the pismo stuffs are clean enough (and
there's another problem with the latest aty128, sometimes, I've seen some
erase problems in console mode. Not very important, but...). I'll then
merge my stuffs in 2.2.x and 2.3.x bk trees.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
