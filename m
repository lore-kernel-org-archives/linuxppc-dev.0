Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 954FF1A084D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 17:28:57 +1000 (EST)
Date: Tue, 20 May 2014 00:28:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 2/2] powerpc/pseries: init fault_around_order for
 pseries
Message-Id: <20140520002834.aefb5a90.akpm@linux-foundation.org>
In-Reply-To: <1399541296-18810-3-git-send-email-maddy@linux.vnet.ibm.com>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1399541296-18810-3-git-send-email-maddy@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com,
 paulus@samba.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  8 May 2014 14:58:16 +0530 Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -17,6 +17,8 @@ struct device_node;
>  extern void request_event_sources_irqs(struct device_node *np,
>  				       irq_handler_t handler, const char *name);
>  
> +extern unsigned int fault_around_order;

This isn't an appropriate header file for exporting something from core
mm - what happens if arch/mn10300 wants it?.

I guess include/linux/mm.h is the place.
