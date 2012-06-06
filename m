Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 6DA9EB6F77
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 01:11:14 +1000 (EST)
Date: Wed, 6 Jun 2012 17:08:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120606150848.GA24641@redhat.com>
References: <20120606091950.GB6745@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606091950.GB6745@in.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06, Ananth N Mavinakayanahalli wrote:
>
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
>
> On RISC architectures like powerpc, instructions are fixed size.
> Instruction analysis on such platforms is just a matter of (insn % 4).
> Pass the vaddr at which the uprobe is to be inserted so that
> arch_uprobe_analyze_insn() can flag misaligned registration requests.

And the next patch checks "vaddr & 0x03".

But why do you need this new arg? arch_uprobe_analyze_insn() could
check "container_of(auprobe, struct uprobe, arch)->offset & 0x3" with
the same effect, no? vm_start/vm_pgoff are obviously page-aligned.

Oleg.
