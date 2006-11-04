Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add of_platform support for	OHCI/Bigendian HC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <454A59CC.6070902@bplan-gmbh.de>
References: <45490407.1010700@bplan-gmbh.de>
	<1162419799.25682.466.camel@localhost.localdomain>
	<1162423628.25682.489.camel@localhost.localdomain>
	<454A59CC.6070902@bplan-gmbh.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 10:37:45 +1100
Message-Id: <1162683465.28571.85.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 21:49 +0100, Nicolas DET wrote:

> fsoc-ppc. As I am not sure what it does exactly I 
> left it like this. This module performs well here so far.

Well, it cause the kernel to keep other interrupts disabled on that CPU
while you are handling yours. Should not be necessary and might cause
undue latencies. 

Regarding the rest of the patch, I don't understand why you are creating
duplicate match lists and probe/remove functions.

Just do a single of_platform_driver() that matches both and have it's
probe() function check the properties (device_is_compatible() would do
the trick, though a common thing in OF is to just have an empty property
"big-endian" in the node).

Ben.
