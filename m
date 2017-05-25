Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYKqp6FmczDqgk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 16:59:02 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id n23so37285677pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 23:59:02 -0700 (PDT)
Date: Thu, 25 May 2017 16:57:33 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 christophe.leroy@c-s.fr, paulus@samba.org, rashmica.g@gmail.com
Subject: Re: [PATCH v1 0/8] Enable STRICT_KERNEL_RWX
Message-ID: <20170525165733.36b50bbb@firefly.ozlabs.ibm.com>
In-Reply-To: <20170525033650.10891-1-bsingharora@gmail.com>
References: <20170525033650.10891-1-bsingharora@gmail.com>
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

On Thu, 25 May 2017 13:36:42 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> Enable STRICT_KERNEL_RWX for PPC64/BOOK3S
> 
> These patches enable RX mappings of kernel text.
> rodata is mapped RX as well as a trade-off, there
> are more details in the patch description
> 
> As a prerequisite for R/O text, patch_instruction
> is moved over to using a separate mapping that
> allows write to kernel text. xmon/ftrace/kprobes
> have been moved over to work with patch_instruction
> 

I think optprobes needs to be moved over as well.
I did not realize we have the optprobe_trampoline in
text (yikes!!)

> There are a few bug fixes, the updatepp and updateboltedpp
> did not use flags as described in PAPR and the ptdump
> utility ignored the first PFN
> 

Radix support is going to be incrementally added. I would
request a review of whats there. May be the bug fixes for
lpar.c and dump hash page tables can go in indepedently
along with the basic cleanup of kprobes.

Balbir Singh.
