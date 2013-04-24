Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E6942C010D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 14:19:43 +1000 (EST)
Message-ID: <1366777161.2869.0.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc: Move opcode definitions from kvm/emulate.c
 to asm/ppc-opcode.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Date: Wed, 24 Apr 2013 14:19:21 +1000
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C4A4B0@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <20130423052951.GB20902@concordia>
 <412C8208B4A0464FA894C5F0C278CD5D01C4A4B0@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-23 at 06:36 +0000, Jia Hongtao-B38951 wrote:
> These definitions are firstly used by KVM defined like OP_31_XOP_TRAP.
> Two ways to extract these definitions for public use:
> 
> 1. Like this patch did. For keeping the KVM code that using these
>    definitions unchanged we do not update them to match.
> 
> 2. Move these definitions to another .h file like my last patch did:
>    http://patchwork.ozlabs.org/patch/235646/
>    You can see the comments there.

There's a better way ... but it's more work.

All opcodes are based on a primary opcode and a potential secondary
opcode. You could/should rework ppc-opcodes.h to in fact define them
all that way as well, which would "reconcile" the KVM way and the
existing stuff.

Cheers,
Ben.

> Thanks.
> -Hongtao
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
