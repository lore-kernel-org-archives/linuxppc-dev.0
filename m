Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4FA6A2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 01:49:15 +1100 (EST)
Date: Fri, 22 Mar 2013 15:46:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130322144640.GA17286@redhat.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320154152.GA8246@in.ibm.com>
 <20130320160644.GA20352@redhat.com> <20130321071545.GA5271@in.ibm.com>
 <20130321155809.GA20865@redhat.com> <20130322044747.GB26183@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322044747.GB26183@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22, Ananth N Mavinakayanahalli wrote:
>
> On Thu, Mar 21, 2013 at 04:58:09PM +0100, Oleg Nesterov wrote:
> >
> > 	- verify_opcode()->is_swbp_insn() means:
> >
> > 		is this insn fine for uprobe? (we do not care about
> > 		gdb, we simply ignore this problem)
>
> I will write up a patch for this case.. So, IIUC we do not care to send
> gdb a SIGTRAP if we have replaced a conditional trap from gdb with an
> unconditional uprobes one, right?

Yes.

And just in case, we do not send SIGTRAP if gdb used the same/unconditional
insn. We simply can't know if someone else wants to know that the task hits
this breakpoint.

Oleg.
