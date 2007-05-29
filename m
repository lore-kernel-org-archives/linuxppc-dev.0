Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 908C3DE0A2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:41:49 +1000 (EST)
Subject: Re: [RFC/PATCH 5/5] powerpc: Allow ptrace write to pt_regs trap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
In-Reply-To: <OFF7AF7C86.A40E5407-ON422572EA.00560C99-422572EA.00563CD2@de.ibm.com>
References: <OFF7AF7C86.A40E5407-ON422572EA.00560C99-422572EA.00563CD2@de.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:41:40 +1000
Message-Id: <1180474900.19517.203.camel@localhost.localdomain>
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

On Tue, 2007-05-29 at 17:41 +0200, Ulrich Weigand wrote:
> This doesn't look sufficient.  If you want GDB to use the save/ 
> restore style means of handling interrupted calls (like i386), 
> at the very least we also need the capability to *write* the 
> orig_gpr3 field, which is currently prohibited.  (I don't know 
> why this is case, though.) 

It's not prohibited afaik ... we allow writing to everything <= MQ (39)
on 32 bits and <= CCR (38) on 64 bits and ORIG_R3 qualifies (34)

Ben.
