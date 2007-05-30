Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7731DDF71
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 14:33:41 +1000 (EST)
Subject: Re: [RFC/PATCH 5/5] powerpc: Allow ptrace write to pt_regs trap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
In-Reply-To: <OFF7AF7C86.A40E5407-ON422572EA.00560C99-422572EA.00563CD2@de.ibm.com>
References: <OFF7AF7C86.A40E5407-ON422572EA.00560C99-422572EA.00563CD2@de.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 14:33:31 +1000
Message-Id: <1180499611.19517.222.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This doesn't look sufficient.  If you want GDB to use the save/ 
> restore style means of handling interrupted calls (like i386), 
> at the very least we also need the capability to *write* the 
> orig_gpr3 field, which is currently prohibited.  (I don't know 
> why this is case, though.) 

Ok, I found it... put_reg doesn't filter it out but the caller does.
Fixing that too.

Ben.
