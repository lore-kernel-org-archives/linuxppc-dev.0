Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B772B67B6D
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 09:51:15 +1100 (EST)
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: minyard@acm.org
In-Reply-To: <20061208185902.GA14675@localdomain>
References: <20061207172259.64168f8c@localhost>
	<20061207172445.2108cf43@localhost>
	<20061208185902.GA14675@localdomain>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 09:50:36 +1100
Message-Id: <1165618236.1103.87.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> +	info->io.regsize	= resource0.end - resource0.start + 1;
> +	info->io.regspacing	= resource1.start - resource0.start;
> 
> Are you sure this is a reliable way to check the register spacing and
> register size?  Register size means "how big is a register (8, 16, 32
> bits)".  Register spacing means (how many bytes are there between
> registers.  If you had two registers that were 8 bits and 4 bytes
> apart, for instance, I don't believe the above calculations would work.

How many registers do we expect here ? Might be better to have one
resource represent the whole MMIO area, and have a separate property
that indicates the stride between 2 registers.

Ben.
