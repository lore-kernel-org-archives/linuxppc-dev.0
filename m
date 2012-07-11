Return-Path: <dave@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EE662C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 01:40:06 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dave@linux.vnet.ibm.com>;
 Wed, 11 Jul 2012 09:40:03 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id F10AFC90135
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 11:30:25 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6BFUPxD338388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 11:30:25 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6BFUOUF004412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 12:30:25 -0300
Message-ID: <4FFD9C08.2070502@linux.vnet.ibm.com>
Date: Wed, 11 Jul 2012 08:30:16 -0700
From: Dave Hansen <dave@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 3/13] memory-hotplug : unify argument of
 firmware_map_add_early/hotplug
References: <4FFAB0A2.8070304@jp.fujitsu.com> <4FFAB17F.2090209@jp.fujitsu.com>
In-Reply-To: <4FFAB17F.2090209@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2012 03:25 AM, Yasuaki Ishimatsu wrote:
> @@ -642,7 +642,7 @@ int __ref add_memory(int nid, u64 start,
>  	}
> 
>  	/* create new memmap entry */
> -	firmware_map_add_hotplug(start, start + size, "System RAM");
> +	firmware_map_add_hotplug(start, start + size - 1, "System RAM");

I know the firmware_map_*() calls use inclusive end addresses
internally, but do we really need to expose them?  Both of the callers
you mentioned do:

	firmware_map_add_hotplug(start, start + size - 1, "System RAM");

or

                firmware_map_add_early(entry->addr,
                        entry->addr + entry->size - 1,
                        e820_type_to_string(entry->type));

So it seems a _bit_ silly to keep all of the callers doing this size-1
thing.  I also noted that the new caller that you added does the same
thing.  Could we just change the external calling convention to be
exclusive?

BTW, this patch should probably be first in your series.  It's a real
bugfix.
