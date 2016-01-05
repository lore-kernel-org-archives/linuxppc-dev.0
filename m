Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2D5A1A1178
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 04:43:16 +1100 (AEDT)
Received: by mail-pa0-x229.google.com with SMTP id uo6so199200854pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jan 2016 09:43:16 -0800 (PST)
Date: Tue, 5 Jan 2016 09:43:10 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Rabin Vincent <rabin@rab.in>, davem@davemloft.net,
 netdev@vger.kernel.org, ast@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Message-ID: <20160105174309.GA83548@ast-mbp.thefacebook.com>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
 <568BF11F.1060507@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <568BF11F.1060507@iogearbox.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 05, 2016 at 05:36:47PM +0100, Daniel Borkmann wrote:
> On 01/05/2016 04:23 PM, Rabin Vincent wrote:
> >The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> >instructions since it XORs A with X while all the others replace A with
> >some loaded value.  All the BPF JITs fail to clear A if this is used as
> >the first instruction in a filter.  This was found using american fuzzy
> >lop.
> >
> >Add a helper to determine if A needs to be cleared given the first
> >instruction in a filter, and use this in the JITs.  Except for ARM, the
> >rest have only been compile-tested.
> >
> >Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> >Signed-off-by: Rabin Vincent <rabin@rab.in>
> 
> Excellent catch, thanks a lot! The fix looks good to me and should
> go to -net tree.
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

good catch indeed.
Classic bpf jits didn't have much love. Great to see this work.

Acked-by: Alexei Starovoitov <ast@kernel.org>
