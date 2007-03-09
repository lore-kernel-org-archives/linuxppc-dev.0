Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 919AADDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 04:42:06 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l29Hg2RS021892
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 12:42:02 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l29Hg2xs542632
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 10:42:02 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l29Hg2gb014130
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 10:42:02 -0700
Subject: Re: [PATCH 14/15] Early serial debug support for PPC44x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <1173383051.4861.27.camel@zod.rchland.ibm.com>
References: <20070305032453.6B56ADDF1E@ozlabs.org>
	<1173383051.4861.27.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 11:42:01 -0600
Message-Id: <1173462122.4861.46.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-08 at 13:44 -0600, Josh Boyer wrote:
> On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> > 
> > +config PPC_EARLY_DEBUG_44x_PHYSLOW
> > +	hex
> > +	depends PPC_EARLY_DEBUG_44x
> > +	default "0x40000200"
> > +
> > +config PPC_EARLY_DEBUG_44x_PHYSHIGH
> > +	hex
> > +	depends PPC_EARLY_DEBUG_44x
> > +	default "0x1"
> > +
> 
> These two options need to have some kind of description string next to
> hex otherwise Kconfig will not allow you to set them.  I noticed this
> while playing with bamboo.  So something like:
> 
> config PPC_EARLY_DEBUG_44x_PHYSLOW
> 	hex "The low 32bits of the UART address"
> 
> That will allow you to change the values from the default.

And here's a patch to do that.

Fix the PPC_EARLY_DEBUG_44x options to allow setting something other
than the default.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/Kconfig.debug |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/Kconfig.debug
+++ linux-2.6/arch/powerpc/Kconfig.debug
@@ -205,12 +205,12 @@ config PPC_EARLY_DEBUG_44x
 endchoice
 
 config PPC_EARLY_DEBUG_44x_PHYSLOW
-	hex
+	hex "Low 32bits of UART address"
 	depends PPC_EARLY_DEBUG_44x
 	default "0x40000200"
 
 config PPC_EARLY_DEBUG_44x_PHYSHIGH
-	hex
+	hex "ERPN of UART address"
 	depends PPC_EARLY_DEBUG_44x
 	default "0x1"
 
