Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47C80DE44D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 23:53:55 +1000 (EST)
In-Reply-To: <9e4733910807161738g58da8bd7v78e9d50dc4d846cb@mail.gmail.com>
References: <1dce2aab6509053e60f7a59a30974749@bga.com>
	<9e4733910807161738g58da8bd7v78e9d50dc4d846cb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3400bffa9d49e09b00e04cafcd751322@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [HOW] binutils-2.17 breaks the 2.6.26 kernel
Date: Thu, 17 Jul 2008 15:53:07 +0200
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Alan Modra <amodra@bigpond.net.au>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Previous threads have mentioned that binutil-2.17 is broken for
> building powerpc kernels. It is fixed in binutils-2.18.

Yes.

> I have encountered this and upgrading to 2.18 fixed my build. The
> symptom is large kernel sizes and a long time in gzip. In my case it
> was gziping a 2GB file.

Are you using a "binary" (non-ELF) image file?  This sounds like a
different problem, caused by the kernel linker script not handling
the build-id section correctly -- it places it at 0, and the rest
of the kernel at 3GB, you can imagine the rest.  I've seen this
on various embedded targets, but not on PowerPC iirc -- maybe I
don't build any affected defconfig, what's yours?


I have a working (tested! thanks Milton) workaround for the current
problem, will send it later today.  This problem funnily is hidden
by the presence of build-id :-)


Segher
