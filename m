Return-Path: <arnd.bergmann@de.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E713667B16
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 02:13:24 +1000 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k59EIvjO024325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 Jun 2006 10:18:57 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k59EIrOL004176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 Jun 2006 10:18:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k59EIrPL180286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 Jun 2006 10:18:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k59EIqR3001012
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 Jun 2006 10:18:52 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: a problem of kernel-module version mismatch.
Date: Fri, 9 Jun 2006 16:18:50 +0200
References: <BAY110-F337711EB19C0B1D8417B18B2880@phx.gbl>
In-Reply-To: <BAY110-F337711EB19C0B1D8417B18B2880@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200606091618.51169.arnd.bergmann@de.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 09 June 2006 16:07, Ming Liu wrote:
> Are in_le32 and out_le32 two functions defined by the kernel to input and 
> output 32-bit data? When we define XIo_In32 and XIo_Out32 as them, which is 
> we use out_le32 and in_le32 to input and output data, they are still not 
> resolvable. Any other suggestions? Thanks a lot.

They should be defined in include/asm-powerpc/io.h, include <asm/io.h>
to get the definition.
If your kernel is too old, they may not be there however, so you need
to use readl/writel or inl/outl, also defined in that file.

	Arnd <><
