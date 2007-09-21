Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52DECDDEF8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:34:41 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8L3YbKM019991
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 23:34:37 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8L3YbZE535340
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 23:34:37 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8L3YbmG004777
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 23:34:37 -0400
Subject: 44x bug: funny TLB writes?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 22:34:12 -0500
Message-Id: <1190345652.25483.6.camel@basalt>
Mime-Version: 1.0
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I seem to have come across a strange bug while doing KVM development. It
seems that the final tlbwe in finish_tlb (head_44x.S) is actually
leaking RPN bits into the "attribute" word.

When I set a breakpoint there and press enter on the serial console, I
see r12=ef600703, which is the physical address of the UART on this chip
(440EP), plus the correct permission bits at the bottom.

Am I crazy? I'm not really looking to step through that assembly right
now... Clearly (current) hardware is just ignoring these errant writes,
but it should be fixed.

-- 
Hollis Blanchard
IBM Linux Technology Center
