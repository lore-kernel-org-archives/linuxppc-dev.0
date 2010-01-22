Return-Path: <kodiakuppercut@gmail.com>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id A3C2EB7CD6
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 17:27:59 +1100 (EST)
Received: by iwn41 with SMTP id 41so716885iwn.12
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 22:27:58 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 21 Jan 2010 23:27:58 -0700
Message-ID: <bc81dc641001212227w429b0f33hab1e541e69a11bf7@mail.gmail.com>
Subject: Re: Large physical address support on e500 platform
From: Aaron Pace <kodiakuppercut@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> > Its possible that we've broken module/vmalloc support with
> > "Large physical addressing".? Its not something I've
> > tried in a while.? What kernel/git SHA are you using.
> >

>I'm just pulling in from the main kernel tree git.
>My current version is 2.6.33-rc4-00193-gd1e4922-dirty,
>but it had not changed since 2.6.33-rc2
>
>I started from 2.6.32, but I don't remember if I had a large PA
>support enabled there.

Just to second this issue, the following commit is what broke this:

[76acc2c1a7a9a8c2cae7e9cf8d0a8b374a48aa94]

I didn't have time to delve into the whys & hows, but this commit
caused the same issue on an 8572 platform.
Reverting this one change allows everything (including 36-bit memory
access) to work correctly, as before.

-Aaron Pace
