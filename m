Return-Path: <SRS0=Vxku=F5=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxNLh5PgMzF1lB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 06:02:36 +1100 (AEDT)
Date: Wed, 7 Mar 2018 14:02:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras
 <paulus@ozlabs.org>
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
Message-ID: <20180307140232.0023b8cc@vmware.local.home>
In-Reply-To: <1520447419.431mwwg71x.naveen@linux.ibm.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180307124553.312ea88c@vmware.local.home>
 <1520447419.431mwwg71x.naveen@linux.ibm.com>
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

On Thu, 08 Mar 2018 00:07:07 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Yes, that's negligible.
> Though, to be honest, I will have to introduce a 'mfmsr' for the older 
> -pg variant. I still think that the improved reliability far outweighs 
> the minor slowdown there.

In that case, can you introduce a read_mostly variable that can be
tested before calling the mfmsr. Why punish normal ftrace tracing if
kvm is not enabled or running?

Both should probably have an #ifdef CONFIG_KVM encapsulating the code.

-- Steve
