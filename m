Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 612822C008C
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2013 11:57:30 +1100 (EST)
Message-ID: <1360803442.29312.14.camel@smoke>
Subject: Re: [PATCH] powerpc: Apply early paca fixups to boot_paca and the
 boot cpu's paca
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Feb 2013 16:57:22 -0800
In-Reply-To: <1360716290-15985-1-git-send-email-michael@ellerman.id.au>
References: <1360716290-15985-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: phileas-fogg@mail.ru, linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-02-13 at 11:44 +1100, Michael Ellerman wrote:
> In commit 466921c we added a hack to set the paca data_offset to zero so
> that per-cpu accesses would work on the boot cpu prior to per-cpu areas
> being setup. This fixed a problem with lockdep touching per-cpu areas
> very early in boot.
> 
> However if we combine CONFIG_LOCK_STAT=y with any of the PPC_EARLY_DEBUG
> options, we can hit the same problem in udbg_early_init(). To avoid that
> we need to set the data_offset of the boot_paca also. So factor out the
> fixup logic and call it for both the boot_paca, and "the paca of the
> boot cpu".
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Tested-by: Geoff Levand <geoff@infradead.org>

This fixes a boot hang on the PS3 with ps3_defconfig builds of
linux-3.7.

Please consider applying for linux-3.7.x stable.

-Geoff
