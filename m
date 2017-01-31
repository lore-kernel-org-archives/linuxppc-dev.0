Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCgd74mFmzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 09:18:19 +1100 (AEDT)
Date: Wed, 1 Feb 2017 09:18:13 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: sjitindarsingh@gmail.com, benh@kernel.crashing.org, thuth@redhat.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/11] KVM implementation of PAPR HPT resizing extension
Message-ID: <20170131221813.GA3305@fergus.ozlabs.ibm.com>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2016 at 04:48:56PM +1100, David Gibson wrote:
> Here is the KVM implementation for the proposed PAPR extension which
> allows the runtime resizing of a PAPR guest's Hashed Page Table (HPT).
> 
> Using this requires a guest kernel with support for the extension.
> Patches for guest side support in Linux were posted earlier:
>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-December/152164.html
> 
> It also requires userspace (i.e. qemu) to intercept the HPT resizing
> hypercalls and invoke the KVM ioctl()s to implement them.  This is
> done instead of having KVM direclty intercept the hypercalls, so that
> userspace can, if useful, impose additional restrictions on resizes:
> for example it could refuse them entirely if policy for the VM
> precludes resizing, or it could limit the size of HPT the guest can
> request to meet resource limits.
> 
> Patches to implement the userspace part of HPT resizing are proposed
> for qemu-2.9, and can be found at:
>   https://github.com/dgibson/qemu/tree/hpt-resize
> 
> I'm posting these now, in the hopes that both these and the
> corresponding guest side patches can be staged and merged for the 4.11
> window.

Thanks, series applied to my kvm-ppc-next branch.

Next time, please cc kvm-ppc@vger.kernel.org so I shows up in
patchwork and I don't miss it.

Paul.
