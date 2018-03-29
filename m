Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bqw050d9zDqph
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 03:29:35 +1100 (AEDT)
Received: by mail-qk0-x241.google.com with SMTP id s9so6546813qke.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 09:29:35 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <29fe17e0-9978-dc43-d02c-de8fabdc66c2@codeaurora.org>
References: <CA+55aFxULkhZGhg-tTBBxBBvXbL7QV7f6zvwW7U2wHFijqGEqw@mail.gmail.com>
 <b02cc752d90c5e5ae2cc8cc4f67429a7@codeaurora.org>
 <1522249996.21446.25.camel@kernel.crashing.org>
 <20180328.115509.481837809903086401.davem@davemloft.net>
 <29fe17e0-9978-dc43-d02c-de8fabdc66c2@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Mar 2018 18:29:32 +0200
Message-ID: <CAK8P3a2qcXmPx-j6XZPGhWZ_K3=cBym8tVFzwcZMSCjVfzMs1g@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Sinan Kaya <okaya@codeaurora.org>
Cc: David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <David.Laight@aculab.com>, "Oliver O'Halloran" <oohall@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Networking <netdev@vger.kernel.org>, Linus Torvalds <linus971@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2018 at 3:56 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/28/2018 11:55 AM, David Miller wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Date: Thu, 29 Mar 2018 02:13:16 +1100
>>
>>> Let's fix all archs, it's way easier than fixing all drivers. Half of
>>> the archs are unused or dead anyway.
>>
>> Agreed.
>>
>
> I pinged most of the maintainers yesterday.
> Which arches do we care about these days?
> I have not been paying attention any other architecture besides arm64.
>
> arch            status                  detail
> ------          -------------           ------------------------------------
> alpha           question sent

I'm guessing alpha has problems

extern inline u32 readl(const volatile void __iomem *addr)
{
        u32 ret = __raw_readl(addr);
        mb();
        return ret;
}
extern inline void writel(u32 b, volatile void __iomem *addr)
{
        __raw_writel(b, addr);
        mb();
}

There is a barrier in writel /after/ the acess but not before.

> arc             question sent           ysato@users.sourceforge.jp will fix it.
> arm             no issues
> arm64           no issues
> blackfin        question sent           about to be removed
> c6x             question sent

no PCI, so it might not matter that much -- all drivers
are platform specific in the end.

> cris            question sent
> frv

cris and frv are getting removed

> h8300           question sent

no PCI

> hexagon         question sent

no PCI

> ia64            no issues               confirmed by Tony Luck
> m32r

removed

> m68k            question sent

> metag

removed

> microblaze      question sent
> mips            question sent

I'm guessing that some mips platforms have problems, but others don't.

> mn10300         question sent

removed

> nios2           question sent

no PCI

> openrisc        no issues               shorne@gmail.com says should no issues
> parisc          no issues               grantgrundler@gmail.com says most probably no problem but still looking
> powerpc         no issues
> riscv           question sent

riscv should be fine

> s390            question sent

Pretty sure this is also fine

> score           question sent

removed

> sh              question sent
> sparc           question sent

> tile            question sent

removed

> unicore32       question sent

Note the maintainer's new email address in linux-next.

> x86             no issues

> xtensa          question sent

removed.

         Arnd
