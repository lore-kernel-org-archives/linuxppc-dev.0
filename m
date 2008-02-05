Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F7EBDDEDB
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 03:30:46 +1100 (EST)
Date: Tue, 5 Feb 2008 10:29:42 -0600
From: Matt Porter <mporter@kernel.crashing.org>
To: Zhang Wei <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 4/6] Add multi mport support.
Message-ID: <20080205162942.GB20177@gate.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
	<EC566605-6890-4983-8700-3B15C9EFC1C5@kernel.crashing.org>
	<F2D2FCC7-D1ED-4DC6-BE7A-EE2755CCE125@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0697@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ABF87B0B6A38C0458E319AC973ED68AEBD0697@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 31, 2008 at 02:30:13PM +0800, Zhang Wei wrote:
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org] 
> > when we have multiple ports are the device IDs on the ports intended  
> > to be unique only to a port or unique across all ports?
> > 
> I consider each RIO controller will has its own network, the device IDs
> should be
> unique only in its port network.

This is a bad assumption IMHO. It pushes policy on to the system
designer of a RapidIO network.

It is very possible to use multiple controllers as entry points
in a single RapidIO network fabric space. The reason one would do this
is to provide optimized paths to some endpoints in the system.

If possible, there should never be a policy assumption like this in
kernel space. It's much better to assume that one may or may not
have a unique id space.

-Matt
