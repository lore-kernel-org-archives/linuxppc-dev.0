Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8jvM1swGzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 13:50:23 +1100 (AEDT)
Date: Fri, 27 Jan 2017 13:50:19 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support
 for interrupts
Message-ID: <20170127025019.6ixxkr4my3scnkar@oak.ozlabs.ibm.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
 <20161221182927.24562-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161221182927.24562-4-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2016 at 04:29:27AM +1000, Nicholas Piggin wrote:
> 64-bit Book3S exception handlers must find the dynamic kernel base
> to add to the target address when branching beyond __end_interrupts,
> in order to support kernel running at non-0 physical address.
> 
> Support this in KVM by branching with CTR, similarly to regular
> interrupt handlers. The guest CTR saved in HSTATE_SCRATCH1 and
> restored after the branch.
> 
> Without this, the host kernel hangs and crashes randomly when it is
> running at a non-0 address and a KVM guest is started.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks OK to me.

I have a slight quibble about the naming of the "BRANCH_LINK_TO_KVM"
macro because neither its definition nor the place where it's used
have anything to do with KVM as far as I can see.  That needn't stop
the patch going in, though.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
