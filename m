Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 781CA67A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 13:26:58 +1000 (EST)
Date: Wed, 30 Mar 2005 19:26:56 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Li Yang-r58472 <LeoLi@freescale.com>
Message-ID: <20050331032656.GB18254@gate.ebshome.net>
References: <9FCDBA58F226D911B202000BDBAD4673011732F4@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673011732F4@zch01exm40.ap.freescale.net>
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 11:03:00AM +0800, Li Yang-r58472 wrote:
> Well, it seems to be a historic problem.  Freescale BSP was 
> originally ported from u-boot-1.0.0 and linux-2.4.22.  So the BCSR 
> was freely chosen as 0xf8000000.  Later, we updated them to 
> u-boot-1.1.1 and linux-2.4.26, and make the BCSR consistent to older 
> version.  However the sourceforge u-boot-1.1.1 support for 
> MPC8272ADS 
> was committed by Arabella guys, they chose BCSR mapping to 
> 0xf4500000.  Kumar's MPC8272 support which is in 2.6.11 source was 
> developed using sourceforge u-boot-1.1.1 seemingly.
> 
> This might brought up a question that if we need a convention or 
> something to define the recommended memory mapping for PowerPC BSPs.  
> As there are different groups of people around the world developing 
> BSPs for PowerPC platforms, and often the communication between them 
> is very limited.
> 
> For now using kernel and u-boot released from the same vendor is recommended.
> 

There is trivial solution which will work regardless on which version 
of U-Boot and kernel you are using.

DO NOT hardcode such stuff in TWO DIFFERENT places, do this only in 
one, in this case it should be firmware (e.g. U-Boot).

In kernel just read BRx register for that chip select and use this 
address for accesses from the kernel. This is how I do on all my 
board ports.

No need to establish any artificial conventions on memory map, etc.

--
Eugene
