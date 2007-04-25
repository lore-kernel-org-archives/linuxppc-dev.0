Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9895DDFAE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 05:12:00 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HgmuC-0004ke-Ud
	for linuxppc-embedded@ozlabs.org; Wed, 25 Apr 2007 12:11:57 -0700
Message-ID: <10184448.post@talk.nabble.com>
Date: Wed, 25 Apr 2007 09:27:35 -0700 (PDT)
From: rvk <rvkisley@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: ppc 405 (xilinx) physical RAM not at 0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Wise folks, I apologize if this is a dupe, if so please send a link either in
forum or external to educate me.

I have a port coming up to a ppc 405 Xilinx board. The port-from board has
RAM at 0x0000_0000, but the new board will not have that. I have read Dave
Lynch's external article here: (http://www.linuxjournal.com/article/9362),
there is a paragraph where he describes asking forums for help and being
told NO! NO! don't do that..., I don't have a choice. The
include/asm-powerpc/ppc_asm.h header includes the tophys() and tovirt()
macros used in arch/ppc/kernel/head_4xx.S to set up the initial mapping of
KERNELBASE, and they seem hardcoded to a phys address for RAM of 0 (tophys
in the final BOOKE/else case converts by subtracting KERNELBASE from itself
basically, giving a base phys of 0).  I'm worried this is the tip of the
iceberg.

Can anyone point me to patches or advice on how to get the 405 source using
a different phys RAM base? 
-- 
View this message in context: http://www.nabble.com/ppc-405-%28xilinx%29-physical-RAM-not-at-0-tf3646549.html#a10184448
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
