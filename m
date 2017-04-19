Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x22c.google.com (mail-io0-x22c.google.com
 [IPv6:2607:f8b0:4001:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MLb6rTPzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:51:03 +1000 (AEST)
Received: by mail-io0-x22c.google.com with SMTP id o22so21051172iod.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 05:51:03 -0700 (PDT)
Message-ID: <1492606204.7284.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
From: Balbir Singh <bsingharora@gmail.com>
To: Anton Blanchard <anton@samba.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 22:50:04 +1000
In-Reply-To: <20170419211346.5e228370@kryten>
References: <20170413070309.10497-1-bsingharora@gmail.com>
 <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
 <1492071568.8380.20.camel@gmail.com> <20170419211346.5e228370@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 21:13 +1000, Anton Blanchard wrote:
> Hi Balbir,
> 
> > > FTRACE is quite CPU consumming, shouldn't it really be on by
> > > default ?  
> > 
> > It does some work at boot to NOP out function entry points at _mcount
> > locations. Is that what you are referring to? Or the overhead of the
> > code in terms of size? Most distro kernels have tracing on by default.
> > 
> > The rest of the overhead is enablement based.
> 
> Unfortunately the overhead is somewhat high without
> CONFIG_MPROFILE_KERNEL, and enabling that option will break old
> toolchains. It would be great if we could automatically enable it based
> on the toolchain.
> 
> Even with CONFIG_MPROFILE_KERNEL enabled, we aren't noping out the
> redundant mflr at the start of each function.
>

Very good catch! I sent the enablement assuming that we want to have these
enabled to ensure we generally have these enabled in the distro kernels
and ideally want to test with these enabled and many of us turn them
on in any case. Do you see an issue with this being enabled by default?
I presume most workloads run on kernels that have them enabled these days?

CONFIG_MPROFILE_KERNEL depends on CC_USING_MPROFILE_KERNEL which is
automatically detected and is LE only.

Balbir Singh
