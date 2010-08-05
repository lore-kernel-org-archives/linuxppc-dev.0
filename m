Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 610711007D3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:58:09 +1000 (EST)
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o754w8bj003373 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Thu, 5 Aug 2010 13:58:08 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 07E8345DE56
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:58:08 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id DB9F145DE52
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:58:07 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id BF0DA1DB805F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:58:07 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 75F8D1DB805E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:58:07 +0900 (JST)
Date: Thu, 5 Aug 2010 13:53:14 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/9] v4  Add mutex for add/remove of memory blocks
Message-Id: <20100805135314.7229d07c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C581C26.5080007@austin.ibm.com>
References: <4C581A6D.9030908@austin.ibm.com> <4C581C26.5080007@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Dave Hansen <dave@linux.vnet.ibm.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 03 Aug 2010 08:39:50 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Add a new mutex for use in adding and removing of memory blocks.  This
> is needed to avoid any race conditions in which the same memory block could
> be added and removed at the same time.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

But a nitpick (see below)

> ---
>  drivers/base/memory.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-08-02 13:35:00.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-08-02 13:45:34.000000000 -0500
> @@ -27,6 +27,8 @@
>  #include <asm/atomic.h>
>  #include <asm/uaccess.h>
>  
> +static struct mutex mem_sysfs_mutex;
> +

For static symbol of mutex, we usually do
	static DEFINE_MUTEX(mem_sysfs_mutex);

Then, extra calls of mutex_init() is not required.
