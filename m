Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8FFD42C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 20:06:58 +1000 (EST)
Message-ID: <1345716378.29170.4.camel@pasglop>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Thu, 23 Aug 2012 20:06:18 +1000
In-Reply-To: <20120823053234.GE25338@linux.vnet.ibm.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com> <1345696100.3338.21.camel@concordia>
 <20120823053234.GE25338@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-23 at 11:02 +0530, Srikar Dronamraju wrote:
> > 
> 
> insn is updated/accessed in the arch independent code. Size of
> uprobe_opcode_t could be different for different archs.
> uprobe_opcode_t
> represents the size of the smallest breakpoint instruction for an
> arch.
> 
> Hence u8 works out the best. I know we could still use uprobe_opcode_t
> and achieve the same. In which case, we would have to interpret
> MAX_UINSN_BYTES differently. Do you see any advantages of using
> uprobe_opcode_t instead of u8 across archs?

But don't you actively rely on the fact that on powerpc, unlike x86, you
-can- atomically replace an instruction with a single 32-bit store ?

If you don't you should consider it, and that makes defining this as a
u8 array non-sensical (as is using memcpy)

Ben.
