Return-Path: <fweisbec@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 9881FB7B9F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 09:16:25 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so3461195fga.3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 15:16:23 -0700 (PDT)
Date: Thu, 22 Oct 2009 00:16:21 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
Message-ID: <20091021221619.GF4880@nowhere>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
	<alpine.LFD.2.00.0910212305090.3526@localhost.localdomain>
	<20091021212137.GB4880@nowhere>
	<alpine.LFD.2.00.0910212327160.3526@localhost.localdomain>
	<20091021214537.GD4880@nowhere>
	<alpine.LFD.2.00.0910212350210.3526@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.00.0910212350210.3526@localhost.localdomain>
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

On Wed, Oct 21, 2009 at 11:53:21PM +0200, John Kacur wrote:
> > No problem with that. Setting no_llseek or generic_file_llseek_unlocked,
> > depending on the context is the right thing to do.
> > 
> > What I'm wondering about concerns the future code that will have
> > no llsek() implemented in their fops.
> > 
> > We can't continue to use default_llseek() for future code unless we
> > want to continue these post reviews and fixes forever.
> > 
> 
> I'm thinking that the simplier approach, would be to make the 
> default_llseek the unlocked one. Then you only have to audit the drivers 
> that have the BKL - ie the ones we are auditing anyway, and explicitly set 
> them to the bkl locked llseek.
> 
> There might be a hidden interaction though between the non-unlocked 
> variety of ioctls and default llseek though.


I fear that won't work because the bkl in default_llseek() does not
only synchronizes with others uses of the bkl in a driver, it also
synchronizes lseek() itself.

As an example offset change is not atomic. This is a long long, so
updating its value is not atomic in 32 bits archs.
