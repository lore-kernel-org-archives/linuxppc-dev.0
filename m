Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91E331A11A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 04:07:15 +1100 (AEDT)
Message-ID: <568BF11F.1060507@iogearbox.net>
Date: Tue, 05 Jan 2016 17:36:47 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Rabin Vincent <rabin@rab.in>, davem@davemloft.net
CC: netdev@vger.kernel.org, ast@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
References: <1452007387-626-1-git-send-email-rabin@rab.in>
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2016 04:23 PM, Rabin Vincent wrote:
> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.  This was found using american fuzzy
> lop.
>
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
>
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Excellent catch, thanks a lot! The fix looks good to me and should
go to -net tree.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

If you're interested, feel free to add a small test case for the
SKF_AD_ALU_XOR_X issue to lib/test_bpf.c for -net-next tree. Thanks!
