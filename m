Return-Path: <linux@sciencehorizons.net>
Received: from ns.sciencehorizons.net (ns.sciencehorizons.net [71.41.210.147])
 by lists.ozlabs.org (Postfix) with SMTP id 3rV5wX2gW6zDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:50:52 +1000 (AEST)
Date: 15 Jun 2016 08:44:09 -0400
Message-ID: <20160615124409.6985.qmail@ns.sciencehorizons.net>
From: "George Spelvin" <linux@sciencehorizons.net>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com
Subject: Re: [PATCH] tools/perf: fix the word selected in find_*_bit
Cc: acme@kernel.org, adrian.hunter@intel.com, bp@suse.de, dsahern@gmail.com,
 jolsa@redhat.com, linux@horizon.com, linux@rasmusvillemoes.dk,
 mpe@ellerman.id.au, namhyung@kernel.org, wangnan0@huawei.com,
 yury.norov@gmail.com
In-Reply-To: <1465990973-31483-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan wrote:
> +#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
> +	tmp = addr[(((nbits - 1)/BITS_PER_LONG) - (start / BITS_PER_LONG))]
> +								^ invert;
> +#else
>  	tmp = addr[start / BITS_PER_LONG] ^ invert;
> +#endif

Than you for diagnosing this problem, but I don't think the fix
is correct.

1) It's not clear that all users of _find_next_bit and for_each_set_bit()
   want this change.
2) Is your code even correct?  I'd think you'd want addr[x ^ 1].  Are you
   sure you shpuld be reversing the whole array, and not just the halves of
   each 64-bit word?
3) You've now broken the case of 32-bit big-endian kernel.

I think the proper solution is uglier than this. :-(
