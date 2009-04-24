Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96BD1DE16A
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 01:14:16 +1000 (EST)
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com
	([99.236.111.22] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1LxLso-0002CO-HX
	for linuxppc-dev@ozlabs.org; Fri, 24 Apr 2009 09:56:02 -0400
Date: Fri, 24 Apr 2009 09:55:06 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: where to simplify code using is_power_of_2() function
Message-ID: <alpine.LFD.2.00.0904240953120.17180@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  just an observation that you can aesthetically simplify some ppc
code using the boolean is_power_of_2() routine from
include/linux/log2.h if you were so inclined:

arch/powerpc/sysdev/ppc4xx_pci.c:171:	if ((size & (size - 1)) != 0  ||
arch/powerpc/mm/ppc_mmu_32.c:216:	if (n_hpteg & (n_hpteg - 1)) {
arch/powerpc/boot/cuboot-pq2.c:176:	if (mem->size[1] & (mem->size[1] - 1))
arch/powerpc/boot/cuboot-pq2.c:178:	if (io->size[1] & (io->size[1] - 1))
arch/powerpc/lib/rheap.c:258:	if ((alignment & (alignment - 1)) != 0)
arch/powerpc/lib/rheap.c:307:	if ((alignment & (alignment - 1)) != 0)
arch/powerpc/lib/rheap.c:450:	if (size <= 0 || (alignment & (alignment - 1)) != 0)

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Linked In:                             http://www.linkedin.com/in/rpjday
Twitter:                                       http://twitter.com/rpjday
========================================================================
