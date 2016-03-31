Return-Path: <prvs=3898f00e9f=ast@fb.com>
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbXLs348dzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 04:58:45 +1100 (AEDT)
Subject: Re: [PATCH 2/4] samples/bpf: Use llc in PATH, rather than a hardcoded
 value
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <ba23d688b3550c3f22dd0dd6d5cb1233c2f34816.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
CC: "David S . Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FD627D.5080405@fb.com>
Date: Thu, 31 Mar 2016 10:46:37 -0700
MIME-Version: 1.0
In-Reply-To: <ba23d688b3550c3f22dd0dd6d5cb1233c2f34816.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/31/16 4:25 AM, Naveen N. Rao wrote:
> While at it, fix some typos in the comment.
>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   samples/bpf/Makefile | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 502c9fc..88bc5a0 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -76,16 +76,13 @@ HOSTLOADLIBES_offwaketime += -lelf
>   HOSTLOADLIBES_spintest += -lelf
>   HOSTLOADLIBES_map_perf_test += -lelf -lrt
>
> -# point this to your LLVM backend with bpf support
> -LLC=$(srctree)/tools/bpf/llvm/bld/Debug+Asserts/bin/llc
> -
> -# asm/sysreg.h inline assmbly used by it is incompatible with llvm.
> -# But, ehere is not easy way to fix it, so just exclude it since it is
> +# asm/sysreg.h - inline assembly used by it is incompatible with llvm.
> +# But, there is no easy way to fix it, so just exclude it since it is
>   # useless for BPF samples.
>   $(obj)/%.o: $(src)/%.c
>   	clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
>   		-D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
> -		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
> +		-O2 -emit-llvm -c $< -o -| llc -march=bpf -filetype=obj -o $@
>   	clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
>   		-D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
> -		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=asm -o $@.s
> +		-O2 -emit-llvm -c $< -o -| llc -march=bpf -filetype=asm -o $@.s

that was a workaround when clang/llvm didn't have bpf support.
Now clang 3.7 and 3.8 have bpf built-in, so make sense to remove
manual calls to llc completely.
Just use 'clang -target bpf -O2 -D... -c $< -o $@'
