Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2701DDECF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:26:00 +1000 (EST)
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
In-Reply-To: <1180475149.19517.209.camel@localhost.localdomain>
References: <OF248D3BF7.F4CFDB25-ON422572EA.004A7C17-422572EA.004ACFAE@de.ibm.com>
	<1180475149.19517.209.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:24:41 +1000
Message-Id: <1180524281.19517.259.camel@localhost.localdomain>
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

On Wed, 2007-05-30 at 07:45 +1000, Benjamin Herrenschmidt wrote:
> > It looks like GDB will expect VRSAVE at offset 33*16 (length 4
> bytes) 
> > in the area returned by PTRACE_GETVRREGS, for both 32-bit and
> 64-bit 
> > applications: 
> 
> I have to check exactly what's going on there, it might be correct in
> both cases, I just remember that the code did something subtely
> different but it might result in the same thing. I'll double check
> today.

It was indeed correct in both cases, it just stupidly did direct ulong
refs on 32 bits and cast to u32 on 64 bits, which I consolidated into a
single implementation that uses u32 for vrsave so it should work fine.

Ben.
