Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0143.outbound.protection.outlook.com [65.55.169.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BE521A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 08:28:39 +1000 (AEST)
Message-ID: <1433888900.2477.104.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc/cache: add cache flush operation for various
 e500
From: Scott Wood <scottwood@freescale.com>
To: <Yuantian.Tang@freescale.com>
CC: <b07421@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Tang Yuantian <Yuantian.Tang@feescale.com>
Date: Tue, 9 Jun 2015 17:28:20 -0500
In-Reply-To: <1433814827-10431-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1433814827-10431-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-06-09 at 09:53 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Various e500 core have different cache architecture, so they
> need different cache flush operations. Therefore, add a callback
> function cpu_flush_caches to the struct cpu_spec. The cache flush
> operation for the specific kind of e500 is selected at init time.
> The callback function will flush all caches inside the current cpu.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@feescale.com>
> ---
> v3:
>       - change all flush_caches to cpu_down_flush
>       - replace whitespace with tab
[snip]
                .cpu_setup              = __setup_cpu_e500v2,
>               .machine_check          = machine_check_e500,
>               .platform               = "ppc8548",
> +             .cpu_down_flush = cpu_down_flush_e500v2,

It's still not lined up.  I'm not a fan of the "line up all the =" 
style, as it's a pain to maintain (and can be harder to read if the "=" 
is too far to the right), but mixing the two is worse.

-Scott
