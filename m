Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5D17DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 03:04:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l3GH1Oop030786
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 13:01:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3GH414g111152
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 11:04:01 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3GH3iuX025125
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 11:03:45 -0600
Date: Mon, 16 Apr 2007 12:03:28 -0500
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
Message-ID: <20070416170328.GD8281@austin.ibm.com>
References: <1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
	<97762565fcdccbf85d1d04cd055b1197@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97762565fcdccbf85d1d04cd055b1197@bga.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 14, 2007 at 02:42:02PM -0500, Milton Miller wrote:
> 
> Did you consider making MAX_TIMEOUT a module parameter?   It could then
> be changed at runtime through /sys/modules/.

There's a philosophy (that I have warmed up to over time) that 
says that too much kernel configurability is a bad thing.  
Less configurability makes problems easier to debug: you don't
have to worry about:

-- bugs that occur for only certain parameter settings
-- some dang-fool user/sysadmin setting the timout to 
   1000 seconds (mistaking seconds for milliseconds) and
   then reporting a bug.
-- the latest fedora core having some udev script that
   finds the hvc console and slaps some crazy values into it.

Surely, we have all known that bright-eyed, bushy-tailed 
developer who, when they ask you for help with a bug, 
your first questions are "did you mess with it?" and 
"which part did you mess with?"

--linas
