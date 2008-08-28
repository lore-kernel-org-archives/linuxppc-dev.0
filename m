Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C05C5DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 16:58:27 +1000 (EST)
Subject: Re: [PATCH] powerpc: Only make kernel text pages of linear mapping
	executable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18614.18410.958014.376185@cargo.ozlabs.ibm.com>
References: <18614.18410.958014.376185@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Aug 2008 16:58:21 +1000
Message-Id: <1219906701.13162.304.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 16:38 +1000, Paul Mackerras wrote:
> Commit bc033b63bbfeb6c4b4eb0a1d083c650e4a0d2af8 ("powerpc/mm: Fix
> attribute confusion with htab_bolt_mapping()") moved the check for
> whether we should make pages of the linear mapping executable from
> htab_bolt_mapping into its callers, including htab_initialize.
> A side-effect of this is that the decision is now made once for
> each contiguous section in the LMB array rather than for each page
> individually.  This can often mean that the whole of the linear
> mapping ends up being executable.
> 
> This reverts to the previous behaviour, where individual pages are
> checked for being part of the kernel text or not, by moving the check
> back down into htab_bolt_mapping.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
