Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3B6B688BE
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2005 11:50:04 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrei Warkentin <andrey.warkentin@gmail.com>
In-Reply-To: <E6B18F88-0CD3-4832-8BB6-232580280009@gmail.com>
References: <E6B18F88-0CD3-4832-8BB6-232580280009@gmail.com>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 11:45:24 +1100
Message-Id: <1134780324.6102.21.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Powermac real-mode? setting?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-12-16 at 02:53 -0600, Andrei Warkentin wrote:
> Hello,
> 
> As far as I understand, linux expects to be started in virt-mode,  
> with MMU on. 

No, Linux doesn't care. All it expects is that if MMU is on, it will be
started with a 1:1 mapping. In fact, pSeries (and CHRP) generally boot
in real mode, as does BootX.

> Does anyone know if  setting real-mode? to true will work correctly? I'm
> trying to get something in the way of a home-brew  
> kernel going on an G4 OF 3.0-based machine, and was wondering if it  
> was possible to start out with the MMU off.

I doubt Apple's OF 3.0 will boot at all in real mode :) It's not a
kernel problem per-se, it's Apple's OF who tend to really only work in
virtual mode nowadays.

There should be no problem however switching MMU off from within your
"home brew" kernel. Look at how the linux kernel does in head.S 

> Thank you very much and have a nice day.
> 
> Andrei Warkentin
> andrey.warkentin@gmail.com
> Cell: (+1) (847) 321-15-55
> Office: (+1) (312) 756-15-00 x614
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
