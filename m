Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgnST22w8zDslj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 08:03:53 +1000 (AEST)
Message-ID: <57E5A15A.7090001@iogearbox.net>
Date: Fri, 23 Sep 2016 23:40:42 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
CC: Alexei Starovoitov <ast@fb.com>, "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 3/3] bpf powerpc: add support for bpf constant blinding
References: <40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <0ecead168c80b1c3d8a8101595e689ff7c7a735f.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <0ecead168c80b1c3d8a8101595e689ff7c7a735f.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/23/2016 10:35 PM, Naveen N. Rao wrote:
> In line with similar support for other architectures by Daniel Borkmann.
>
> 'MOD Default X' from test_bpf without constant blinding:
> 84 bytes emitted from JIT compiler (pass:3, flen:7)
> d0000000058a4688 + <x>:
>     0:	nop
>     4:	nop
>     8:	std     r27,-40(r1)
>     c:	std     r28,-32(r1)
>    10:	xor     r8,r8,r8
>    14:	xor     r28,r28,r28
>    18:	mr      r27,r3
>    1c:	li      r8,66
>    20:	cmpwi   r28,0
>    24:	bne     0x0000000000000030
>    28:	li      r8,0
>    2c:	b       0x0000000000000044
>    30:	divwu   r9,r8,r28
>    34:	mullw   r9,r28,r9
>    38:	subf    r8,r9,r8
>    3c:	rotlwi  r8,r8,0
>    40:	li      r8,66
>    44:	ld      r27,-40(r1)
>    48:	ld      r28,-32(r1)
>    4c:	mr      r3,r8
>    50:	blr
>
> ... and with constant blinding:
> 140 bytes emitted from JIT compiler (pass:3, flen:11)
> d00000000bd6ab24 + <x>:
>     0:	nop
>     4:	nop
>     8:	std     r27,-40(r1)
>     c:	std     r28,-32(r1)
>    10:	xor     r8,r8,r8
>    14:	xor     r28,r28,r28
>    18:	mr      r27,r3
>    1c:	lis     r2,-22834
>    20:	ori     r2,r2,36083
>    24:	rotlwi  r2,r2,0
>    28:	xori    r2,r2,36017
>    2c:	xoris   r2,r2,42702
>    30:	rotlwi  r2,r2,0
>    34:	mr      r8,r2
>    38:	rotlwi  r8,r8,0
>    3c:	cmpwi   r28,0
>    40:	bne     0x000000000000004c
>    44:	li      r8,0
>    48:	b       0x000000000000007c
>    4c:	divwu   r9,r8,r28
>    50:	mullw   r9,r28,r9
>    54:	subf    r8,r9,r8
>    58:	rotlwi  r8,r8,0
>    5c:	lis     r2,-17137
>    60:	ori     r2,r2,39065
>    64:	rotlwi  r2,r2,0
>    68:	xori    r2,r2,39131
>    6c:	xoris   r2,r2,48399
>    70:	rotlwi  r2,r2,0
>    74:	mr      r8,r2
>    78:	rotlwi  r8,r8,0
>    7c:	ld      r27,-40(r1)
>    80:	ld      r28,-32(r1)
>    84:	mr      r3,r8
>    88:	blr
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
