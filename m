Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B49D7DDEC7
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:57:11 +1000 (EST)
In-Reply-To: <26778ed0e343676aa0c4fd0f4fa0746b@bga.com>
References: <26778ed0e343676aa0c4fd0f4fa0746b@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4056ac22c88873e2caf674f3dd482b2d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 24/33] powerpc: Correct __secondary_hold comment
Date: Mon, 18 Jun 2007 18:56:58 +0200
To: Milton Miller <miltonm@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> How does this text sound?
>
> This code starting at offset 0x60 is used to hold secondary processors
> before the kernel has been relocated to its linked address.  Any
> platform or pre-boot environment may transfer secondary processors to
> the kernel by copying the first 0x100 bytes to address 0, and then
> instructing the secondary cpus to branch to address 0x60 after placing
> their hardware id (as specified by the device tree) in r3.

I think it is a Really Bad Idea(tm) to make this part of
the kernel ABI.  Can't you just make the secondaries enter
the kernel by jumping to the normal kernel entry point
(with some flag set in some register I suppose)?


Segher
