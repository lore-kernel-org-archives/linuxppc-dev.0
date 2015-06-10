Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0143.outbound.protection.outlook.com [207.46.100.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17C241A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 12:01:01 +1000 (AEST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhao C.H.
 <chenhui.zhao@freescale.com>, Tang Yuantian <Yuantian.Tang@feescale.com>
Subject: RE: [PATCH v3] powerpc/cache: add cache flush operation for various
 e500
Date: Wed, 10 Jun 2015 02:00:54 +0000
Message-ID: <DM2PR03MB574243DF3299029B2E67C97FABD0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1433814827-10431-1-git-send-email-Yuantian.Tang@freescale.com>,
 <1433888900.2477.104.camel@freescale.com>
In-Reply-To: <1433888900.2477.104.camel@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please see my replay inline.
________________________________________
From: Wood Scott-B07421
Sent: Wednesday, June 10, 2015 6:28 AM
To: Tang Yuantian-B29983
Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.ker=
nel.org; Zhao Chenhui-B35336; Tang Yuantian
Subject: Re: [PATCH v3] powerpc/cache: add cache flush operation for variou=
s e500

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
                .cpu_setup              =3D __setup_cpu_e500v2,
>               .machine_check          =3D machine_check_e500,
>               .platform               =3D "ppc8548",
> +             .cpu_down_flush =3D cpu_down_flush_e500v2,

It's still not lined up.  I'm not a fan of the "line up all the =3D"
style, as it's a pain to maintain (and can be harder to read if the "=3D"
is too far to the right), but mixing the two is worse.

[Yuantian]:
I need more clear about this.
The only difference here is that my function puts ONE tab before "=3D" and =
ONE white space after "=3D";=20
but the other functions in this structure use TWO tabs before "=3D".  Is th=
at what you want?

Regards,
Yuantian
=20
-Scott
