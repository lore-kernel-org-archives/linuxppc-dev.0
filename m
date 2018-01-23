Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQxZ04XGCzDr6C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 05:25:44 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/ps3: remove an unneeded NULL check
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
References: <20180123083318.GB10091@mwanda>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <61ad7fd7-6bb6-6b29-0053-5dfc3c96469b@infradead.org>
Date: Tue, 23 Jan 2018 10:25:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180123083318.GB10091@mwanda>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dan,

On 01/23/2018 12:33 AM, Dan Carpenter wrote:
> @@ -43,7 +43,7 @@ void ps3_sys_manager_register_ops(const struct ps3_sys_manager_ops *ops)
>  {
>  	BUG_ON(!ops);
>  	BUG_ON(!ops->dev);
> -	ps3_sys_manager_ops = ops ? *ops : ps3_sys_manager_ops;
> +	ps3_sys_manager_ops = *ops;

This seems to be a left over from when I was adding the modular
system-manager support.  It doesn't really make sense if you
look at how the ps3_sys_manager_ops variable is used.

I added your patch to my ps3-queue branch.  Thanks for the
contribution.

-Geoff
