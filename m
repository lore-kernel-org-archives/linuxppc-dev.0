Return-Path: <keescook@google.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F36271A0029
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 07:02:35 +1100 (AEDT)
Received: by mail-ob0-f174.google.com with SMTP id uz6so11456654obc.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Nov 2014 12:02:33 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20141104195914.GY22224@bivouac.eciton.net>
References: <1415121836-16241-1-git-send-email-leif.lindholm@linaro.org>
 <CAGXu5jL1BBAvoxVqFa1YHJSMCbGdLiPey-dyC15YKVPB2xGfig@mail.gmail.com>
 <20141104195914.GY22224@bivouac.eciton.net>
Date: Tue, 4 Nov 2014 12:02:32 -0800
Message-ID: <CAGXu5jJnaAFMUBR50TgapRzRcvKS0j=XO7u9z6fdNouwMb=_sQ@mail.gmail.com>
Subject: Re: [RFC PATCH] make CONFIG_STRICT_DEVMEM a core non-debug feature
From: Kees Cook <keescook@chromium.org>
To: Leif Lindholm <leif.lindholm@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, dave.long@linaro.org, eiko.carstens@de.ibm.com,
 Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <cmetcalf@tilera.com>,
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

On Tue, Nov 4, 2014 at 11:59 AM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Tue, Nov 04, 2014 at 10:43:00AM -0800, Kees Cook wrote:
>> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>> > index efefd12..39f7817 100644
>> > --- a/drivers/char/Kconfig
>> > +++ b/drivers/char/Kconfig
>> > @@ -6,6 +6,22 @@ menu "Character devices"
>> >
>> >  source "drivers/tty/Kconfig"
>> >
>> > +config STRICT_DEVMEM
>> > +       bool "Reduced access to /dev/mem"
>> > +       depends on HAVE_ARCH_RESTRICTED_DEVMEM
>> > +       default y
>> > +       help
>> > +         If this option is disabled, you allow userspace (root) access to all
>> > +         of memory, including kernel and userspace memory. Accidental
>> > +         access to this is obviously disastrous, but specific access can
>> > +         be used by people debugging the kernel.
>> > +
>> > +         If this option is switched on, the /dev/mem file restricts userspace
>> > +         access to an architecture-specific subset of the physical address
>> > +         space.
>>
>> Great consolidation, thanks! I would probably expand this help text a
>> bit to include some of details mentioned in the x86 portion of the
>> option. For example:
>>
>>
>> If this option is switched on, the /dev/mem file restricts userspace
>> access to an architecture-specific subset of the physical address
>> space. For example on x86, PCI space and BIOS code and data
>> regions. This is sufficient for things like dosemu and non-KMS
>> Xorg and all common users of /dev/mem.
>
> I considered doing that, but didn't want to risk listing too many
> details of one architecture, and too few of others.

Well, the others only say "memory mapped peripherals", so that's what
I was suggesting adding the x86 language: it was the most detailed
about what that would really mean to the end-user.

> One alternative would be to add a devmem.txt somewhere in
> Documentation, listing the behaviours on different architectures (this
> would also be a good place to describe restrictions on types of
> mappings and suchlike). The help message could then contain a mention
> of that file. Would that work for you?

That's fine too, but feels like overkill to me. Just adding the x86
example to the common help text seemed like a reasonable consolidation
of the existing help texts. I just didn't want to lose detail when
dropping the x86 text.

> I really don't have a strong opinion however, and would be happy to go
> along with whatever the most people would like to see.

Either way, I'm all for the consolidation. :)

-Kees

-- 
Kees Cook
Chrome OS Security
