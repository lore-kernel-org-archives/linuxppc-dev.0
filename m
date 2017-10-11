Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCB831hSWzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 11:10:42 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.14: Reported regressions as of Sunday, 2017-10-08
Date: Thu, 12 Oct 2017 01:54:30 +0200
Message-ID: <3347223.tL9VK2VkP3@aspire.rjw.lan>
In-Reply-To: <270748cf-5a97-f446-d572-9df05f8141fc@leemhuis.info>
References: <270748cf-5a97-f446-d572-9df05f8141fc@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday, October 8, 2017 2:37:41 PM CEST Thorsten Leemhuis wrote:
> Hi! Find below my second regression report for Linux 4.14. It lists 8
> regressions I'm currently aware of. One regression was fixed since last
> weeks report. One was in there that shouldn't have been there.
> 
> As always: Are you aware of any other regressions? Then please let me
> know by mail (a simple bounce in my direction is enough!). For details
> see http://bit.ly/lnxregtrackid And please tell me if there is anything
> in the report that shouldn't be there.
> 
> Ciao, Thorsten
> 
> P.S.: Thx to Adam and Igor for pointing me at two regressions they face.
> And thx to Yanko for pointing out a stupidity I did in last weeks report.
> 
> == Current regressions ==
> 
> "hangs when building e.g. perf" & "Random insta-reboots on AMD Phenom II"
> Status: "Mr. Luto better revert the new lazy TLB flushing fun'n'games"
> -> "Yeah, working on it.  It's not a straightforward revert."
> Note: TWIMC: Workaround: wrmsr -a 0xc0010015 0x1000018
> Reported: 2017-09-05
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1484723.html
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1501379.html
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1501570.html
> Cause: 94b1b03b519b81c494900cb112aa00ed205cc2d9
> 
> New default s2idle does not work on Dell XPS 13 9360
> Status: works fine on several other owners of this laptop; maybe
> specific to the variant or the particular machine the reporter owns;
> looks related to the storage device used
> Reported: 2017-09-11
> https://bugzilla.kernel.org/show_bug.cgi?id=196907
> Cause: e870c6c87cf9484090d28f2a68aa29e008960c93 (assumed)

This actually turns out to be an s2idle regression on the reporter's machine
that was introduced between 4.11-rc1 and 4.13 and appears to be related to NVMe
(and specifically to the particular Hynix 512G NVMe SSD in that machine).

Due to the lack of reproducibility, we need the reporter to bisect it to
make progress (on his system it appears to be reproducible 100% of the time).

Thanks,
Rafael
