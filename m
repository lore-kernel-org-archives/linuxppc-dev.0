Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR3sT3cC7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:07:41 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5ADxXFe046650
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:07:38 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23fm51qp2k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:07:38 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 11 Jun 2016 00:07:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1FD542CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:07:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5AE78M96685018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:07:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5AE6v9H025255
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:06:58 +1000
Date: Fri, 10 Jun 2016 19:36:06 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/2] perf annotate: generalize handling of ret instructions
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160610133031.GA3826@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160610133031.GA3826@kernel.org>
Message-Id: <20160610140606.GS18654@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/10 10:30AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 10, 2016 at 06:32:50PM +0530, Naveen N. Rao escreveu:
> > Introduce helper to detect ret instructions and use the same in the tui.

Hi Arnaldo,
Thanks for the review.

> 
> Humm, I think this is simpler and equivalent, since so far we didn't had
> any need for special handling of "retq"/"ret" instructions:
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 4fc208e82c6f..29cef599a091 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -226,11 +226,11 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
>  				ui_browser__write_nstring(browser, " ", 2);
>  			}
>  		} else {
> -			if (strcmp(dl->name, "retq")) {
> -				ui_browser__write_nstring(browser, " ", 2);
> -			} else {
> +			if (strcmp(dl->name, "retq") == 0 || strcmp(dl->name, "ret") == 0) {

This won't work on powerpc since we don't have a "ret" instruction.  
Returning from a function is *usually* done through some variant of a 
branch to LR (Link Register) instruction. This logic is encoded in the 
powerpc-specific ins__find() in the next patch.

That was the motivation in introducing a helper for handling return 
instructions in the tui.

- Naveen
