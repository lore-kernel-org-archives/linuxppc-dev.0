Return-Path: <dan.j.williams@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 16B27DDDDB
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 11:42:28 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1707013wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:42:27 -0800 (PST)
Message-ID: <e9c3a7c20811141642q7608e642sd14b3021223a2d3c@mail.gmail.com>
Date: Fri, 14 Nov 2008 17:42:27 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [PATCH 01/11] async_tx: don't use src_list argument of
	async_xor() for dma addresses
In-Reply-To: <1226589364-5619-2-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1226589364-5619-1-git-send-email-yanok@emcraft.com>
	<1226589364-5619-2-git-send-email-yanok@emcraft.com>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, dzu@denx.de,
	wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2008 at 8:15 AM, Ilya Yanok <yanok@emcraft.com> wrote:
> Using src_list argument of async_xor() as a storage for dma addresses
> implies sizeof(dma_addr_t) <= sizeof(struct page *) restriction which is
> not always true.
>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---

I don't like the stack space implications of this change.  Especially
for large arrays we will be carrying two 'src_cnt' size arrays on the
stack, one from MD and one from async_tx.  However, I think the
current scheme of overwriting input parameters is pretty ugly.  So, I
want to benchmark the performance implications of adding a GFP_NOIO
allocation here, with the idea being that if the allocation fails we
can still fallback to the synchronous code path.

--
Dan
