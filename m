Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id B64D3DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:21:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>,
 linuxppc-dev@ozlabs.org
Subject: Re: Could the DTS experts look at this?
Date: Tue, 12 Feb 2008 01:21:44 +0100
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
In-Reply-To: <20080211235652.GC18348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802120121.45349.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 February 2008, David Gibson wrote:
> Or to expand. =A0It's relatively easy now to just include multiple nodes
> in the tree and either delete or nop some of them out conditionally
> using libfdt. =A0But the conditional logic should be in the manipulating
> agent (u-boot or bootwrapper or whatever), there's no way we're going
> to require a conditional expression parser to interpret the device
> tree blob itself.

How about making the logic to nop out nodes a little more generic
without changes to the binary format?
E.g. you could have a "linux,conditional-node" property in the device
tree whose value is compared to a HW configuration specific string.
In Sean's example, you can have linux,conditional-node=3D"Rev.A" in
some nodes and linux,conditional-node=3D"Rev.B" in others, then
knock out all devices that have a non-matching linux,conditional-node
property, and finally remove the properties themselves before starting
the kernel.

	Arnd <><
