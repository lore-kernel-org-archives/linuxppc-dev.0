Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ABFCB6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 15:58:26 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc: POWER7 optimised
	copy_to_user/copy_from_user using VMX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110617045421.700411944@samba.org>
References: <20110617045358.544896830@samba.org>
	<20110617045421.700411944@samba.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 15:58:20 +1000
Message-ID: <1308290300.32158.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-17 at 14:54 +1000, Anton Blanchard wrote:
> plain text document attachment (power7_copy_tofrom_user)
> Implement a POWER7 optimised copy_to_user/copy_from_user using VMX.
> For large aligned copies this new loop is over 10% faster, and for
> large unaligned copies it is over 200% faster.
> 
> If we take a fault we fall back to the old version, this keeps
> things relatively simple and easy to verify.

Same re-entrancy comment as the other ones. preempt & interrupts...
Except here is worse since you may page fault and thus lose the vmx
state completely.

Cheers,
Ben.
