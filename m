Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJPgf4tN7zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 23:07:42 +1100 (AEDT)
Date: Fri, 20 Oct 2017 14:07:39 +0200
From: Torsten Duwe <duwe@lst.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171020120739.GA20306@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 11:47:35AM +0530, Kamalesh Babulal wrote:
> 
> Consider a trivial patch, supplied to kpatch tool for generating a
> livepatch module:
> 
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -132,7 +132,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>         seq_printf(m, "VmallocTotal:   %8lu kB\n",
>                    (unsigned long)VMALLOC_TOTAL >> 10);
>         show_val_kb(m, "VmallocUsed:    ", 0ul);
> -       show_val_kb(m, "VmallocChunk:   ", 0ul);
> +       show_val_kb(m, "VMALLOCCHUNK:   ", 0ul);
> 

Am I assuming correctly that "kpatch tool" simply recompiles all code the
way it would get compiled in a regular kernel build? My understanding is
that live patching modules need to be carefully prepared, which involves
source code reorganisation and recompilation. In that process, you can
easily declare show_val_kb() extern, and get the suitable instruction sequence
for the call.

You have CC'ed live-patching. A discussion about how to automate this very
process is currently going on there. May I suggest you subscribe to that if
you are interested.

	Torsten
