Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWRdx2DgXzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 15:13:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Widespread crashes in -next, bisected to 'mm: drop HASH_ADAPT'
In-Reply-To: <20170519164622.GA28873@roeck-us.net>
References: <20170519164622.GA28873@roeck-us.net>
Date: Mon, 22 May 2017 15:13:52 +1000
Message-ID: <87o9ulscbz.fsf@concordia.ellerman.id.au>
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

Guenter Roeck <linux@roeck-us.net> writes:

> Hi,
>
> my qemu tests of next-20170519 show the following results:
> 	total: 122 pass: 30 fail: 92
>
> I won't bother listing all of the failures; they are available at
> http://kerneltests.org/builders. I bisected one (openrisc, because
> it gives me some console output before dying). It points to
> 'mm: drop HASH_ADAPT' as the culprit. Bisect log is attached.
>
> A quick glance suggests that 64 bit kernels pass and 32 bit kernels fail.
> 32-bit x86 images fail and should provide an easy test case.

Yep, 32-bit PPC is also broken. Bisects to this commit.

cheers
