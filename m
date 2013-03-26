Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F4402C0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 23:11:48 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 26 Mar 2013 06:11:43 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D2695C9001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 08:11:40 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2QCBeNw65667168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 08:11:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2QCBdaq013557
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 09:11:39 -0300
Date: Tue, 26 Mar 2013 17:36:44 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 3/4] uprobes/powerpc: teach uprobes to ignore gdb
 breakpoints
Message-ID: <20130326120644.GC20399@linux.vnet.ibm.com>
References: <20130322151627.GB20010@in.ibm.com>
 <20130322151838.GD20010@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130322151838.GD20010@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Ananth N Mavinakayanahalli <ananth@in.ibm.com> [2013-03-22 20:48:38]:

> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Powerpc has many trap variants that could be used by entities like gdb.
> Currently, running gdb on a program being traced by uprobes causes an
> endless loop since uprobes doesn't understand that the trap was inserted
> by some other entity and a SIGTRAP needs to be delivered.
> 
> Teach uprobes to ignore breakpoints that do not belong to it.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/uprobes.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
> ===================================================================
> --- linux-3.9-rc3.orig/arch/powerpc/kernel/uprobes.c
> +++ linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
> @@ -31,6 +31,16 @@
>  #define UPROBE_TRAP_NR	UINT_MAX
> 
>  /**
> + * is_trap_insn - check if the instruction is a trap variant
> + * @insn: instruction to be checked.
> + * Returns true if @insn is a trap variant.
> + */
> +bool is_trap_insn(uprobe_opcode_t *insn)
> +{
> +	return (is_trap(*insn));
> +}
> +
> +/**
>   * arch_uprobe_analyze_insn
>   * @mm: the probed address space.
>   * @arch_uprobe: the probepoint information.

-- 
Thanks and Regards
Srikar Dronamraju
