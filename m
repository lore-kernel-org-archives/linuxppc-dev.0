Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F246DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 11:04:40 +1000 (EST)
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1186013135.5495.540.camel@localhost.localdomain>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186007636.5495.536.camel@localhost.localdomain>
	<1491.1186011132@neuling.org>
	<1186013135.5495.540.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 11:04:28 +1000
Message-Id: <1186016669.5495.544.camel@localhost.localdomain>
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


> The first block of code detects the need for a demotion and changes the
> global mmu_vmalloc_psize, along with changing the value on the local CPU
> (and flushing it's SLB). But other CPUs still have the old values.
> 
> The second block of code checks if the global value matches the per-CPU
> value and if not, proceeds to a local SLB flush. That's how the "other"
> CPUs get the new value.
> 
> If your shadow is per-CPU, it thus needs to be updated in both cases.

Hrm.. I must have been looking at older sources or lacked caffeine, we
indeed only do the paca update and the flush&rebolt once.

Ben.
