Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id B3606B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 16:13:56 +1100 (EST)
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o955Dtmv016041 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:13:55 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id D93CA45DE54
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:13:54 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id B5A0145DE4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:13:54 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 9F6451DB8014
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:13:54 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 535411DB8012
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:13:54 +0900 (JST)
Date: Tue, 5 Oct 2010 14:08:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 3/9] v3 Add section count to memory_block struct
Message-Id: <20101005140835.9c80c2e7.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4CA628D0.6030508@austin.ibm.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA628D0.6030508@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 01 Oct 2010 13:30:40 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Add a section count property to the memory_block struct to track the number
> of memory sections that have been added/removed from a memory block. This
> allows us to know when the last memory section of a memory block has been
> removed so we can remove the memory block.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

a nitpick,


> Index: linux-next/include/linux/memory.h
> ===================================================================
> --- linux-next.orig/include/linux/memory.h	2010-09-29 14:56:29.000000000 -0500
> +++ linux-next/include/linux/memory.h	2010-09-30 14:13:50.000000000 -0500
> @@ -23,6 +23,8 @@
>  struct memory_block {
>  	unsigned long phys_index;
>  	unsigned long state;
> +	int section_count;

I prefer
	int section_count; /* updated under mutex */

or some for this kind of non-atomic counters. but nitpick.
