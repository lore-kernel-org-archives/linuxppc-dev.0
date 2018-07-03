Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KV5B69qmzF1QY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 13:30:54 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id r1-v6so279303pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 20:30:54 -0700 (PDT)
Date: Tue, 3 Jul 2018 13:30:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, stewart@linux.vnet.ibm.com,
 benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH v2 1/2] powernv/cpuidle: Parse dt idle properties into
 global structure
Message-ID: <20180703133045.3ec45faf@roar.ozlabs.ibm.com>
In-Reply-To: <1530541401-19726-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1530541401-19726-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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

On Mon,  2 Jul 2018 19:53:20 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h    |  11 ++
>  arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
>  drivers/cpuidle/cpuidle-powernv.c     |  11 +-
>  3 files changed, 151 insertions(+), 87 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index e210a83eb196..574b0ce1d671 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -79,6 +79,17 @@ struct stop_sprs {
>  	u64 mmcra;
>  };
>  
> +#define PNV_IDLE_NAME_LEN    16
> +struct pnv_idle_states_t {
> +	char name[PNV_IDLE_NAME_LEN];
> +	u32 latency_ns;
> +	u32 residency_ns;
> +	u64 psscr_val;
> +	u64 psscr_mask;
> +	u32 flags;
> +	bool valid;
> +};


This is a nice looking cleanup.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
