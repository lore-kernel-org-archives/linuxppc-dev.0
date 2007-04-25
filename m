Return-Path: <imrek@atomki.hu>
Received: from imrek.org (strawberry.diszk.unideb.hu [193.6.143.139])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E132EDDF3C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 06:03:09 +1000 (EST)
Date: Wed, 25 Apr 2007 21:37:15 +0200 (CEST)
From: jozsef imrek <imrek@atomki.hu>
To: linuxppc-embedded@ozlabs.org
Subject: RE: 2.6 Kernel , Xilinx Virtex and PPC 405 On chip memory controllers
	( DSOCM and ISOCM )
In-Reply-To: <BAY115-W14E65268F6A301B98090EEB24A0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0704252120270.24746@imrek.org>
References: <BAY115-W14E65268F6A301B98090EEB24A0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 24 Apr 2007, Mohammad Sadegh Sadri wrote:

> Then in mailing list I saw some where that AVNET mini-modules are using 
> a version of FX12 FPGA which has problem with PPC caches and as the 
> solution the caches should be off.

i think the relevant errata is this:
http://www.xilinx.com/xlnx/xil_ans_display.jsp?getPagePath=20658
see solution 13.


as far as i understand the problem was caused by the plb2opb bridge
used in the design. the bridge was necessary because the plb_ddr
controller in earlier EDKs did not support the 16bit DDR memory
present on the avnet (earlier memec) minimodule, therefore you had to
use an opb_ddr controller.

however, the plb_ddr present in recent EDKs (ie plb_ddr v2.00.a)
_does_ support 16bit wide memory, therefore you do not need the
plb2opb bridge.

so as long as you are using the plb_ddr controller, and you are
disabling cache for other devices on the opb bus you should be
safe.



could someone with more authentic knowledge confirm this? anyone
from xilinx/avnet?



-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------
