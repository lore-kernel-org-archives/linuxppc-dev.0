Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BF5CDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:36:03 +1000 (EST)
Message-Id: <C4D0FEA7-04EF-42B3-AC3F-226C93B5DCFF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080620041352.3B70F70292@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/9] powerpc: Fix msr setting in 32 bit signal code
Date: Fri, 20 Jun 2008 01:35:50 -0500
References: <20080620041352.3B70F70292@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 19, 2008, at 11:13 PM, Michael Neuling wrote:

> If we set the SPE MSR bit in save_user_regs we can blow away the VEC
> bit.  This will never happen in reality (VMX and SPE will never be in
> the same processor as their opcodes overlap), but it looks bad.  Also
> when we add VSX here in a later patch, we can hit two of these at the
> same time.

Also, MSR_SPE and MSR_VEC are the same bit.  So we'd never clobber  
anything.

- k
