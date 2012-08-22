Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 1162A2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 01:59:09 +1000 (EST)
Date: Wed, 22 Aug 2012 17:55:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120822155521.GA3993@redhat.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120822082708.GB29216@in.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22, Ananth N Mavinakayanahalli wrote:
>
> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long addr)
> +{
> +	unsigned int insn;
> +
> +	if (addr & 0x03)
> +		return -EINVAL;
> +
> +	memcpy(&insn, auprobe->insn, MAX_UINSN_BYTES);
> +	if (is_trap(insn))
> +		return -ENOTSUPP;

This addresses the only concern I had, thanks.

Once again, I am in no position to review the powerpc code, but
since I made some noise before: I think the patch is fine.

Oleg.
