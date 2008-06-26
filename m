Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6DD67DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 09:24:09 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Date: Fri, 27 Jun 2008 01:23:05 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261838.33787.arnd@arndb.de>
	<20080626180530.GA22827@cs181140183.pp.htv.fi>
In-Reply-To: <20080626180530.GA22827@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806270123.06669.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Adrian Bunk wrote:
> Honestly, I do not completely like your approach of getting the 
> microblaze port submitter to create the asm-generic files - I would 
> personally prefer if the microblaze port would look exactly like all 
> other ports and the (reasonable) changes you have in mind were not
> being discussed and done as part of the submission of a new port.

But it works really well this way ;-). My point is that a new port
should look just like all the other ports should have looked as
well, not like they did. When it comes to the ABI, you
cannot make incompatible changes after it's merged, so IMHO all
ABI defining headers should go to asm-generic if possible.

Since there doesn't seem to be anyone investing work into moving the
files there (I started it before, but got bored before submitting
them all myself), the point of adding a new architecture is exactly
the right one for putting the file to asm-generic. For Michal, there
is no difference between putting the file into asm-generic or
asm-microblaze, other than that he has to change his existing
patch once, but in return he gets fewer files to maintain afterwards.

The fundamental principle here is: if you want your code to get in,
do it in a way that makes your own code cleaner by making it cleaner
for everyone else as well.
The result is that more people look at the code, and that Michal's
name gets more widely known, so the next time he needs something
from another developer, he's more likely to get heard because
you think of him as the person that did all the useful work on
the asm-generic files.

> After all, it won't matter whether we'll unify resp. remove
> 22 or 23 files.

That wasn't my idea. The logic was that if one more file exists
in asm-generic that can be removed from the architectures,
we get 22 more files to remove without anyone having to look
at the big picture. When microblaze is in, I can compile a list
with asm-generic files that can be used to replace the architecture
specific files, so the arch maintainers can decide on their own
whether to clean their own stuff up or not.

With namei.h, I may have gone too far to request moving it
to asm-generic as part of the microblaze merge, because it's
not an ABI header, but I think it's a step in the right direction
anyway, and I may put it there myself if I ever get to do
my "how to port Linux to a new architecture the right way" paper.

	Arnd <><
