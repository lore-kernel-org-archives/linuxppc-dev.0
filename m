From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 22:13:39 -0500
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Daniel Berlin <dan@cgsoftware.com>
References: <20011114215212.IFBL3045.tomts12-srv.bellnexxia.net@there> <20011114221403.12088@smtp.wanadoo.fr>
In-Reply-To: <20011114221403.12088@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RMNTQHSNQ968QG7JV5NR"
Message-Id: <20011115031058.IRIW10804.tomts19-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_RMNTQHSNQ968QG7JV5NR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Ben,

Okay here it is as a patch against your latest rsync versions.  I tried
not to touch any of Daniel's changes that should become redundant if the
EDID stuff works for everyone, they are still in there.

(see attached dfp_radeon.patch.gz)

FYI:

There are a few things I did change with how some fp registers are
intiialized that may impact others.   Especially how timings are
calculated for MT_LCD and MT_DFP.

Previously the code had the following in radeon_load_video_mode()
which just does  not look right at all.

       if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {

...snip...
                hTotal = mode->xres + rinfo->hblank + mode->left_margin;
                hSyncStart = mode->xres + rinfo->hOver_plus +
mode->right_margin;
                hSyncEnd = hSyncStart + rinfo->hOver_plus +
mode->hsync_len;

                vTotal = mode->yres + rinfo->vblank + mode->upper_margin;
                vSyncStart = mode->yres + rinfo->vOver_plus +
mode->lower_margin;
                vSyncEnd = vSyncStart + rinfo->vSync_width +
mode->vsync_len;
        }


But

HTotal = x active area +  hblank

hSyncStart  = x active area + offset to the sync (which is hOver_plus)

(I have no idea why mode->right margin is added  - we are then adding the
same thing twice!)

There are similar confusions over vTotal, vSyncStart, and vSyncEnd.  We
seem to be adding the same thing twice in many cases.   The latest XF86
CVS HEAD radeon_driver, calculates things the way I do and not the way it
seems to be done here previously.

I just don't understand how this could have worked for LCD and it did not
work for DFP at all.

So my patch fixes this which might make a difference but should actually
make things better.

Anyway, please give it a try.  I will send followup patches with other
fixes and additions I make to improve things but this should be enough to
get people working until the i2c stuff gets going.

So Daniel, if you get a chance, please try this.  If it works, then we
have broken nothing for you and we can then decide if you want to move to
the more general case of using EDID info.  If it does not work, please let
me know asap so I can back out my changes in groups until we identify what
is going wrong here.

Thanks,

Kevin



--------------Boundary-00=_RMNTQHSNQ968QG7JV5NR
Content-Type: application/x-gzip;
  name="dfp_radeon.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dfp_radeon.patch.gz"

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
rci2ubylKDQCj47e/C/oDLYhFT8AAA==

--------------Boundary-00=_RMNTQHSNQ968QG7JV5NR--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
