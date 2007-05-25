Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id A7CF4DDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 06:43:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 5/7] ps3: Disk Storage Driver
Date: Fri, 25 May 2007 22:43:41 +0200
References: <20070525083607.784351000@sonycom.com>
	<200705251826.25572.arnd@arndb.de>
	<Pine.LNX.4.62.0705252137230.2657@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0705252137230.2657@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705252243.41508.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 May 2007, Geert Uytterhoeven wrote:
> 
> > I don't really understand what the kthread is needed for. You probably
> > thought about multiple options and ended up with this, but having
> > a comment in front of it might be helpful.
> 
> I used a kthread because the request function of a block device driver must be
> non-blocking, and ps3stor_read_write_sectors() calls wait_for_completion().

Ok, but why does it call wait_for_completion() then?
I thought you could end_that_request_* from the interrupt handler instead.

	Arnd <><
