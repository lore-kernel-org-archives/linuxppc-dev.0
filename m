Date: Wed, 12 May 2004 13:59:50 +0200
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: diff between radeonfb.c and aty/radeon_base.c
Message-Id: <20040512135950.4e6180ae.cedric.pradalier@inrialpes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

	In dual-headed mode (no problem in single head), on my ibook2.2, I'm
experiencing the yellowish tint bug with some part of X. After googling,
I looked for the newmode.surface_cntl line in radeonfb, and I found a
strange copy-paste between radeonfb.c and aty/radeon_base.c (I use 2.6.5
kernel).
In radeon_base.c :
	/*
	 * It looks like recent chips have a problem with SURFACE_CNTL,
	 * setting SURF_TRANSLATION_DIS completely disables the
	 * swapper as well, so we leave it unset now.
	 */
	newmode.surface_cntl = 0;

#if defined(__BIG_ENDIAN)

In radeonfb.c :

#if defined(__BIG_ENDIAN)
	/*
	 * It looks like recent chips have a problem with SURFACE_CNTL,
	 * setting SURF_TRANSLATION_DIS completely disables the
	 * swapper as well, so we leave it unset now.
	 */
	newmode.surface_cntl = 0;

Note the ordering difference between ifdef and surface_cntl=0.

Is this normal ? As far as i can see, this means that surface_cntl is
not initialized on ibook with radeonfb.

I'll try to change and report.

--
Cedric

"[Of course] I'm French! Why do think I have this outrageous
accent, you silly king-a?!"  Monty Python and the Holy Grail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
