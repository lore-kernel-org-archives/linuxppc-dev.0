Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65062B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 02:34:21 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 6 Jun 2012 10:34:19 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 17E1A19D8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 16:34:11 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q56GXxsG085332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 10:34:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56GXsxA001953
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 10:33:55 -0600
Date: Wed, 6 Jun 2012 22:00:50 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120606163050.GB32094@linux.vnet.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606150848.GA24641@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120606150848.GA24641@redhat.com>
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Oleg Nesterov <oleg@redhat.com> [2012-06-06 17:08:48]:

> On 06/06, Ananth N Mavinakayanahalli wrote:
> >
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> >
> > On RISC architectures like powerpc, instructions are fixed size.
> > Instruction analysis on such platforms is just a matter of (insn % 4).
> > Pass the vaddr at which the uprobe is to be inserted so that
> > arch_uprobe_analyze_insn() can flag misaligned registration requests.
> 
> And the next patch checks "vaddr & 0x03".
> 
> But why do you need this new arg? arch_uprobe_analyze_insn() could
> check "container_of(auprobe, struct uprobe, arch)->offset & 0x3" with
> the same effect, no? vm_start/vm_pgoff are obviously page-aligned.
> 

We cant use container_of because we moved the definition for struct
uprobe to kernel/events/uprobe.c. This was possible before when struct
uprobe definition was in include/uprobes.h 

-- 
Thanks and Regards
Srikar
