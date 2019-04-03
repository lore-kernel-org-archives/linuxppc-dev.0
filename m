Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF6C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 01:21:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F4C20643
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 01:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F4C20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YpFR42SrzDqRW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 12:21:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YpCf4cYmzDqM7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 12:19:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44YpCT5B81z9sPS;
 Wed,  3 Apr 2019 12:19:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
In-Reply-To: <CAK8P3a14of-jJA2q7rki3gHk6gwE-0TCkzHuXZ1+TkemopgfRA@mail.gmail.com>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87y34vl6ji.fsf@concordia.ellerman.id.au>
 <CAK8P3a14of-jJA2q7rki3gHk6gwE-0TCkzHuXZ1+TkemopgfRA@mail.gmail.com>
Date: Wed, 03 Apr 2019 12:19:49 +1100
Message-ID: <87wokb28cq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Helge Deller <deller@gmx.de>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, Parisc List <linux-parisc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnd Bergmann <arnd@arndb.de> writes:
> On Sun, Mar 31, 2019 at 5:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > Add the io_uring and pidfd_send_signal system calls to all architectures.
>> >
>> > These system calls are designed to handle both native and compat tasks,
>> > so all entries are the same across architectures, only arm-compat and
>> > the generic tale still use an old format.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> >  arch/alpha/kernel/syscalls/syscall.tbl      | 4 ++++
>> >  arch/arm/tools/syscall.tbl                  | 4 ++++
>> >  arch/arm64/include/asm/unistd.h             | 2 +-
>> >  arch/arm64/include/asm/unistd32.h           | 8 ++++++++
>> >  arch/ia64/kernel/syscalls/syscall.tbl       | 4 ++++
>> >  arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++
>> >  arch/microblaze/kernel/syscalls/syscall.tbl | 4 ++++
>> >  arch/mips/kernel/syscalls/syscall_n32.tbl   | 4 ++++
>> >  arch/mips/kernel/syscalls/syscall_n64.tbl   | 4 ++++
>> >  arch/mips/kernel/syscalls/syscall_o32.tbl   | 4 ++++
>> >  arch/parisc/kernel/syscalls/syscall.tbl     | 4 ++++
>> >  arch/powerpc/kernel/syscalls/syscall.tbl    | 4 ++++
>>
>> Have you done any testing?
>>
>> I'd rather not wire up syscalls that have never been tested at all on
>> powerpc.
>
> No, I have not. I did review the system calls carefully and added the first
> patch to fix the bug on x86 compat mode before adding the same bug
> on the other compat architectures though ;-)
>
> Generally, my feeling is that adding system calls is not fundamentally
> different from adding other ABIs, and we should really do it at
> the same time across all architectures, rather than waiting for each
> maintainer to get around to reviewing and testing the new calls
> first. This is not a problem on powerpc, but a lot of other architectures
> are less active, which is how we have always ended up with
> different sets of system calls across architectures.

Well it's still something of a problem on powerpc. No one has
volunteered to test io_uring on powerpc, so at this stage it will go in
completely untested.

If there was a selftest in the tree I'd be a bit happier, because at
least then our CI would start testing it as soon as the syscalls were
wired up in linux-next.

And yeah obviously I should test it, but I don't have infinite time
unfortunately.

> The problem here is that this makes it harder for the C library to
> know when a system call is guaranteed to be available. glibc
> still needs a feature test for newly added syscalls to see if they
> are working (they might be backported to an older kernel, or
> disabled), but whenever the minimum kernel version is increased,
> it makes sense to drop those checks and assume non-optional
> system calls will work if they were part of that minimum version.

But that's the thing, if we just wire them up untested they may not
actually work. And then you have the far worse situation where the
syscall exists in kernel version x but does not actually work properly.

See the mess we have with pkeys for example.

> In the future, I'd hope that any new system calls get added
> right away on all architectures when they land (it was a bit
> tricky this time, because I still did a bunch of reworks that
> conflicted with the new calls). Bugs will happen of course, but
> I think adding them sooner makes it more likely to catch those
> bugs early on so we have a chance to fix them properly,
> and need fewer arch specific workarounds (ideally none)
> for system calls.

For syscalls that have a selftest in the tree, and don't rely on
anything arch specific I agree.

I'm a bit more wary of things that are not easily tested and have the
potential to work differently across arches.

cheers
