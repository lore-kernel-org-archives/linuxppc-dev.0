Return-Path: <rabin.vincent@gmail.com>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F313B1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 03:03:53 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id f206so28593075wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jan 2016 08:03:53 -0800 (PST)
Sender: Rabin Vincent <rabin.vincent@gmail.com>
Date: Tue, 5 Jan 2016 17:03:45 +0100
From: Rabin Vincent <rabin@rab.in>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, daniel@iogearbox.net,
 ast@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Message-ID: <20160105160345.GA3951@debian>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
 <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 05, 2016 at 08:00:45AM -0800, Eric Dumazet wrote:
> On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
> > The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> > instructions since it XORs A with X while all the others replace A with
> > some loaded value.  All the BPF JITs fail to clear A if this is used as
> > the first instruction in a filter.
> 
> Is x86_64 part of this 'All' subset ? ;)

No, because it's an eBPF JIT.
