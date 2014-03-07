Return-Path: <nyushchenko@dev.rtsoft.ru>
Received: from dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by ozlabs.org (Postfix) with ESMTP id 4B3D22C0357
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 16:05:31 +1100 (EST)
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] kexec/powerpc: fix exporting memory limit
Date: Fri, 7 Mar 2014 08:38:05 +0400
References: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <1394153258.21206.1.camel@concordia>
In-Reply-To: <1394153258.21206.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201403070838.07820@blacky.localdomain>
Cc: yadviga@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Thu, 2014-03-06 at 18:24 +0400, Nikita Yushchenko wrote:
> > When preparing dump-capturing kernel, kexec userspace tool needs to
> > know actual amount of memory used by the running kernel. This may
> > differ from extire available DRAM for a couple of reasons. To address
> > this issue, kdump kernel support code injects several attributes into
> > device tree that are later captured by userspace kexec tool via /proc
> > interface.
> >
> > One such attrubute is 'chosen/linux,memory_limit' that is used to pass
> > memory limit of the running kernel.
> >
> > This was initialized using kernel's 'memory_limit' variable, that is
> > set by early init code based on mem= kernel parameter and other
> > reasons.
> >
> > But there are cases when memory_limit variable does not contain proper
> > information. One such case is when !CONFIG_HIGHMEM kernel runs on
> > system with memory large enough not to fit into lowmem.
>
> Why doesn't the !CONFIG_HIGHMEM code update memory_limit to reflect
> reality.

I guess because memory_limit is used for ... well, memory limit, set by 
mem=. And for the rest memblock is used (and it *is* updated).

And code elsewhere does use memblock, see e.g. numa_enforce_memory_limit() 
in arch/powerpc/mm/numa.c

In MMU init (MMU_init() in arch/powerpc/mm/init_32.c -which is the point 
where final memory configuration is set) memblock, not memory_limit, is 
both used and updated.
