Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail160-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37B01DE0A8
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 06:05:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: dcr stuff.
Date: Fri, 21 Mar 2008 12:05:40 -0700
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
Cc: git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Is anybody working on the dcr infrastructure?

In particular, there seems to be inconsistency between what the kernel
does and what ePAPR thinks it should.  The code in the kernel selects
mmio or native access based on a Kconfig parameter and uses some device
tree parameters to correctly configure the mmio access, whereas ePAPR
doesn't seem to document all the device tree attributes (in particular,
dcr-mmio-stride and dcr-mmio-range) and provides a dynamic binding for
dcr-access-method...

Is there a plan here?  (In particular, in FPGA designs, its possible to
have crazy things like multiple independent dcr busses, some using
native access, some using mmio.  Or even if there is one bus, many of
the existing non-linux drivers we have assume native or mmio access.
I'd like to clean this up, obviously.. :)

Steve
