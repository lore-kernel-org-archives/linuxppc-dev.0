Return-Path: <rbrito@ime.usp.br>
Received: from nm2-vm1.bullet.mail.bf1.yahoo.com
 (nm2-vm1.bullet.mail.bf1.yahoo.com [98.139.213.158])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C608E1A084E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 07:43:25 +1000 (AEST)
Resent-Message-ID: <20150409214318.GA22595@ime.usp.br>
Date: Tue, 7 Apr 2015 22:56:49 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150408015649.GA11297@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
 <20150408003638.GA5170@ime.usp.br>
 <1428454204.22867.497.camel@freescale.com>
 <20150408011300.GA6395@ime.usp.br>
 <1428456423.22867.501.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1428456423.22867.501.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Scott.

Once again, thank you for being patient with this newbie. It is really
appreciated that you're willing to educate me.

On Apr 07 2015, Scott Wood wrote:
> On Tue, 2015-04-07 at 22:13 -0300, Rogério Brito wrote:
> > On Apr 07 2015, Scott Wood wrote:
> > > It will probably give you the address and size of the flash, which is
> > > good enough to get something working.  Does your config (for the old
> > > kernel) have anything with PHYSMAP in it?  I suspect it probably broke
> > > with commit dcb3e137ce9be1dfc86e306182b23e3ae5e239c4 ("[MTD] physmap:
> > > make physmap compat explicit").
> > 
> > Here is what my 2.6.27 kernel has in the section regarding physmap:
> > 
> > ,----
> > | #
> > | # Mapping drivers for chip access
> > | #
> > | # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> > | CONFIG_MTD_PHYSMAP=y
> > | CONFIG_MTD_PHYSMAP_START=0xffc00000
> > | CONFIG_MTD_PHYSMAP_LEN=0x400000
> > | CONFIG_MTD_PHYSMAP_BANKWIDTH=1
> > | # CONFIG_MTD_PHYSMAP_OF is not set
> > | # CONFIG_MTD_INTEL_VR_NOR is not set
> > | # CONFIG_MTD_PLATRAM is not set
> > `----
> > 
> > Here is what my 4.0-rc6 kernel has:
> > 
> > ,----
> > | #
> > | # Mapping drivers for chip access
> > | #
> > | # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> > | CONFIG_MTD_PHYSMAP=y
> > | CONFIG_MTD_PHYSMAP_COMPAT=y
> > | CONFIG_MTD_PHYSMAP_START=0xffc00000
> > | CONFIG_MTD_PHYSMAP_LEN=0x400000
> > | CONFIG_MTD_PHYSMAP_BANKWIDTH=1
> > | CONFIG_MTD_PHYSMAP_OF=y
> > | # CONFIG_MTD_INTEL_VR_NOR is not set
> > | # CONFIG_MTD_PLATRAM is not set
> > `----
> > 
> > I may try to revert locally that patch here to see if things improve or not,
> > but it will take me some time to compile it (I hope not much).
> 
> Oh right, it's the partitions that are missing, rather than the flash
> device itself.  It was probably commit
> 13e0fe49f676607688da7475c33540ec5dac53b5 ("mtd: drop physmap_configure")
> that broke your out-of-tree kernel.

This kernel is not out-of-tree. I have been compiling things from Linus's
tree since the 2.6.20's (I don't remember precisely).  Perhaps I should just
have shouted at the time, but I thought that it might have, perhaps, been a
problem on my side.

> Maybe you (or someone) dropped a call to physmap_set_partitions() to stop
> the build error, and didn't replace it with anything?

I with that I knew how to code stuff in the kernel besides simply following
the instructions in "make oldconfig", "make menuconfig" and similar. :)

I guess that this would be a good opportunity to learn at least the basics
of writing a dts, though, but I lack the knowledge of the hardware. I do
know what the partition were reported before in previous kernels, if that
helps anything.

Would it help if you had ssh access here, so that you can see how the system
is?  Or, if you want me to, I can try to get as much information as I can
via whatever means you want me to.


Thanks,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
