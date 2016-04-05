Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qffBN0FZqzDq6Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 05:32:10 +1000 (AEST)
Message-ID: <570412B0.9000203@iogearbox.net>
Date: Tue, 05 Apr 2016 21:32:00 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
CC: Alexei Starovoitov <ast@fb.com>, "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH net 1/4] lib/test_bpf: Fix JMP_JSET tests
References: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/2016 12:02 PM, Naveen N. Rao wrote:
> JMP_JSET tests incorrectly used BPF_JNE. Fix the same.
>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

> ---
>   lib/test_bpf.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index 27a7a26..e76fa4d 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -4303,7 +4303,7 @@ static struct bpf_test tests[] = {
>   		.u.insns_int = {
>   			BPF_ALU32_IMM(BPF_MOV, R0, 0),
>   			BPF_LD_IMM64(R1, 3),
> -			BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
> +			BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
>   			BPF_EXIT_INSN(),
>   			BPF_ALU32_IMM(BPF_MOV, R0, 1),
>   			BPF_EXIT_INSN(),
> @@ -4317,7 +4317,7 @@ static struct bpf_test tests[] = {
>   		.u.insns_int = {
>   			BPF_ALU32_IMM(BPF_MOV, R0, 0),
>   			BPF_LD_IMM64(R1, 3),
> -			BPF_JMP_IMM(BPF_JNE, R1, 0xffffffff, 1),
> +			BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
>   			BPF_EXIT_INSN(),
>   			BPF_ALU32_IMM(BPF_MOV, R0, 1),
>   			BPF_EXIT_INSN(),
> @@ -4474,7 +4474,7 @@ static struct bpf_test tests[] = {
>   			BPF_ALU32_IMM(BPF_MOV, R0, 0),
>   			BPF_LD_IMM64(R1, 3),
>   			BPF_LD_IMM64(R2, 2),
> -			BPF_JMP_REG(BPF_JNE, R1, R2, 1),
> +			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
>   			BPF_EXIT_INSN(),
>   			BPF_ALU32_IMM(BPF_MOV, R0, 1),
>   			BPF_EXIT_INSN(),
> @@ -4489,7 +4489,7 @@ static struct bpf_test tests[] = {
>   			BPF_ALU32_IMM(BPF_MOV, R0, 0),
>   			BPF_LD_IMM64(R1, 3),
>   			BPF_LD_IMM64(R2, 0xffffffff),
> -			BPF_JMP_REG(BPF_JNE, R1, R2, 1),
> +			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
>   			BPF_EXIT_INSN(),
>   			BPF_ALU32_IMM(BPF_MOV, R0, 1),
>   			BPF_EXIT_INSN(),
>
