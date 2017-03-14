Return-Path: <luto@amacapital.net>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj3RL6RDdzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 16:37:50 +1100 (AEDT)
Received: by mail-ua0-x22d.google.com with SMTP id 72so164053656uaf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:37:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314020709.vxeglus54k76i7rn@arch-dev>
References: <CALCETrWe8uOi3m8qXUbMA4017+rxbi1C8hzZ0bwjVHmfdE4FnQ@mail.gmail.com>
 <20170314020709.vxeglus54k76i7rn@arch-dev>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 13 Mar 2017 22:37:27 -0700
Message-ID: <CALCETrXKvNWv1OtoSo_HWf5ZHSvyGS1NsuQod6Zt+tEg3MT5Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
To: Andy Lutomirski <luto@kernel.org>,
 Till Smejkal <till.smejkal@googlemail.com>,
 Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Felipe Balbi <balbi@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Benjamin LaHaise <bcrl@kvack.org>, Nadia Yvette Chambers <nyc@holomorphy.com>,
 Jeff Layton <jlayton@poochiereds.net>, "J. Bruce Fields" <bfields@fieldses.org>,
 Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, arcml <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net, linux-hexagon@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-metag@vger.kernel.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 linux-mtd@lists.infradead.org, USB list <linux-usb@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-aio@kvack.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 13, 2017 at 7:07 PM, Till Smejkal
<till.smejkal@googlemail.com> wrote:
> On Mon, 13 Mar 2017, Andy Lutomirski wrote:
>> This sounds rather complicated.  Getting TLB flushing right seems
>> tricky.  Why not just map the same thing into multiple mms?
>
> This is exactly what happens at the end. The memory region that is descri=
bed by the
> VAS segment will be mapped in the ASes that use the segment.

So why is this kernel feature better than just doing MAP_SHARED
manually in userspace?


>> Ick.  Please don't do this.  Can we please keep an mm as just an mm
>> and not make it look magically different depending on which process
>> maps it?  If you need a trampoline (which you do, of course), just
>> write a trampoline in regular user code and map it manually.
>
> Did I understand you correctly that you are proposing that the switching =
thread
> should make sure by itself that its code, stack, =E2=80=A6 memory regions=
 are properly setup
> in the new AS before/after switching into it? I think, this would make us=
ing first
> class virtual address spaces much more difficult for user applications to=
 the extend
> that I am not even sure if they can be used at all. At the moment, switch=
ing into a
> VAS is a very simple operation for an application because the kernel will=
 just simply
> do the right thing.

Yes.  I think that having the same mm_struct look different from
different tasks is problematic.  Getting it right in the arch code is
going to be nasty.  The heuristics of what to share are also tough --
why would text + data + stack or whatever you're doing be adequate?
What if you're in a thread?  What if two tasks have their stacks in
the same place?

I could imagine something like a sigaltstack() mode that lets you set
a signal up to also switch mm could be useful.
