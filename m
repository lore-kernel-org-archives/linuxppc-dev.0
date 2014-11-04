Return-Path: <leif.lindholm@linaro.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82C111A0315
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 06:59:21 +1100 (AEDT)
Received: by mail-wg0-f51.google.com with SMTP id l18so14276045wgh.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Nov 2014 11:59:18 -0800 (PST)
Date: Tue, 4 Nov 2014 19:59:14 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] make CONFIG_STRICT_DEVMEM a core non-debug feature
Message-ID: <20141104195914.GY22224@bivouac.eciton.net>
References: <1415121836-16241-1-git-send-email-leif.lindholm@linaro.org>
 <CAGXu5jL1BBAvoxVqFa1YHJSMCbGdLiPey-dyC15YKVPB2xGfig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5jL1BBAvoxVqFa1YHJSMCbGdLiPey-dyC15YKVPB2xGfig@mail.gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, dave.long@linaro.org, eiko.carstens@de.ibm.com,
 Arnd Bergmann <arnd@arndb.de>, cmetcalf@tilera.com,
 Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 04, 2014 at 10:43:00AM -0800, Kees Cook wrote:
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index efefd12..39f7817 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -6,6 +6,22 @@ menu "Character devices"
> >
> >  source "drivers/tty/Kconfig"
> >
> > +config STRICT_DEVMEM
> > +       bool "Reduced access to /dev/mem"
> > +       depends on HAVE_ARCH_RESTRICTED_DEVMEM
> > +       default y
> > +       help
> > +         If this option is disabled, you allow userspace (root) access to all
> > +         of memory, including kernel and userspace memory. Accidental
> > +         access to this is obviously disastrous, but specific access can
> > +         be used by people debugging the kernel.
> > +
> > +         If this option is switched on, the /dev/mem file restricts userspace
> > +         access to an architecture-specific subset of the physical address
> > +         space.
> 
> Great consolidation, thanks! I would probably expand this help text a
> bit to include some of details mentioned in the x86 portion of the
> option. For example:
> 
> 
> If this option is switched on, the /dev/mem file restricts userspace
> access to an architecture-specific subset of the physical address
> space. For example on x86, PCI space and BIOS code and data
> regions. This is sufficient for things like dosemu and non-KMS
> Xorg and all common users of /dev/mem.

I considered doing that, but didn't want to risk listing too many
details of one architecture, and too few of others.

One alternative would be to add a devmem.txt somewhere in
Documentation, listing the behaviours on different architectures (this
would also be a good place to describe restrictions on types of
mappings and suchlike). The help message could then contain a mention
of that file. Would that work for you?

I really don't have a strong opinion however, and would be happy to go
along with whatever the most people would like to see.

/
	Leif
