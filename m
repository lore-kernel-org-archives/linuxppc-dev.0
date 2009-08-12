Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 63DFDB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 00:46:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4E28DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 00:46:25 +1000 (EST)
Message-Id: <8AADD34E-A0B7-442D-85D8-977A761084EF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Krill <ben@codiert.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: change to of MTD partition parsing
Date: Wed, 12 Aug 2009 09:46:10 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

The following commit breaks the previous definition of flash  
partitions according to Documentation/powerpc/dts-bindings/mtd- 
physmap.txt.  Using the 'name' field is bad practice.  What was going  
on w/the SLOF case?

- k


commit 4b08e149c0e02e97ec49c2a31d14a0d3a02f8074
Author: Benjamin Krill <ben@codiert.org>
Date:   Fri Jan 23 17:18:05 2009 +0100

     [MTD] ofpart: Check name property to determine partition nodes.

     SLOF has a further node which could not be evaluated
     by the current routine. The current routine returns
     because the node hasn't the required reg property. As
     fix this patch adds a check to determine the partition
     child nodes. If the node is not a partition the number
     of total partitions will be decreased and loop continues
     with the next nodes.

     Signed-off-by: Benjamin Krill <ben@codiert.org>
     Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
