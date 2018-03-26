Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408wMx0pmTzF22X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 00:43:40 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id g5so8437762qth.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:43:40 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <2d2a744a-57b2-ca42-db40-4705df0375db@codeaurora.org>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
 <2d2a744a-57b2-ca42-db40-4705df0375db@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 15:43:37 +0200
Message-ID: <CAK8P3a2tumcR7mcE3++cofhF-FHzgZg_1OF+GXCZuwGckMOF1Q@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Oliver <oohall@gmail.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2018 at 2:58 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/21/2018 8:53 AM, Sinan Kaya wrote:
>> BTW, I have no idea what compiler barrier does on PPC and if
>>
>> wrltel() == compiler barrier() + wrltel_relaxed()
>>
>> can be said.
>
> this should have been
>
> writel_relaxed() == compiler barrier() + __raw_writel()

I don't think anyone clarified this so far, but there are additional differences
between the two, writel_relaxed() assumes we are talking to a 32-bit
little-endian
MMIO register, while __raw_writel() is primarily used for writing into
memory-type
regions with no particular byte order. This means:

- writel_relaxed() must perform a byte swap when running on big-endian kernels
- when used with __packed MMIO pointers, __raw_writel() may turn into a series
  of byte writes, while writel_relaxed() must result in a single 32-bit access.
- A set if consecutive writel_relaxed() on the same device is issued in program
  order, while __raw_writel() is not ordered. This typically requires
only a compiler
  barrier, but may also need a CPU barrier (in addition to the
barriers we use to
  serialize with spinlocks and DMA in writel() but not writel_relaxed()).

        Arnd
