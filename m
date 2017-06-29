Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyyY965mbzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:46:21 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id s66so12824904pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:46:21 -0700 (PDT)
Date: Thu, 29 Jun 2017 21:44:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Anton
 Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/7] powerpc/64s: Move system_call() symbol to just
 after setting MSR_EE
Message-ID: <20170629214439.38536219@roar.ozlabs.ibm.com>
In-Reply-To: <1082922913c4f3eb1927bed9ed8eaf23318408c5.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <1082922913c4f3eb1927bed9ed8eaf23318408c5.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 29 Jun 2017 16:11:07 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> It is common to get a PMU interrupt right after the mtmsr instruction that
> enables interrupts. Due to this, the stack trace profile gets needlessly split
> across system_call_common() and system_call().
> 
> Previously, system_call() symbol was at the current place to hide a few
> earlier symbols which have since been made private or removed entirely.
> 
> So, let's move system_call() slightly higher up, right after the mtmsr
> instruction that enables interrupts. Convert existing references to
> system_call to a local syscall symbol.
> 
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Ah, I didn't realize the label is actually used. Still, I like the
patch myself.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
