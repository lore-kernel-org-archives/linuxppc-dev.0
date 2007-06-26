Return-Path: <sagar.abhishek@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by ozlabs.org (Postfix) with ESMTP id E7A4ADDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 17:54:39 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so1492603nzb
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 00:54:37 -0700 (PDT)
Message-ID: <863e9df20706260054p664635beme3081da113844c2@mail.gmail.com>
Date: Tue, 26 Jun 2007 13:24:36 +0530
From: "Abhishek Sagar" <sagar.abhishek@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 3/3] Make jprobes a little safer for users
In-Reply-To: <1182839683.6673.22.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	<7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
	<863e9df20706252319j239eaf44wee7a46ad742c9585@mail.gmail.com>
	<1182839683.6673.22.camel@concordia.ozlabs.ibm.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/26/07, Michael Ellerman <michael@ellerman.id.au> wrote:
> It did occur to me that someone might be doing something crazy like
> branching to code that's not in the kernel/module text - but I was
> hoping that wouldn't be the case. I'm not sure what ITCM is?

The reference to tightly coupled memory (ITCM) was just to have you
consider the possibility of the jprobe handler being outside kernel
text region. Totally paranoid really.

> > >  int __kprobes register_jprobe(struct jprobe *jp)
> > >  {
> > > +       unsigned long addr = arch_deref_entry_point(jp->entry);
> > > +
> > > +       if (!kernel_text_address(addr))
> > > +               return -EINVAL;
> >
> > Seems like you're checking for the jprobe handler to be within
> > kernel/module range. Why not narrow this down to just module range
> > (!module_text_address(addr), say)? Core kernel functions would not be
> > ending with a 'jprobe_return()' anyway.
>
> There's jprobe code in net/ipv4/tcp_probe.c and net/dccp/probe.c that
> can be builtin or modular, so I think kernel_text_address() is right.

Ok..thanks for that clarification.

--
Abhishek Sagar

