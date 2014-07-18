Return-Path: <dave.hansen@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 8B6A91A07E8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 01:00:47 +1000 (EST)
Message-ID: <53C9369B.4070608@intel.com>
Date: Fri, 18 Jul 2014 08:00:43 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
To: Wang Nan <wangnan0@huawei.com>, Ingo Molnar <mingo@redhat.com>,
 Yinghai Lu <yinghai@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] memory-hotplug: x86_64: suitable memory should go
 to ZONE_MOVABLE
References: <1405670163-53747-1-git-send-email-wangnan0@huawei.com>
 <1405670163-53747-2-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1405670163-53747-2-git-send-email-wangnan0@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ia64@vger.kernel.org, Pei Feiyue <peifeiyue@huawei.com>,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2014 12:55 AM, Wang Nan wrote:
> +	if (!zone_is_empty(movable_zone))
> +		if (zone_spans_pfn(movable_zone, start_pfn) ||
> +				(zone_end_pfn(movable_zone) <= start_pfn))
> +			zone = movable_zone;
> +

It's nice that you hit so many architectures, but is there a way to do
this that doesn't involve copying and pasting the same bit of code in to
each architecture?
