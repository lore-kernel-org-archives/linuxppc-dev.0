Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id B13C72C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 20:27:15 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20121011120502.0211f1267dedf3776e4cf85b@canb.auug.org.au>
References: <20121011120502.0211f1267dedf3776e4cf85b@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, B04825@freescale.com
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Date: Thu, 11 Oct 2012 10:27:00 +0100
Message-ID: <13876.1349947620@warthog.procyon.org.uk>
Cc: Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@freescale.com>, Alexander Graf <agraf@suse.de>,
 dhowells@redhat.com, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I just removed epapr_hcalls.h from the Kbuild file as I am not sure how
> it should be broken up.  David, can you have a look at this, please?

Files should be broken up along around __KERNEL__ conditionals.  If there are
no __KERNEL__ conditionals, it is assumed that the file is entirely UAPI and
can just be moved.

The problem appears to be this commit:

	https://github.com/agraf/linux-2.6/commit/4c09029a5639c955fcf6d65205796e4f1208aed3

	From: Liu Yu <yu.liu@freescale.com>
	Subject: KVM: PPC: Add support for ePAPR idle hcall in host kernel

Just makes epapr_hcalls.h part of the userspace API in its entirety by this bit
of the patch:

	+header-y += epapr_hcalls.h

whilst not adding any __KERNEL__ guards - which is almost certainly incorrect.

At the very least, I would say that the global variable declarations need
limiting to kernel space, and thus so do the inline functions as they emit
inline assembly to jump somewhere specified by one of the global variables
(actually a code array).

So for manual splitting purposes, I would go with just moving all the #defines
prior to the __ASSEMBLY__ guard out to uapi.  Everything within the
__ASSEMBLY__ guard is KABI only by the looks of it.

David
