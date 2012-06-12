Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33359B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 03:08:46 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 12 Jun 2012 13:08:40 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A662D38C98D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 13:00:13 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5CH0Bxe090008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 13:00:12 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5CGwJ96009325
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 10:58:23 -0600
Date: Tue, 12 Jun 2012 22:24:04 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120612165404.GB30555@linux.vnet.ibm.com>
References: <20120608093257.GG13409@in.ibm.com>
 <20120611161215.GA12116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120611161215.GA12116@redhat.com>
Cc: peterz@infradead.org, antonb@thinktux.localdomain,
 lkml <linux-kernel@vger.kernel.org>, Jim Keniston <jkenisto@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Well, IMHO, this is confusing.
> 
> First of all, why do we have this "addr" or even "vaddr"? It should
> not exists. We pass it to copy_insn(), but for what?? copy_insn()
> should simply use uprobe->offset, the virtual address for this
> particular mapping does not matter at all. I am going to send
> the cleanup.
> 

Yes, we can use uprobe->offset instead of vaddr/addr.

> Note also that we should move this !UPROBE_COPY_INSN from
> install_breakpoint() to somewhere near alloc_uprobe(). This code
> is called only once, it looks a bit strange to use the "random" mm
> (the first mm vma_prio_tree_foreach() finds) and its mapping to
> verify the insn. In fact this is simply not correct and should be
> fixed, note that on x86 arch_uprobe_analyze_insn() checks

The reason we "delay" the copy_insn to the first insert is because 
we have to get access to mm. For archs like x86, we want to know if the
executable is 32 bit or not (since we have a different valid set of
instructions for 32 bit and 64 bit). So in effect, if we get access to
struct file corresponding to the inode and if the inode corresponds to
32 bit executable file or 64 bit executable file during register, then
we can move it around alloc_uprobe().
