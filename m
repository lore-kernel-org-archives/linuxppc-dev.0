Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7KBb4Pq9zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:13:59 +1000 (AEST)
Date: Wed, 19 Apr 2017 21:13:46 +1000
From: Anton Blanchard <anton@samba.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
Message-ID: <20170419211346.5e228370@kryten>
In-Reply-To: <1492071568.8380.20.camel@gmail.com>
References: <20170413070309.10497-1-bsingharora@gmail.com>
 <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
 <1492071568.8380.20.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

> > FTRACE is quite CPU consumming, shouldn't it really be on by
> > default ?  
> 
> It does some work at boot to NOP out function entry points at _mcount
> locations. Is that what you are referring to? Or the overhead of the
> code in terms of size? Most distro kernels have tracing on by default.
> 
> The rest of the overhead is enablement based.

Unfortunately the overhead is somewhat high without
CONFIG_MPROFILE_KERNEL, and enabling that option will break old
toolchains. It would be great if we could automatically enable it based
on the toolchain.

Even with CONFIG_MPROFILE_KERNEL enabled, we aren't noping out the
redundant mflr at the start of each function.

Anton
