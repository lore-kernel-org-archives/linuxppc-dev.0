Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56976C48BC4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Feb 2024 17:17:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TbMDv5bGRz3vZp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Feb 2024 04:17:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=alexandru.elisei@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TbMDS4xhYz2ykx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2024 04:16:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 127911FB;
	Thu, 15 Feb 2024 09:16:48 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D392A3F766;
	Thu, 15 Feb 2024 09:16:04 -0800 (PST)
Date: Thu, 15 Feb 2024 17:16:01 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Subject: Re: [kvm-unit-tests PATCH v1 01/18] Makefile: Define __ASSEMBLY__
 for assembly files
Message-ID: <Zc5G0Uu1QxJ1Qt36@raptor>
References: <20231130090722.2897974-1-shahuang@redhat.com>
 <20231130090722.2897974-2-shahuang@redhat.com>
 <20240115-0c41f7d4aa09b7b82613faa8@orel>
 <Zc42ZJYMFpXpM4mD@raptor>
 <20240215-f2a2e3798b1f64923417df00@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-f2a2e3798b1f64923417df00@orel>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org, Shaoqin Huang <shahuang@redhat.com>, Nikos Nikoleris <nikos.nikoleris@arm.com>, Eric Auger <eric.auger@redhat.com>, Nadav Amit <namit@vmware.com>, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw@amazon.co.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Drew,

On Thu, Feb 15, 2024 at 05:32:22PM +0100, Andrew Jones wrote:
> On Thu, Feb 15, 2024 at 04:05:56PM +0000, Alexandru Elisei wrote:
> > Hi Drew,
> > 
> > On Mon, Jan 15, 2024 at 01:44:17PM +0100, Andrew Jones wrote:
> > > On Thu, Nov 30, 2023 at 04:07:03AM -0500, Shaoqin Huang wrote:
> > > > From: Alexandru Elisei <alexandru.elisei@arm.com>
> > > > 
> > > > There are 25 header files today (found with grep -r "#ifndef __ASSEMBLY__)
> > > > with functionality relies on the __ASSEMBLY__ prepocessor constant being
> > > > correctly defined to work correctly. So far, kvm-unit-tests has relied on
> > > > the assembly files to define the constant before including any header
> > > > files which depend on it.
> > > > 
> > > > Let's make sure that nobody gets this wrong and define it as a compiler
> > > > constant when compiling assembly files. __ASSEMBLY__ is now defined for all
> > > > .S files, even those that didn't set it explicitely before.
> > > > 
> > > > Reviewed-by: Nikos Nikoleris <nikos.nikoleris@arm.com>
> > > > Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> > > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > > Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> > > > ---
> > > >  Makefile           | 5 ++++-
> > > >  arm/cstart.S       | 1 -
> > > >  arm/cstart64.S     | 1 -
> > > >  powerpc/cstart64.S | 1 -
> > > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/Makefile b/Makefile
> > > > index 602910dd..27ed14e6 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -92,6 +92,9 @@ CFLAGS += -Woverride-init -Wmissing-prototypes -Wstrict-prototypes
> > > >  
> > > >  autodepend-flags = -MMD -MP -MF $(dir $*).$(notdir $*).d
> > > >  
> > > > +AFLAGS  = $(CFLAGS)
> > > > +AFLAGS += -D__ASSEMBLY__
> > > > +
> > > >  LDFLAGS += -nostdlib $(no_pie) -z noexecstack
> > > >  
> > > >  $(libcflat): $(cflatobjs)
> > > > @@ -113,7 +116,7 @@ directories:
> > > >  	@mkdir -p $(OBJDIRS)
> > > >  
> > > >  %.o: %.S
> > > > -	$(CC) $(CFLAGS) -c -nostdlib -o $@ $<
> > > > +	$(CC) $(AFLAGS) -c -nostdlib -o $@ $<
> > > 
> > > I think we can drop the two hunks above from this patch and just rely on
> > > the compiler to add __ASSEMBLY__ for us when compiling assembly files.
> > 
> > I think the precompiler adds __ASSEMBLER__, not __ASSEMBLY__ [1]. Am I
> > missing something?
> > 
> > [1] https://gcc.gnu.org/onlinedocs/cpp/macros/predefined-macros.html#c.__ASSEMBLER__
> 
> You're right. I'm not opposed to changing all the __ASSEMBLY__ references
> to __ASSEMBLER__. I'll try to do that at some point unless you beat me to
> it.

Actually, I quite prefer the Linux style of using __ASSEMBLY__ instead of
__ASSEMBLER__, because it makes reusing Linux files easier. That, and the
habit formed by staring at Linux assembly files.

Thanks,
Alex
