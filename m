Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F04F67B27
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 15:26:25 +1000 (EST)
Subject: Re: Collecting hypervisor call stats
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <20060531225813.GC7909@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<17534.7026.169023.420733@cargo.ozlabs.ibm.com>
	<20060531225813.GC7909@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 15:26:16 +1000
Message-Id: <1149139576.28307.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-31 at 15:58 -0700, Mike Kravetz wrote:
> On Thu, Jun 01, 2006 at 08:40:50AM +1000, Paul Mackerras wrote:
> > I think that gathering those statistics would be useful.  I suggest
> > you use a per-cpu array for them, to reduce the performance impact.
> 
> Yes, that is a must do.
> 
> We need to get a timestamp before and after the call.  mftb should do
> the trick.  Also, I'd prefer to have the code that stuffs the values
> into the array be C.  So, the decision is to have the assembly code
> call out to the C routine -OR- create wrappers for the assembly routines.
> I much prefer C wrappers to touching the assembly.

Argh... yet another use of mftb for which I'll need a cell specific
workaround :(

Ben.
