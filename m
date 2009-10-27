Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B935AB7BB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:42:43 +1100 (EST)
Date: Tue, 27 Oct 2009 23:42:34 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: Jonathan.Haws@sdl.usu.edu
Subject: Re: Accessing flash directly from User Space
Message-ID: <20091027224234.GA11942@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu >
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
Cc: scottwood@freescale.com, bgat@billgatliff.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I realize that.  I have a driver written that does exactly that.
> However, I need to be able to write to certain registers to setup
> the erasure.  The driver works perfectly in VxWorks, now I am
> porting it to Linux.

Most likey you are hit by the compiler reordering the accesses and
caching data in registers. You should try to use volatile pointers
(but also read the "volatile considered harmful" file in the kernel
sources -- anyways you are doing bad things nonetheless), or add
memory barriers (copy the mb() and wmb() macros defined for kernel
space).

Then, the first-word-access you show is wrong, as Scott Wood told you,
so the fact that _that_ access is not working even across msync
that's another matter.

I usually have no serious problems with driving hardware from
/dev/mem, although I've never done flash specifically as mtd is there.

hope this helps
/alessandro
