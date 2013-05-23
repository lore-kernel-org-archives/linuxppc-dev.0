Return-Path: <eranian@google.com>
Received: from mail-oa0-f54.google.com (mail-oa0-f54.google.com
 [209.85.219.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6A952C0090
 for <linuxppc-dev@ozlabs.org>; Thu, 23 May 2013 23:36:36 +1000 (EST)
Received: by mail-oa0-f54.google.com with SMTP id o17so4370078oag.27
 for <linuxppc-dev@ozlabs.org>; Thu, 23 May 2013 06:36:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369203761-12649-2-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369203761-12649-2-git-send-email-khandual@linux.vnet.ibm.com>
Date: Thu, 23 May 2013 15:36:32 +0200
Message-ID: <CABPqkBQqH7vz9Qgom=heL6N3JniFeZKciGbQfR0PjuK-NVA0-A@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf: New conditional branch filter criteria in
 branch stack sampling
From: Stephane Eranian <eranian@google.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 8:22 AM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> POWER8 PMU based BHRB supports filtering for conditional branches.
> This patch introduces new branch filter PERF_SAMPLE_BRANCH_COND which
> will extend the existing perf ABI. Other architectures can provide
> this functionality with either HW filtering support (if present) or
> with SW filtering of instructions.
>
Reviewed-by: Stephane Eranian <eranian@google.com>

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/perf_event.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index fb104e5..cb0de86 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -157,8 +157,9 @@ enum perf_branch_sample_type {
>         PERF_SAMPLE_BRANCH_ANY_CALL     = 1U << 4, /* any call branch */
>         PERF_SAMPLE_BRANCH_ANY_RETURN   = 1U << 5, /* any return branch */
>         PERF_SAMPLE_BRANCH_IND_CALL     = 1U << 6, /* indirect calls */
> +       PERF_SAMPLE_BRANCH_COND         = 1U << 7, /* conditional branches */
>
> -       PERF_SAMPLE_BRANCH_MAX          = 1U << 7, /* non-ABI */
> +       PERF_SAMPLE_BRANCH_MAX          = 1U << 8, /* non-ABI */
>  };
>
>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
> --
> 1.7.11.7
>
