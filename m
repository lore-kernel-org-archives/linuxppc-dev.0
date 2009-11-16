Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C7DDAB7BF1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 23:10:01 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
Date: Mon, 16 Nov 2009 13:09:47 +0100
References: <20091010153314.827301943@linutronix.de>
	<200911021651.53331.arnd@arndb.de> <20091116105427.GA17411@lst.de>
In-Reply-To: <20091116105427.GA17411@lst.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911161309.47186.arnd@arndb.de>
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

On Monday 16 November 2009, Christoph Hellwig wrote:
> As mentioned before making generic_file_llseek the new default is
> probably a bad idea.  The majority of our file_operations instances
> don't actually support seeking, so no_llseek should become the new
> default if you spend some effort on converting things.  Anything that
> wants to allow seeking will have to set a llseek method.  This also
> mirrors what we do for other file operations.  None of the major ones
> has a non-trivial default, it's either silently succeeding for a
> selected few like open or release or returning an error for operatings
> that actually do something like read and write.

Ok, good point.

Do you think we should also prevent pread/pwrite for devices without
an llseek operation, like nonseekable_open does? I guess that would
be consistent.

Then there is the point that (I forgot who) brought up that changing
code to do no_llseek is actually an ABI change. Even if the file
position is never used anywhere, some random user application might
expect a chardev not to return an error when its llseek method is
called, resulting in regressions.

	Arnd <><
