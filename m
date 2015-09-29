Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 019221A05D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 06:36:57 +1000 (AEST)
Date: Tue, 29 Sep 2015 22:36:51 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf record: Limit --intr-regs to platforms supporting
 PERF_REGS
Message-ID: <20150929203651.GA26281@krava>
References: <20150924125703.GA11857@krava.redhat.com>
 <CABPqkBSaxTm6-7x7VpwRtw6aS2qmHup_VsWK0VYFJVwZSMG10w@mail.gmail.com>
 <20150924164554.GA11493@naverao1-tp.in.ibm.com>
 <20150929053617.GA1060@naverao1-tp.in.ibm.com>
 <20150929065335.GE18363@krava.redhat.com>
 <20150929080010.GB1060@naverao1-tp.in.ibm.com>
 <20150929104711.GE27383@krava.redhat.com>
 <20150929163136.GA24723@naverao1-tp.ibm.com>
 <20150929171556.GA1856@krava.redhat.com>
 <20150929181002.GA6822@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150929181002.GA6822@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 29, 2015 at 11:10:02AM -0700, Sukadev Bhattiprolu wrote:

SNIP

>  
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 885e8ac..6b8eb13 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -6,6 +6,7 @@ const struct sample_reg __weak sample_reg_masks[] = {
>  	SMPL_REG_END
>  };
>  
> +#ifdef HAVE_PERF_REGS_SUPPORT
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
>  {
>  	int i, idx = 0;
> @@ -29,3 +30,4 @@ out:
>  	*valp = regs->cache_regs[id];
>  	return 0;
>  }
> +#endif
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 2984dcc..8dbdfeb 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -3,6 +3,10 @@
>  
>  #include <linux/types.h>
>  
> +#ifndef __maybe_unused
> +#define __maybe_unused __attribute__((unused))
> +#endif
> +

would the linux/compiler.h include do instead?

otherwise I'd be ok with this

thanks,
jirka
