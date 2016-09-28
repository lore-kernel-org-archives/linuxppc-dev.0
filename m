Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skNYH56c3zDrWs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 13:32:03 +1000 (AEST)
Date: Tue, 27 Sep 2016 20:55:44 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] powerpc: Do not make the entire heap executable
Message-ID: <20160928025544.GA24199@obsidianresearch.com>
References: <20160822185105.29600-1-dvlasenk@redhat.com>
 <87d1jo7qbw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d1jo7qbw.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 11:42:11AM +1000, Michael Ellerman wrote:

> But this is not really a powerpc patch, and I'm not an ELF expert. So
> I'm not comfortable merging it via the powerpc tree. It doesn't look
> like we really have a maintainer for binfmt_elf.c, so I'm not sure who
> should be acking that part.

Thanks a bunch for looking at this Michael.

> I've added Al Viro to Cc, he maintains fs/ and might be interested.

> I've also added Andrew Morton who might be happy to put this in his
> tree, and see if anyone complains?

For those added to the CC, I would re-state my original commit message
more clearly.

My research showed that the ELF loader bug fixed in this patch is the
root cause bug fix required to implement this hunk:

> > -#define VM_DATA_DEFAULT_FLAGS32	(VM_READ | VM_WRITE | VM_EXEC | \
> > +#define VM_DATA_DEFAULT_FLAGS32 \
> > +	(((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
> > +				 VM_READ | VM_WRITE | \
> >  				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)

Eg that 32 bit powerpc currently unconditionally injects writable,
executable pages into a user space process.

This critically undermines all the W^X security work that has been
done in the tool chain and user space by the PPC community.

I would encourage people to view this as an important security patch
for 32 bit powerpc environments.

Regards,
Jason
