Date: Tue, 4 Dec 2001 13:06:37 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: "Kevin B.Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rage128 support for resolutions less than panel resolution?
In-Reply-To: <20011204175547.WVJL16262.tomts14-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.40.0112041255450.11201-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The patch for stretching for lower panel resolutions is working perfectly
on this iBook. I did have to make a minor modification to aty128fb.c to
get it to work right, though - I had to add a section for PowerBook2,1 and
PowerBook2,2 compatible systems (that's all the round-case iBooks, with
and without FireWire) that set the info->panel_width and
info->panel_height variables to the correct values. I've noticed that the
'width' and 'height' properties of the ATY,RageM3p1 device node in
/proc/device-tree contain the actual panel dimensions, so that might be
all that's needed (at least on PPC systems, since they have a device tree)
to get the real panel dimensions.

Also, 'fbset 640x480-60' produces a slightly messed up display - the image
is squished to half-height, and doubled (same above and below) - but
640x480-72 and 640x480-75 both work correctly.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
