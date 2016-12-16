Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg6HQ0HnyzDwBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 21:38:56 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBGAXwbN035252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 05:38:54 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27cax6tmux-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 05:38:54 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 16 Dec 2016 03:38:53 -0700
Subject: Re: [PATCH] perf TUI: Don't throw error for zero length symbols
To: acme@kernel.org
References: <20161121172818.161639c2@kryten>
 <1479804050-5028-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Cc: anton@samba.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, chris.ryder@arm.com,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 16:08:35 +0530
MIME-Version: 1.0
In-Reply-To: <1479804050-5028-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5853C42B.9050402@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Can you please pick this up if it looks good?

-Ravi

On Tuesday 22 November 2016 02:10 PM, Ravi Bangoria wrote:
> perf report (with TUI) exits with error when it finds a sample of zero
> length symbol(i.e. addr == sym->start == sym->end). Actually these are
> valid samples. Don't exit TUI and show report with such symbols.
>
> Link: https://lkml.org/lkml/2016/10/8/189
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/perf/util/annotate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index aeb5a44..430d039 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -593,7 +593,8 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
>
>  	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map->unmap_ip(map, addr));
>
> -	if (addr < sym->start || addr >= sym->end) {
> +	if ((addr < sym->start || addr >= sym->end) &&
> +	    (addr != sym->end || sym->start != sym->end)) {
>  		pr_debug("%s(%d): ERANGE! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 "\n",
>  		       __func__, __LINE__, sym->name, sym->start, addr, sym->end);
>  		return -ERANGE;
