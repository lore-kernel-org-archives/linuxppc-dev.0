Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sGsF29CszDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 18:41:52 +1000 (AEST)
Date: Fri, 17 Aug 2018 10:41:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 devel@linuxdriverproject.org, linux-s390@vger.kernel.org,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Len Brown <lenb@kernel.org>, David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Message-ID: <20180817084146.GB14725@kroah.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817075901.4608-2-david@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Well require to call add_memory()/add_memory_resource() with
> device_hotplug_lock held, to avoid a lock inversion. Allow external modules
> (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
> lock device hotplug.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> [modify patch description]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..9010b9e942b5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
>  {
>  	mutex_lock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(lock_device_hotplug);
>  
>  void unlock_device_hotplug(void)
>  {
>  	mutex_unlock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(unlock_device_hotplug);

If these are going to be "global" symbols, let's properly name them.
device_hotplug_lock/unlock would be better.  But I am _really_ nervous
about letting stuff outside of the driver core mess with this, as people
better know what they are doing.

Can't we just "lock" the memory stuff instead?  Why does the entirety of
the driver core need to be messed with here?

thanks,

greg k-h
