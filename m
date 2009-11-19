Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 31AAF1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 04:33:29 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 18:33:07 +0100
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
	<c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
In-Reply-To: <c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911191833.08254.arnd@arndb.de>
Cc: John Linn <linnj@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 November 2009, Stephen Neuendorffer wrote:
> If the problem is in the device trees that are being generated, we
> should fix the issue there.
> We've been trying to avoid putting the fully specified IP versions in
> the kernel like this, since
> the IP changes so often.

No, the problem that Alon has is that the firmware currently has no
way whatsoever to give a correct device tree, because of-serial.c
does not even know about ns16550a.

The patch adds both a special-case for the specific uart he
is using so that one is grandfathered in and a new compatible
value so future boards can specify both ns16550a and ns16550.

	Arnd <><
