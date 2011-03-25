Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id E9E72B6FE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 20:23:47 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 28294-04 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 09:23:36 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: High load average (~2.0) on an idle PowerPC 64 machine
Date: Fri, 25 Mar 2011 09:23:27 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ACA1@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I've this Quad G5 machine that's sitting pretty much idle with the
> latest Debian stable installed, and yet it's got an abnormaly high
> load average.

The 'load average' value is rather useless since it seems to
contain any process that is sleeping uninterruptibly, and
IIRC any process that has run at all (for however short a
period) in the current schedule epoch (or whatever period
is relevant).

I can easily generate a linux system that is 99.9% idle
but has a 'load average' of 20 or more.
It would still be 99.9% idle even if the idle time
were based of the actual time outside the scheduler
idle loop (as NetBSD doe) rather than where timer
ticks interrupted.

We also have the related fubar (on x64/amd64) of the
kernel generating stack traces for processes that are
sleeping uninterruptibly for long periods.

	David
