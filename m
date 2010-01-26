Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F08AB7E5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 08:04:04 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0QL40o1025112 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 14:04:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o0QL44I2006591
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 15:04:04 -0600 (CST)
Message-ID: <4B5F58B0.9090401@freescale.com>
Date: Tue, 26 Jan 2010 15:03:44 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan.Geer@faa.gov
Subject: Re: BSE-IP
References: <OF3B9B44C2.CF12E7DB-ON852576B7.0070B35D-852576B7.0070B371@faa.gov>
In-Reply-To: <OF3B9B44C2.CF12E7DB-ON852576B7.0070B35D-852576B7.0070B371@faa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan.Geer@faa.gov wrote:
> My end goal is to run the latest 2.6.32 kernel on an ancient BSE-IP MPC823
> board.  One step in the process is an attempt to compile the last "working"
> kernel for this platform, and it hasn't been pretty.
> 
> Back in 2005, Kumar Gala caught an issue with compiling for this platform,
> and Dan Malek commented about which options to choose to complete a
> successful compile.  I'm in the process of trying to get that (2.6.16.62)
> series to work.  It seems that one of the newer dev boards got the focus of
> the port, and the BSE-IP drop out of sight.

Newer boards have been used for recent development, but it shouldn't be 
too hard to get other boards to work.  With the device tree, a lot more 
of the hardware description is done in a data structure, rather than 
scattered throughout code.

I'd start by taking one of the existing supported 8xx boards in the 
current tree, and adapting its device tree and platform file to describe 
the BSE-IP, using the old code as a reference.  You may also need 
bootwrapper changes, depending on what firmware you use.

Things have changed enough that I don't recommend trying to directly 
merge the old code into the new kernel.

-Scott
