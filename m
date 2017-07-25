Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGy8t0FH3zDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 22:24:14 +1000 (AEST)
Date: Tue, 25 Jul 2017 22:24:10 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/perf: Update default sdar_mode value for power9
Message-ID: <20170725222410.2b02bdf7@kryten>
In-Reply-To: <1500960951-18017-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1500960951-18017-1-git-send-email-maddy@linux.vnet.ibm.com>
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

On Tue, 25 Jul 2017 11:05:51 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Commit 20dd4c624d251 ('powerpc/perf: Fix SDAR_MODE value for continous
> sampling on Power9') set the default sdar_mode value in
> MMCRA[SDAR_MODE] to be used as 0b01 (Update on TLB miss). And this
> value is set if sdar_mode from event is zero, or we are in continous
> sampling mode in power9 dd1.
> 
> But it is preferred to have the sdar_mode value for power9 as
> 0b10 (Update on dcache miss) for better sampling updates instead
> of 0b01 (Update on TLB miss).

Acked-by: Anton Blanchard <anton@samba.org>

Using a bandwidth test case with a 1MB footprint, I profiled cycles and
chose TLB updates of the SDAR:

# perf record -d -e r000400000000001E:u ./bw2001 1M
                      ^
                      SDAR TLB

# perf report -D | grep PERF_RECORD_SAMPLE | sed 's/.*addr: //' | sort -u | wc -l
4

I get 4 unique addresses. If I ran with dcache misses:

# perf record -d -e r000800000000001E:u ./bw2001 1M
                      ^
                      SDAR dcache miss

# perf report -D|grep PERF_RECORD_SAMPLE| sed 's/.*addr: //'|sort -u | wc -l
5217

I get 5217 unique addresses. No surprises here, but it does show why
TLB misses is the wrong event to default to - we get very little useful
information out of it.

Anton

> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/isa207-common.c | 2 +-
>  arch/powerpc/perf/isa207-common.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/isa207-common.c
> b/arch/powerpc/perf/isa207-common.c index 3f3aa9a7063a..582ed2c9bc56
> 100644 --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -99,7 +99,7 @@ static void mmcra_sdar_mode(u64 event, unsigned
> long *mmcra) else if (!cpu_has_feature(CPU_FTR_POWER9_DD1) &&
> p9_SDAR_MODE(event)) *mmcra |=  p9_SDAR_MODE(event) <<
> MMCRA_SDAR_MODE_SHIFT; else
> -			*mmcra |= MMCRA_SDAR_MODE_TLB;
> +			*mmcra |= MMCRA_SDAR_MODE_DCACHE;
>  	} else
>  		*mmcra |= MMCRA_SDAR_MODE_TLB;
>  }
> diff --git a/arch/powerpc/perf/isa207-common.h
> b/arch/powerpc/perf/isa207-common.h index 8acbe6e802c7..7a0228bf283c
> 100644 --- a/arch/powerpc/perf/isa207-common.h
> +++ b/arch/powerpc/perf/isa207-common.h
> @@ -247,6 +247,7 @@
>  #define MMCRA_SDAR_MODE_SHIFT		42
>  #define MMCRA_SDAR_MODE_TLB		(1ull <<
> MMCRA_SDAR_MODE_SHIFT) #define MMCRA_SDAR_MODE_NO_UPDATES
> ~(0x3ull << MMCRA_SDAR_MODE_SHIFT) +#define
> MMCRA_SDAR_MODE_DCACHE		(2ull << MMCRA_SDAR_MODE_SHIFT)
> #define MMCRA_IFM_SHIFT			30 #define
> MMCRA_THR_CTR_MANT_SHIFT	19 #define
> MMCRA_THR_CTR_MANT_MASK		0x7Ful
