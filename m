Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 485631A115C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 03:00:49 +1100 (AEDT)
Received: by mail-pa0-x22b.google.com with SMTP id ho8so779462pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jan 2016 08:00:49 -0800 (PST)
Message-ID: <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Rabin Vincent <rabin@rab.in>
Cc: davem@davemloft.net, netdev@vger.kernel.org, daniel@iogearbox.net,
 ast@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org,  linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 05 Jan 2016 08:00:45 -0800
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
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

On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.

Is x86_64 part of this 'All' subset ? ;)

>   This was found using american fuzzy
> lop.
> 
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
> 
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
