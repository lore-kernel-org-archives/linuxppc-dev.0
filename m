Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhKqD3hgZzDqrG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 09:23:20 +1100 (AEDT)
Message-ID: <1511302971.2466.26.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Nov 2017 09:22:51 +1100
In-Reply-To: <alpine.LRH.2.21.1711211821320.8798@math.ut.ee>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
 <alpine.LRH.2.21.1711211821320.8798@math.ut.ee>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-21 at 19:28 +0200, Meelis Roos wrote:
> For wider powerpc audience: this warning-like INFO bit is present 
> independently of theis patch. Is it dangerous for some configuration?
> 
> INFO: Uncompressed kernel (size 0x5d6c54) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x600000)

Mostly means you need more memory than the old default... I don't think
it's an issue unless you are hitting very small systems or your OF
implementation has that memory occupied.

Ben.
