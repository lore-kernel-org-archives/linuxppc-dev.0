Return-Path: <Geoff.Thorpe@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 179F0689A0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 10:20:13 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k04NYWhq022795
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jan 2006 16:34:32 -0700 (MST)
Received: from camelot-047.seawaynetworks.com (camelot-047.am.freescale.net
	[10.10.1.47])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k04NSeRK011680
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jan 2006 17:28:40 -0600 (CST)
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 4 Jan 2006 18:20:10 -0500
References: <20051208231947.92EB9353F77@atlas.denx.de>
	<43BC542F.5040302@comcast.net>
In-Reply-To: <43BC542F.5040302@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601041820.10133.Geoff.Thorpe@freescale.com>
Subject: Re: Problems starting /init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On January 4, 2006 06:03 pm, David H. Lynch Jr. wrote:
[snip]
> 	starting a c "Hello World" application that uses glibc, fputs,
> printf, fwrite, to display a string - again works fine.
>
> 	But I can not get busybox to output a thing either run as /init or
> run as /bin/sh.

busybox tries to open the console device and does fairly extensive 
surgery with the stdio descriptors. So your apps that assume fds 
0,1,2 to be stdin/stdout/stderr are functioning fine, but busybox is 
probably choking because it's opening/configuring the console 
devices. I've worked through this with someone before when we wanted 
busybox to just run with the existing fds - we eventually beat it 
into submission but then ended up changing/replacing the console 
driver instead and going back to vanilla busybox. If you take a look 
through the busybox source, you should find the various 
fork/dup/ctrl/exit gymnastics and with a little patience, you might 
be able to hack around it. But it might be easier in the long run to 
figure out where the opening/manipulation of /dev/console (or 
whatever it's opening) is going wrong.

Sorry I can't help you further. Good luck.

Cheers,
Geoff

-- 
Geoff Thorpe
Freescale Semiconductor
