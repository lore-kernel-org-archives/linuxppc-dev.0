Date: Thu, 29 Mar 2001 08:15:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: ieee1394 fixed soon...
Message-ID: <Pine.LNX.4.05.10103290815070.11053-120000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="114856-1400724730-985846527=:11053"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--114856-1400724730-985846527=:11053
Content-Type: TEXT/PLAIN; charset=US-ASCII


FYI...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--114856-1400724730-985846527=:11053
Content-Type: MULTIPART/Digest; BOUNDARY="114856-1513646507-985846527=:11053"
Content-ID: <Pine.LNX.4.05.10103290815092.11053@callisto.of.borg>
Content-Description: Digest of 2 messages

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--114856-1513646507-985846527=:11053
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.05.10103290815090.11053@callisto.of.borg>
Content-Description: CVS Update@vger.redhat.com: linux (fwd)

Return-Path: <sparclinux-cvs-owner@vger.kernel.org>
Received: from localhost (root@localhost [127.0.0.1])
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id CAA10146
	for <geert@localhost>; Thu, 29 Mar 2001 02:42:10 +0200
Received: from phoenix.chello.be
	by localhost with POP3 (fetchmail-5.3.3)
	for geert@localhost (multi-drop); Thu, 29 Mar 2001 02:42:10 +0200 (CEST)
Received: from hood.tvd.be ([195.162.196.21]) by pop01.chello.be
          (InterMail vK.4.02.00.00 201-232-116 license f891beffebad5da1b2ebd034a97f2710)
          with ESMTP id <20010329004210.MXJS20194.pop01@hood.tvd.be>
          for <cr26864@chello.be>; Thu, 29 Mar 2001 02:42:10 +0200
Received: from nerdtwo.nerdnet.nl (root@dc-server-1.adam.psi.com [195.7.221.1] (may be forged))
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id CAA00607
	for <cr26864@chello.be>; Thu, 29 Mar 2001 02:42:09 +0200 (MET DST)
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by nerdtwo.nerdnet.nl (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id CAA15475
	for <geert@linux-m68k.org>; Thu, 29 Mar 2001 02:39:29 +0200
Received: (from localhost user: 'davem' uid#2109 fake: STDIN
	(davem@vger.kernel.org)) by vger.kernel.org id <S132627AbRC2AcP>;
	Wed, 28 Mar 2001 19:32:15 -0500
From: Dave Miller <davem@vger.kernel.org>
To: sparclinux-cvs@vger.kernel.org
Subject: CVS Update@vger.redhat.com: linux
Message-Id: <20010329003216Z132627-406+5186@vger.kernel.org>
Date: Wed, 28 Mar 2001 19:32:15 -0500
MIME-Version: 1.0


CVSROOT:	/cvs
Module name:	linux
Changes by:	davem@vger.redhat.com	01/03/28 19:32:15

Modified files:
	drivers/ieee1394: ieee1394_types.h ohci1394.c pcilynx.c
	                  pcilynx.h

Log message:
	Fix several compiler warnings and endianness
	bugs in the ieee1394 layer/drivers.
	I think what the OHCI driver author did not understand
	is that the byte swap control in the HCControl register
	controls the endianness of ieee1394 packet _DATA_ not
	the endianness of the descriptors the OHCI card uses
	to communicate with the cpu.
	Also improve ohci driver ring allocation efficiency.
	At least with this, it initializes RIO's firewire
	properly and receives the self-id packet.

--114856-1513646507-985846527=:11053
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.05.10103290815091.11053@callisto.of.borg>
Content-Description: Re: CVS Update@vger.redhat.com: linux (fwd)

Return-Path: <sparclinux-cvs-owner@vger.kernel.org>
Received: from localhost (root@localhost [127.0.0.1])
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id DAA10209
	for <geert@localhost>; Thu, 29 Mar 2001 03:17:33 +0200
Received: from phoenix.chello.be
	by localhost with POP3 (fetchmail-5.3.3)
	for geert@localhost (multi-drop); Thu, 29 Mar 2001 03:17:33 +0200 (CEST)
Received: from aeon.tvd.be ([195.162.196.20]) by pop01.chello.be
          (InterMail vK.4.02.00.00 201-232-116 license f891beffebad5da1b2ebd034a97f2710)
          with ESMTP id <20010329011512.MYZL20194.pop01@aeon.tvd.be>
          for <cr26864@chello.be>; Thu, 29 Mar 2001 03:15:12 +0200
Received: from nerdtwo.nerdnet.nl (root@dc-server-1.adam.psi.com [195.7.221.1] (may be forged))
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id DAA29412
	for <cr26864@chello.be>; Thu, 29 Mar 2001 03:15:11 +0200 (MET DST)
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by nerdtwo.nerdnet.nl (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id DAA15718
	for <geert@linux-m68k.org>; Thu, 29 Mar 2001 03:12:30 +0200
Received: from pizda.ninka.net ([216.101.162.242]:32410 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132631AbRC2BLh>;
	Wed, 28 Mar 2001 20:11:37 -0500
Received: (from davem@localhost)
	by pizda.ninka.net (8.9.3/8.9.3) id RAA29820;
	Wed, 28 Mar 2001 17:10:44 -0800
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15042.35732.324584.316033@pizda.ninka.net>
Date: Wed, 28 Mar 2001 17:10:44 -0800 (PST)
To: Ben Collins <bcollins@debian.org>
Cc: Dave Miller <davem@vger.kernel.org>, sparclinux-cvs@vger.kernel.org
Subject: Re: CVS Update@vger.redhat.com: linux
In-Reply-To: <20010328200448.J8462@visi.net>
References: <20010329003216Z132627-406+5186@vger.kernel.org>
	<20010328200448.J8462@visi.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Content-Transfer-Encoding: 7bit



Ben Collins writes:
 > Any chance you also tested this with the OHCI card I sent you on a PCI
 > ultra? I can test it with mine, and also try this firewire drive (45gigs
 > just sitting here doing nothing).

No, and I didn't hook up any devices yet to my SunBlade-1000 :-)

I'll do this when I get some time.  These bugs explain the note in the
ohci1395.c code "apple powerbook firewire detected but doesn't work",
well ppc is big endian thus... :-)

I'll send over my patches once I've done some more adequate testing
and also hacked on the video1394 driver to use PCI dma properly.

Later,
David S. Miller
davem@redhat.com

--114856-1513646507-985846527=:11053--

--114856-1400724730-985846527=:11053--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
