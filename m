Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CDDA82C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:46:02 +1000 (EST)
Message-ID: <1370763946.14883.24.camel@pasglop>
Subject: Re: [PATCH v2 2/2] powerpc/hibernate: PPC64 fix user threads access
 to kernel space
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Sun, 09 Jun 2013 17:45:46 +1000
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259F6D57B@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1370755352-29901-1-git-send-email-dongsheng.wang@freescale.com>
 <1370760236.3766.481.camel@pasglop>
 <ABB05CD9C9F68C46A5CEDC7F15439259F6D57B@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-09 at 07:44 +0000, Wang Dongsheng-B40534 wrote:
> So we just need set set_context() in restore_mmu_context().
> 
> void restore_mmu_context(struct mm_struct *next) {
>         set_context(next->context.id, next->pgd);
> }

We probably also want to flush the TLB, just in case the boot kernel has
left "something" there (though I wouldn't expect it to have run
userspace it's not completely impossible).

Cheers,
Ben.
