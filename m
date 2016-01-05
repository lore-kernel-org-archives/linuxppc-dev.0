Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49E0C1A1171
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 04:06:33 +1100 (AEDT)
Message-ID: <568BF162.7030008@iogearbox.net>
Date: Tue, 05 Jan 2016 17:37:54 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Rabin Vincent <rabin@rab.in>, Eric Dumazet <eric.dumazet@gmail.com>
CC: davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
References: <1452007387-626-1-git-send-email-rabin@rab.in>
 <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160105160345.GA3951@debian>
In-Reply-To: <20160105160345.GA3951@debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2016 05:03 PM, Rabin Vincent wrote:
> On Tue, Jan 05, 2016 at 08:00:45AM -0800, Eric Dumazet wrote:
>> On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
>>> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
>>> instructions since it XORs A with X while all the others replace A with
>>> some loaded value.  All the BPF JITs fail to clear A if this is used as
>>> the first instruction in a filter.
>>
>> Is x86_64 part of this 'All' subset ? ;)
>
> No, because it's an eBPF JIT.

Correct, filter conversion to eBPF clears it already.
