Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425J4W06JhzF3FY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 08:18:18 +1000 (AEST)
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so4191289pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 15:18:18 -0700 (PDT)
Date: Thu, 6 Sep 2018 08:18:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ley Foon Tan <lftan@altera.com>,
 nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Message-ID: <20180906081802.210984d7@roar.ozlabs.ibm.com>
In-Reply-To: <20180905142951.GA15680@roeck-us.net>
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-4-npiggin@gmail.com>
 <20180905142951.GA15680@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2018 07:29:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
>=20
> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
> > Similarly to the previous patch, this tries to optimise dirty/accessed
> > bits in ptes to avoid access costs of hardware setting them.
> >  =20
>=20
> This patch results in silent nios2 boot failures, silent meaning that
> the boot stalls.
>=20
> ...
> Unpacking initramfs...
> Freeing initrd memory: 2168K
> workingset: timestamp_bits=3D30 max_order=3D15 bucket_order=3D0
> jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
> random: fast init done
> random: crng init done
>=20
> [no further activity until the qemu session is aborted]
>=20
> Reverting the patch fixes the problem. Bisect log is attached.

Thanks for bisecting it, I'll try to reproduce. Just qemu with no
obscure options? Interesting that it's hit nios2 but apparently not
other archs (yet).

Thanks,
Nick
