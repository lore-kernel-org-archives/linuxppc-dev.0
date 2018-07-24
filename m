Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3H03BrzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:55 +1000 (AEST)
In-Reply-To: <20180709062521.693-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: msuchanek@suse.de, anton@samba.org, npiggin@gmail.com
Subject: Re: powerpc64s: Show ori31 availability in spectre_v1 sysfs file not
 v2
Message-Id: <41Zg3F3QYtz9s3x@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-09 at 06:25:21 UTC, Michael Ellerman wrote:
> When I added the spectre_v2 information in sysfs, I included the
> availability of the ori31 speculation barrier.
> 
> Although the ori31 barrier can be used to mitigate v2, it's primarily
> intended as a spectre v1 mitigation. Spectre v2 is mitigated by
> hardware changes.
> 
> So rework the sysfs files to show the ori31 information in the
> spectre_v1 file, rather than v2.
> 
> Currently we display eg:
> 
>   $ grep . spectre_v*
>   spectre_v1:Mitigation: __user pointer sanitization
>   spectre_v2:Mitigation: Indirect branch cache disabled, ori31 speculation barrier enabled
> 
> After:
> 
>   $ grep . spectre_v*
>   spectre_v1:Mitigation: __user pointer sanitization, ori31 speculation barrier enabled
>   spectre_v2:Mitigation: Indirect branch cache disabled
> 
> Fixes: d6fbe1c55c55 ("powerpc/64s: Wire up cpu_show_spectre_v2()")
> Cc: stable@vger.kernel.org # v4.17+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/6d44acae1937b81cf8115ada8958e0

cheers
