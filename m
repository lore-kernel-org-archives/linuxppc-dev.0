Return-Path: <SRS0+ab34517418a75e23403a+530+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org
	[81.187.226.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1816C67A6B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 21:11:43 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <42023D23.6020406@nortel.com>
References: <42011E77.6040906@nortel.com> <1107407613.2363.9.camel@gaston>
	<42023D23.6020406@nortel.com>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 10:11:30 +0000
Message-Id: <1107511891.18239.48.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: new binutils breaks "tlbie" instruction in kernel?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-03 at 09:02 -0600, Chris Friesen wrote:
> > Wasn't it fixed ?
> 
> Not sure what "it" you mean.  The current kernel code does not have the 
> third parm.  I'm not sure about the latest binutils, but 2.15.92.0.2 is 
> what a vendor wants to build on.

Binutils was changed in early September last year to require the extra
argument. We objected, and it was fixed again about a month later to
_not_ require the argument. If you're using 2.15.92.0.2, then apply this
patch to it:

2004-10-09  Alan Modra  <amodra@bigpond.net.au>

	* ppc-opc.c: Revert 2004-09-09 change.

--- opcodes/ppc-opc.c	7 Oct 2004 15:34:08 -0000	1.76
+++ opcodes/ppc-opc.c	9 Oct 2004 01:21:03 -0000	1.77
@@ -300,7 +300,7 @@ const struct powerpc_operand powerpc_ope
 
   /* The L field in a D or X form instruction.  */
 #define L FXM4 + 1
-  { 1, 21, 0, 0, 0 },
+  { 1, 21, 0, 0, PPC_OPERAND_OPTIONAL },
 
   /* The LEV field in a POWER SC form instruction.  */
 #define LEV L + 1


-- 
dwmw2
