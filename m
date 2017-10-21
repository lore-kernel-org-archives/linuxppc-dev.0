Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJkny1t8SzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 11:59:18 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id m18so7845968pgd.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 17:59:18 -0700 (PDT)
Message-ID: <1508547548.5662.2.camel@gmail.com>
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
From: Balbir Singh <bsingharora@gmail.com>
To: Torsten Duwe <duwe@lst.de>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Naveen N . Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jessica Yu <jeyu@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,  live-patching@vger.kernel.org
Date: Sat, 21 Oct 2017 11:59:08 +1100
In-Reply-To: <20171020120739.GA20306@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-10-20 at 14:07 +0200, Torsten Duwe wrote:
> On Wed, Oct 18, 2017 at 11:47:35AM +0530, Kamalesh Babulal wrote:
> > 
> > Consider a trivial patch, supplied to kpatch tool for generating a
> > livepatch module:
> > 
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -132,7 +132,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >         seq_printf(m, "VmallocTotal:   %8lu kB\n",
> >                    (unsigned long)VMALLOC_TOTAL >> 10);
> >         show_val_kb(m, "VmallocUsed:    ", 0ul);
> > -       show_val_kb(m, "VmallocChunk:   ", 0ul);
> > +       show_val_kb(m, "VMALLOCCHUNK:   ", 0ul);
> > 
> 
> Am I assuming correctly that "kpatch tool" simply recompiles all code the
> way it would get compiled in a regular kernel build?

kpatch is open source and is available on github. This patch is specific
to the way kpatch works

> My understanding is
> that live patching modules need to be carefully prepared, which involves
> source code reorganisation and recompilation. In that process, you can
> easily declare show_val_kb() extern, and get the suitable instruction sequence
> for the call.

Yes, we agree. For the current versions of kpatch, which involve a process of
applying the patch and building the kernel without and with the patch and doing
an elf diff (programatically), we cannot deviate from that process as it's
architecture independent. This patch solves arch specific issues related
to that process.


> 
> You have CC'ed live-patching. A discussion about how to automate this very
> process is currently going on there. May I suggest you subscribe to that if
> you are interested.

We are interested, can you point us to the archives. While we do follow that
thread, this patch is independent of future changes and enables kpatch
today and enables certain workflows

> 
> 	Torsten
> 

Thanks for your review
Balbir Singh.
