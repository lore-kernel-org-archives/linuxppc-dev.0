Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR32k0tHYzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 23:30:37 +1000 (AEST)
Date: Fri, 10 Jun 2016 10:30:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/2] perf annotate: generalize handling of ret instructions
Message-ID: <20160610133031.GA3826@kernel.org>
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Jun 10, 2016 at 06:32:50PM +0530, Naveen N. Rao escreveu:
> Introduce helper to detect ret instructions and use the same in the tui.

Humm, I think this is simpler and equivalent, since so far we didn't had
any need for special handling of "retq"/"ret" instructions:

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4fc208e82c6f..29cef599a091 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -226,11 +226,11 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 				ui_browser__write_nstring(browser, " ", 2);
 			}
 		} else {
-			if (strcmp(dl->name, "retq")) {
-				ui_browser__write_nstring(browser, " ", 2);
-			} else {
+			if (strcmp(dl->name, "retq") == 0 || strcmp(dl->name, "ret") == 0) {
 				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
 				SLsmg_write_char(' ');
+			} else {
+				ui_browser__write_nstring(browser, " ", 2);
 			}
 		}
 
 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/ui/browsers/annotate.c | 20 +++++++++-----------
>  tools/perf/util/annotate.c        | 10 ++++++++++
>  tools/perf/util/annotate.h        |  1 +
>  3 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 4fc208e..dcfaf7a 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -222,16 +222,14 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
>  			} else if (ins__is_call(dl->ins)) {
>  				ui_browser__write_graph(browser, SLSMG_RARROW_CHAR);
>  				SLsmg_write_char(' ');
> +			} else if (ins__is_ret(dl->ins)) {
> +				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
> +				SLsmg_write_char(' ');
>  			} else {
>  				ui_browser__write_nstring(browser, " ", 2);
>  			}
>  		} else {
> -			if (strcmp(dl->name, "retq")) {
> -				ui_browser__write_nstring(browser, " ", 2);
> -			} else {
> -				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
> -				SLsmg_write_char(' ');
> -			}
> +			ui_browser__write_nstring(browser, " ", 2);
>  		}
>  
>  		disasm_line__scnprintf(dl, bf, sizeof(bf), !annotate_browser__opts.use_offset);
> @@ -842,14 +840,14 @@ show_help:
>  				ui_helpline__puts("Huh? No selection. Report to linux-kernel@vger.kernel.org");
>  			else if (browser->selection->offset == -1)
>  				ui_helpline__puts("Actions are only available for assembly lines.");
> -			else if (!browser->selection->ins) {
> -				if (strcmp(browser->selection->name, "retq"))
> -					goto show_sup_ins;
> +			else if (!browser->selection->ins)
> +				goto show_sup_ins;
> +			else if (ins__is_ret(browser->selection->ins))
>  				goto out;
> -			} else if (!(annotate_browser__jump(browser) ||
> +			else if (!(annotate_browser__jump(browser) ||
>  				     annotate_browser__callq(browser, evsel, hbt))) {
>  show_sup_ins:
> -				ui_helpline__puts("Actions are only available for 'callq', 'retq' & jump instructions.");
> +				ui_helpline__puts("Actions are only available for function call/return & jump/branch instructions.");
>  			}
>  			continue;
>  		case 't':
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 7e5a1e8..e871b4e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -354,6 +354,15 @@ static struct ins_ops nop_ops = {
>  	.scnprintf = nop__scnprintf,
>  };
>  
> +static struct ins_ops ret_ops = {
> +	.scnprintf = ins__raw_scnprintf,
> +};
> +
> +bool ins__is_ret(const struct ins *ins)
> +{
> +	return ins->ops == &ret_ops;
> +}
> +
>  static struct ins instructions[] = {
>  	{ .name = "add",   .ops  = &mov_ops, },
>  	{ .name = "addl",  .ops  = &mov_ops, },
> @@ -444,6 +453,7 @@ static struct ins instructions[] = {
>  	{ .name = "xadd",  .ops  = &mov_ops, },
>  	{ .name = "xbeginl", .ops  = &jump_ops, },
>  	{ .name = "xbeginq", .ops  = &jump_ops, },
> +	{ .name = "retq",  .ops  = &ret_ops, },
>  };
>  
>  static int ins__key_cmp(const void *name, const void *insp)
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9241f8c..720a4c0 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -48,6 +48,7 @@ struct ins {
>  
>  bool ins__is_jump(const struct ins *ins);
>  bool ins__is_call(const struct ins *ins);
> +bool ins__is_ret(const struct ins *ins);
>  int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
>  
>  struct annotation;
> -- 
> 2.8.2
