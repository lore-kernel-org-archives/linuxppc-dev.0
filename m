Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8jvM0tMhzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 13:50:23 +1100 (AEDT)
Date: Fri, 27 Jan 2017 13:25:42 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] KVM: PPC: Book3S: Move 64-bit KVM interrupt handler
 out from alt section
Message-ID: <20170127022542.sey7wv5mnut6b3vt@oak.ozlabs.ibm.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
 <20161221182927.24562-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161221182927.24562-3-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2016 at 04:29:26AM +1000, Nicholas Piggin wrote:
> A subsequent patch to make KVM handlers relocation-safe makes them
> unusable from within alt section "else" cases (due to the way fixed
> addresses are taken from within fixed section head code).
> 
> Stop open-coding the KVM handlers, and add them both as normal. A more
> optimal fix may be to allow some level of alternate feature patching in
> the exception macros themselves, but for now this will do.
> 
> The TRAMP_KVM handlers must be moved to the "virt" fixed section area
> (name is arbitrary) in order to be closer to .text and avoid the dreaded
> "relocation truncated to fit" error.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
