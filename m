Return-Path: <hughd@google.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 101A32C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 07:32:49 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id kl14so375882pab.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 14:32:46 -0700 (PDT)
Date: Wed, 25 Sep 2013 14:32:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the akpm tree
In-Reply-To: <20130925132612.d1685bc8fb72558eef6fb09d@linux-foundation.org>
Message-ID: <alpine.LNX.2.00.1309251426150.2479@eggly.anvils>
References: <20130925110643.db5fa154bea3838ed6affa45@canb.auug.org.au>
 <20130925132612.d1685bc8fb72558eef6fb09d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 Sergei Trofimovich <slyfox@gentoo.org>, linux-next@vger.kernel.org,
 Greg KH <greg@kroah.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 25 Sep 2013, Andrew Morton wrote:
> On Wed, 25 Sep 2013 11:06:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Andrew,
> > 
> > After merging the akpm tree, linux-next builds (powerpc allmodconfig)
> > fail like this:
> 
> I can't get powerpc to build at all at present:
> 
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      arch/powerpc/kernel/asm-offsets.s
> In file included from include/linux/vtime.h:6,
>                  from include/linux/hardirq.h:7,
>                  from include/linux/memcontrol.h:24,
>                  from include/linux/swap.h:8,
>                  from include/linux/suspend.h:4,
>                  from arch/powerpc/kernel/asm-offsets.c:24:
> arch/powerpc/include/generated/asm/vtime.h:1:31: error: asm-generic/vtime.h: No such file or directory

That caught me too: include/asm-generic/vtime.h is a patch-unfriendly
0-length file in the git tree; I wonder what use it's supposed to have.

(And I'm not very keen on the growing trend for symlinks in the git tree.)

Hugh
