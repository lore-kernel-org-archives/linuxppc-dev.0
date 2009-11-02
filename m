Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 71936B7BF6
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 02:52:26 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
Date: Mon, 2 Nov 2009 16:51:52 +0100
References: <20091010153314.827301943@linutronix.de>
	<alpine.LFD.2.00.0910212350210.3526@localhost.localdomain>
	<20091021221619.GF4880@nowhere>
In-Reply-To: <20091021221619.GF4880@nowhere>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911021651.53331.arnd@arndb.de>
Cc: Arnd Bergmann <arndbergmann@googlemail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	John Kacur <jkacur@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 22 October 2009, Frederic Weisbecker wrote:
> > I'm thinking that the simplier approach, would be to make the 
> > default_llseek the unlocked one. Then you only have to audit the drivers 
> > that have the BKL - ie the ones we are auditing anyway, and explicitly set 
> > them to the bkl locked llseek.
> > 
> > There might be a hidden interaction though between the non-unlocked 
> > variety of ioctls and default llseek though.
> 
> 
> I fear that won't work because the bkl in default_llseek() does not
> only synchronizes with others uses of the bkl in a driver, it also
> synchronizes lseek() itself.
> 
> As an example offset change is not atomic. This is a long long, so
> updating its value is not atomic in 32 bits archs.

A late follow-up on this one:

I looked at what places in the code manipulate file->f_pos directly
and found that almost all the uses in driver code are broken because
they don't take any locks. Most of them are in driver specific
lseek operations. Others are in read/write methods and are even
more broken because the change gets immediately overwritten by
vfs_read/vfs_write when the driver method returns.

IMHO, we should complete the pushdown into all ioctl methods
that John and Thomas have started working on, fixing the lseek
methods in those files we touch.

When that is done, all interaction between default_llseek and
driver locking has to be with explicit calls to lock_kernel
in those drivers, so we can reasonably well script the search
for drivers needing the BKL in llseek: everyhing that
 a) defines file_operations without an llseek function,
 b) touches f_pos somewhere, and
 c) calls lock_kernel() somewhere
That should only be a small number and when they are fixed,
we can remove default_llseek and instead call generic_file_llseek
for any file operation without a separate llseek method.

	Arnd <><
