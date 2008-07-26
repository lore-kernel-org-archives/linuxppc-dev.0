Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B5E2CDDFB7
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 13:59:00 +1000 (EST)
In-Reply-To: <200807251111.26673.jk@ozlabs.org>
References: <1216887460.306306.238738123378.1.gpush@pingu>
	<200807250108.m6P18f4B099179@sullivan.realtime.net>
	<200807251111.26673.jk@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b15cc94f988df8d269ad40fafcd911cb@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
Date: Fri, 25 Jul 2008 22:59:06 -0500
To: Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 24, 2008, at 8:11 PM, Jeremy Kerr wrote:

> Milton,
>
>> Yes.  How about all dtbImage, zImage, cuboot, treeboot, etc
>> that are newer than vmlinux?
>
> The existing arch code doesn't do any checks for timestamps, perhaps
> this would be better implemented as an arch-independent change?

The problem is some people might want to add intermediate files that are
younger than vmlinux (eg .config).  We know our boot-image should be
newer.  But I don't know how one would express the expected ages.

The reason I suggested the check was to eliminate images that are not
in the current config.  I figured a test for relative file age could
be done in the for loop -- possibly replace shell wildcard with
find arch/$(ARCH)/boot/{zImage*,dtbImage*,uImage*,cuImage*,treeboot*}
-newer vmlinux -print.

> (but would you like me to add treeboot and cuboot?)

I don't see why we should prefer the workstations and servers over the
embedded boards.  zImage is just a link to the first boot image, but
one can build a multiple formats and the order is somewhat arbitrary.
So I see it as fairness.  Otherwise, there are a few other platforms
that are "user" based vs embedded (like efkia, no?).

milton
