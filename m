Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvVRy5SBJzDr0T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 06:29:50 +1000 (AEST)
Date: Fri, 23 Jun 2017 21:29:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Regression in kernel 4.12-rc1 for Powerpc 32 - bisected to
 commit 3448890c32c3
Message-ID: <20170623202943.GS10672@ZenIV.linux.org.uk>
References: <69187aa4-611f-b08a-8d14-b8fa47b4c464@lwfinger.net>
 <1588557c-2706-0c0e-3387-4ae65d0b5790@lwfinger.net>
 <20170621212257.GN10672@ZenIV.linux.org.uk>
 <5f4b9fa4-262a-31b1-32ba-a2f6e789b3d6@lwfinger.net>
 <20170621213415.GO10672@ZenIV.linux.org.uk>
 <655d304e-e455-6e0c-56e1-f127653ea13c@lwfinger.net>
 <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 23, 2017 at 01:49:16PM -0500, Larry Finger wrote:

> > BTW, could you try to check what happens if you kill the
> > 	if (__builtin_constant_p(n) && (n <= 8))
> > bits in raw_copy_{to,from}_user()?  The usefulness of those (in __copy_from_user()
> > originally) had always been dubious and the things are simpler without them.
> > If _that_ turns out to cure breakage, I would be very surprised, though.
> > 
> Sorry I was gone so long. Installing jessie on this box resulted in a crash
> on boot. Lubuntu 14.04 yielded a desktop with a functioning cursor, but
> nothing else. Finally, Ubuntu 12.04 resulted in a working system. I hate
> Unity, but I guess I'm stuck for now.

Ho-hum...  Jessie is 3.16, so whatever is crashing there, it's something
different...  Ubuntu 12.04 is what, 3.2?

> I know how easy it is to screw up a long bisection by booting the wrong
> kernel. To help that problem and to work around the yaconf/yboot nonsense on
> the MAC, my /etc/yaconf has always had generic kernel stanzas with only
> default, old, and original kernels mentioned. From there I use a local
> script to finish a kernel installation by moving the default links to the
> old ones and creating the new default links pointing to the current kernel.
> With those long-tested scripts, I'm sure that I am booting the one I want.
> 
> With the new installation, kernel 4.12-rc6 failed, as did 3448890c with the
> backported 46f401c4 added.
> 
> Replacing "if (__builtin_constant_p(n) && (n <= 8))" with "if (0)" had no effect.

OK, that simplifies things a bit.  Just to make sure we are on the same page:

* f2ed8bebee69 + cherry-pick of 46f401c4 boots (Ubuntu 12.04 userland)
* 3448890c32c3 + cherry-pick of 46f401c4 fails (Ubuntu 12.04 userland), ditto
  with removal of constant-size bits in raw_copy_..._user().  Failure appears
  to be on udev getting EFAULT on some syscalls.
* straight Ubuntu 12.04 works
* jessie crashes on boot.

Could you post the boot logs of the first two?
