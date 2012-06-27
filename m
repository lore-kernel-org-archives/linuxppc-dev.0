Return-Path: <rientjes@google.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CE94B6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 16:16:28 +1000 (EST)
Received: by dajt11 with SMTP id t11so1058579daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2012 23:16:26 -0700 (PDT)
Date: Tue, 26 Jun 2012 23:16:24 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH 2/12] memory-hogplug : check memory offline in
 offline_pages
In-Reply-To: <4FEA9DB1.7010303@jp.fujitsu.com>
Message-ID: <alpine.DEB.2.00.1206262313440.32567@chino.kir.corp.google.com>
References: <4FEA9C88.1070800@jp.fujitsu.com> <4FEA9DB1.7010303@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jun 2012, Yasuaki Ishimatsu wrote:

> Index: linux-3.5-rc4/mm/memory_hotplug.c
> ===================================================================
> --- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-06-26 13:28:16.743211538 +0900
> +++ linux-3.5-rc4/mm/memory_hotplug.c	2012-06-26 13:48:38.264940468 +0900
> @@ -887,6 +887,11 @@ static int __ref offline_pages(unsigned
> 
>  	lock_memory_hotplug();
> 
> +	if (memory_is_offline(start_pfn, end_pfn)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
>  	zone = page_zone(pfn_to_page(start_pfn));
>  	node = zone_to_nid(zone);
>  	nr_pages = end_pfn - start_pfn;

Are there additional prerequisites for this patch?  Otherwise it changes 
the return value of offline_memory() which will now call 
acpi_memory_powerdown_device() in the acpi memhotplug case when disabling.  
Is that a problem?
