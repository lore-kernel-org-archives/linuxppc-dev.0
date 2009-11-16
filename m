Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FED5B7BEE
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 22:05:37 +1100 (EST)
Date: Mon, 16 Nov 2009 11:54:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
Message-ID: <20091116105427.GA17411@lst.de>
References: <20091010153314.827301943@linutronix.de>
	<alpine.LFD.2.00.0910212350210.3526@localhost.localdomain>
	<20091021221619.GF4880@nowhere> <200911021651.53331.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200911021651.53331.arnd@arndb.de>
Cc: Arnd Bergmann <arndbergmann@googlemail.com>,
	Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <fweisbec@gmail.com>,
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

On Mon, Nov 02, 2009 at 04:51:52PM +0100, Arnd Bergmann wrote:
> I looked at what places in the code manipulate file->f_pos directly
> and found that almost all the uses in driver code are broken because
> they don't take any locks. Most of them are in driver specific
> lseek operations. Others are in read/write methods and are even
> more broken because the change gets immediately overwritten by
> vfs_read/vfs_write when the driver method returns.
> 
> IMHO, we should complete the pushdown into all ioctl methods
> that John and Thomas have started working on, fixing the lseek
> methods in those files we touch.
> 
> When that is done, all interaction between default_llseek and
> driver locking has to be with explicit calls to lock_kernel
> in those drivers, so we can reasonably well script the search
> for drivers needing the BKL in llseek: everyhing that
>  a) defines file_operations without an llseek function,
>  b) touches f_pos somewhere, and
>  c) calls lock_kernel() somewhere
> That should only be a small number and when they are fixed,
> we can remove default_llseek and instead call generic_file_llseek
> for any file operation without a separate llseek method.

As mentioned before making generic_file_llseek the new default is
probably a bad idea.  The majority of our file_operations instances
don't actually support seeking, so no_llseek should become the new
default if you spend some effort on converting things.  Anything that
wants to allow seeking will have to set a llseek method.  This also
mirrors what we do for other file operations.  None of the major ones
has a non-trivial default, it's either silently succeeding for a
selected few like open or release or returning an error for operatings
that actually do something like read and write.
