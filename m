Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 595E367A79
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Feb 2005 02:54:22 +1100 (EST)
Date: Wed, 16 Feb 2005 08:54:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050216155419.GJ31436@smtp.west.cox.net>
References: <20050206124014.GA5880@suse.de>
	<20050206215131.GF7686@smtp.west.cox.net>
	<20050206225323.GA16821@mars.ravnborg.org>
	<20050207082948.GB29823@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050207082948.GB29823@suse.de>
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 07, 2005 at 09:29:48AM +0100, Olaf Hering wrote:
>  On Sun, Feb 06, Sam Ravnborg wrote:
> 
> > Something like this may do the trick:
> > 
> > $(obj)/images: $(addprefix $(obj)/,$(subdir-y) $(bootdir-y))
> > 	$(Q)$(MAKE) $(build)=$@
> > 
> > And then delete the assignment of images to subdir-y
> 
> That still doesnt work right, I touched one .c file which lead to a new
> vmlinux, now zImage.rs6k is too small:

Is it possible that the dependency is being met by the file being there,
but not done?  If so, would perhaps depending on System.map as well for
vmlinux.bin fix the problem?

This doesn't make sense to me, but taking a quick look over things,
zImage.chrp (/etc) do have dependncies on vmlinux.gz which has deps on
vmlinux.bin, which deps on vmlinux.

-- 
Tom Rini
http://gate.crashing.org/~trini/
