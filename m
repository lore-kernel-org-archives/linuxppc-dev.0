Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk5sD6c9ZzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 09:30:23 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id y17so3676542pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 15:30:23 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-crypto\@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "anton\@samba.org" <anton@samba.org>
Subject: RE: [PATCH 1/4] crypto: powerpc - Factor out the core CRC vpmsum
 algorithm
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFB1A81@AcuExch.aculab.com>
References: <20170315123737.20234-1-dja@axtens.net>
 <063D6719AE5E284EB5DD2968C1650D6DCFFB1A81@AcuExch.aculab.com>
Date: Thu, 16 Mar 2017 09:30:17 +1100
Message-ID: <87efxy41hi.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

> While not part of this change, the unrolled loops look as though
> they just destroy the cpu cache.
> I'd like be convinced that anything does CRC over long enough buffers
> to make it a gain at all.
>
> With modern (not that modern now) superscalar cpus you can often
> get the loop instructions 'for free'.
> Sometimes pipelining the loop is needed to get full throughput.
> Unlike the IP checksum, you don't even have to 'loop carry' the
> cpu carry flag.

Internal testing on a NVMe device with T10DIF enabled on 4k blocks
shows a 20x - 30x improvement. Without these patches, crc_t10dif_generic
uses over 60% of CPU time - with these patches CRC drops to single
digits.

I should probably have lead with that, sorry.

FWIW, the original patch showed a 3.7x gain on btrfs as well -
6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")

When Anton wrote the original code he had access to IBM's internal
tooling for looking at how instructions flow through the various stages
of the CPU, so I trust it's pretty much optimal from that point of view.

Regards,
Daniel
