Return-Path: <fweisbec@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id 35989B7BA1
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 08:45:42 +1100 (EST)
Received: by fxm21 with SMTP id 21so8126787fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 14:45:40 -0700 (PDT)
Date: Wed, 21 Oct 2009 23:45:38 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
Message-ID: <20091021214537.GD4880@nowhere>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
	<alpine.LFD.2.00.0910212305090.3526@localhost.localdomain>
	<20091021212137.GB4880@nowhere>
	<alpine.LFD.2.00.0910212327160.3526@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.00.0910212327160.3526@localhost.localdomain>
Cc: Arnd Bergmann <arndbergmann@googlemail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2009 at 11:33:17PM +0200, John Kacur wrote:
> > Should we better pushdown default_llseek to every to every
> > file operations that don't implement llseek?
> > I don't know how many of them don't implement llseek() though.
> > 
> > That said we can't continue anymore with this default attribution
> > of default_llseek() on new fops.
> > 
> 
> If you don't explicitly set it to no_llseek, you automatically get the
> default_llseek, which uses the BKL. So if your driver doesn't need it, it 
> is best to explicitly set it to no_llseek.


Sure, that's the right thing to do.

 
> There is also a generic_file_llseek_unlocked, somewhat analogous to the 
> unlocked_ioctls that you can use if you don't need to provide a full 
> llseek yourself.


No problem with that. Setting no_llseek or generic_file_llseek_unlocked,
depending on the context is the right thing to do.

What I'm wondering about concerns the future code that will have
no llsek() implemented in their fops.

We can't continue to use default_llseek() for future code unless we
want to continue these post reviews and fixes forever.
