Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXrmC51p6zDvxT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:08:43 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB663cbx098418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 01:08:41 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 275pymb282-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 01:08:40 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 5 Dec 2016 23:08:40 -0700
Subject: Re: [PATCH v8 2/3] perf annotate: Support jump instruction with
 target as second operand
To: acme@kernel.org, kim.phillips@arm.com
References: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1480953407-7605-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 chris.ryder@arm.com, mhiramat@kernel.org, treeze.taeung@gmail.com,
 markus@trippelsdorf.de, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 11:38:28 +0530
MIME-Version: 1.0
In-Reply-To: <1480953407-7605-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <584655DC.5030502@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Hmm, so it's difficult to find example of this when we use debuginfo.
Because...

Jump__parse tries to look for two things 'offset' and 'target address'.

objdump with debuginfo will include offset in assembly f.e. annotate of
'smp_call_function_single' with perf.data and vmlinux I shared.

       │c00000000016d6ac:   cmpwi  cr7,r9,0                                                    ▒
       │c00000000016d6b0: ↑ bne    cr7,c00000000016d59c <.smp_call_function_single+0x8c>       ▒
       │c00000000016d6b4:   addis  r10,r2,-15                                                  ▒

objdump of same function with kcore.

       │c00000000016d6ac:   cmpwi  cr7,r9,0                                                    ▒
       │c00000000016d6b0: ↓ bne    cr7,0xc00000000016d59c                                      ▒
       │c00000000016d6b4:   addis  r10,r2,-15                                                  ▒

Annotating in first case won't show any issue because we directly get
offset. But in this case as well, we are parsing wrong target address
in ops->target.addr

While we don't have offset in second case, we use target address to
find it. And thus it shows wrong o/p something like:

       │       cmpwi  cr7,r9,0                                                                 ▒
       │     ↓ bne    3fffffffffe92afc                                                         ▒
       │       addis  r10,r2,-15                                                               ▒

BTW, we have lot of such instructions in kernel.

Thanks,
-Ravi


On Monday 05 December 2016 09:26 PM, Ravi Bangoria wrote:
> Arch like powerpc has jump instructions that includes target address
> as second operand. For example, 'bne  cr7,0xc0000000000f6154'. Add
> support for such instruction in perf annotate.
>
> objdump o/p:
>   c0000000000f6140:   ld     r9,1032(r31)
>   c0000000000f6144:   cmpdi  cr7,r9,0
>   c0000000000f6148:   bne    cr7,0xc0000000000f6154
>   c0000000000f614c:   ld     r9,2312(r30)
>   c0000000000f6150:   std    r9,1032(r31)
>   c0000000000f6154:   ld     r9,88(r31)
>
> Corresponding perf annotate o/p:
>
> Before patch:
>          ld     r9,1032(r31)
>          cmpdi  cr7,r9,0
>       v  bne    3ffffffffff09f2c
>          ld     r9,2312(r30)
>          std    r9,1032(r31)
>   74:    ld     r9,88(r31)
>
> After patch:
>          ld     r9,1032(r31)
>          cmpdi  cr7,r9,0
>       v  bne    74
>          ld     r9,2312(r30)
>          std    r9,1032(r31)
>   74:    ld     r9,88(r31)
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v8:
>   - v7: https://lkml.org/lkml/2016/9/21/436
>   - Rebase to acme/perf/core
>   - Little change in patch description.
>   - No logical changes. (Cross arch annotate patches are in. This patch
>     is for hardening annotate for powerpc.)
>
>  tools/perf/util/annotate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ea7e0de..590244e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -223,8 +223,12 @@ bool ins__is_call(const struct ins *ins)
>  static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
>  {
>  	const char *s = strchr(ops->raw, '+');
> +	const char *c = strchr(ops->raw, ',');
>
> -	ops->target.addr = strtoull(ops->raw, NULL, 16);
> +	if (c++ != NULL)
> +		ops->target.addr = strtoull(c, NULL, 16);
> +	else
> +		ops->target.addr = strtoull(ops->raw, NULL, 16);
>
>  	if (s++ != NULL)
>  		ops->target.offset = strtoull(s, NULL, 16);
