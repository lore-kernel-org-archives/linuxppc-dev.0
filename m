Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35kC602DzF0Cc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:24:03 +1100 (AEDT)
In-Reply-To: <20171212120204.6799-1-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: KVM: PPC: Book3S: fix XIVE migration of pending interrupts
Message-Id: <3z35kC53mWz9s7n@ozlabs.org>
Date: Fri, 22 Dec 2017 22:24:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-12 at 12:02:04 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> When restoring a pending interrupt, we are setting the Q bit to force
> a retrigger in xive_finish_unmask(). But we also need to force an EOI
> in this case to reach the same initial state : P=1, Q=0.
> 
> This can be done by not setting 'old_p' for pending interrupts which
> will inform xive_finish_unmask() that an EOI needs to be sent.
> 
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dc1c4165d189350cb51bdd3057deb6

cheers
