Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYh2K3M87zDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 16:39:05 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 1so8134952pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 21:39:05 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 2 Mar 2017 16:38:57 +1100
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/perf: Add PROBENOP macro for debug
Message-ID: <20170302053857.GB7613@balbir.ozlabs.ibm.com>
References: <1487447914-7094-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487447914-7094-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 19, 2017 at 01:28:34AM +0530, Madhavan Srinivasan wrote:
> From PowerISA v2.07, architecture provides a special NOP
> instruction called "Probe-Nop" defined as "and 0,0,0".
> This form of "and" is reserved for use exclusively by the
> Performance Monitor.
> 
> Usage example:
> 
> Add PROBENOP() macro to __tlbie() in hash_native_64.c to
> verify the number of TLBIE. Power8 provides "PM_TLBIE_FIN"
> PMU event (r30058) to count "tlbie finished".
> 
> Power8 PMU event "PM_PROBE_NOP_DISP" (r40014) counts the
> "ProbeNops dispatched".
> 
> With modified kernel booted, output from perf:
> 
> # ./perf stat -e r30058,r40014 ls
> ....
>  Performance counter stats for 'ls':
> 
>                  7      r30058
>                  7      r40014
> 
>        0.003296959 seconds time elapsed
> 
> Macro comes handy when want to count specific instructions
> which may or may not have a PMU event.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
