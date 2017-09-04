Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlyg3323JzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 15:13:35 +1000 (AEST)
Date: Mon, 4 Sep 2017 15:13:30 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix kernel crash in emulation of vector loads
 and stores
Message-ID: <20170904151330.7204e5fb@kryten>
In-Reply-To: <20170904035900.GA16532@fergus.ozlabs.ibm.com>
References: <20170904035900.GA16532@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

> Commit 350779a29f11 ("powerpc: Handle most loads and stores in
> instruction emulation code", 2017-08-30) changed the register usage
> in get_vr and put_vr with the aim of leaving the register number in
> r3 untouched on return.  Unfortunately, r6 was not a good choice, as
> the callers as of 350779a29f11 store a MSR value in r6.  Then, in
> commit c22435a5f3d8 ("powerpc: Emulate FP/vector/VSX loads/stores
> correctly when regs not live", 2017-08-30), the saving and restoring
> of the MSR got moved into get_vr and put_vr.  Either way, the effect
> is that we put a value in MSR that only has the 0x3f8 bits non-zero,
> meaning that we are switching to 32-bit mode.  That leads to a crash
> like this:

Thanks! This fixed the issues I was seeing:

Tested-by: Anton Blanchard <anton@samba.org>

Anton
