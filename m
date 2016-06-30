Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg8Zx6mMBzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:22:01 +1000 (AEST)
Message-ID: <1467267714.7296.6.camel@ellerman.id.au>
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, acme@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM
Date: Thu, 30 Jun 2016 16:21:54 +1000
In-Reply-To: <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-30 at 11:44 +0530, Ravi Bangoria wrote:
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 36a5825..b87eac7 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -476,6 +481,125 @@ static int ins__cmp(const void *a, const void *b)
...
> +
> +static struct ins *ins__find_powerpc(const char *name)
> +{
> +	int i;
> +	struct ins *ins;
> +	struct ins_ops *ops;
> +	static struct instructions_powerpc head;
> +	static bool list_initialized;
> +
> +	/*
> +	 * - Interested only if instruction starts with 'b'.
> +	 * - Few start with 'b', but aren't branch instructions.
> +	 * - Let's also ignore instructions involving 'ctr' and
> +	 *   'tar' since target branch addresses for those can't
> +	 *   be determined statically.
> +	 */
> +	if (name[0] != 'b'             ||
> +	    !strncmp(name, "bcd", 3)   ||
> +	    !strncmp(name, "brinc", 5) ||
> +	    !strncmp(name, "bper", 4)  ||
> +	    strstr(name, "ctr")        ||
> +	    strstr(name, "tar"))
> +		return NULL;

It would be good if 'bctr' was at least recognised as a branch, even if we
can't determine the target. They are very common.

It doesn't look like we have the opcode handy here? Could we get it somehow?
That would make this a *lot* more robust.

cheers
