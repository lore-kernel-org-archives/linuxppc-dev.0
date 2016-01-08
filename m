Return-Path: <dave.hansen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id AB9CA1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 12:14:00 +1100 (AEDT)
Subject: Re: [PATCH v4] memory-hotplug: Fix kernel warning during memory
 hotplug on ppc64
To: John Allen <jallen@linux.vnet.ibm.com>, gregkh@linuxfoundation.org
References: <568D9568.1010808@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, akpm@linux-foundation.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <568F0D56.5010908@intel.com>
Date: Thu, 7 Jan 2016 17:13:58 -0800
MIME-Version: 1.0
In-Reply-To: <568D9568.1010808@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/06/2016 02:30 PM, John Allen wrote:
> On any architecture that uses memory_probe_store to reserve memory, the
> udev rule will be triggered after the first section of the block is
> reserved and will subsequently attempt to online the entire block,
> interrupting the memory reservation process and causing the warning.
> This patch modifies memory_probe_store to add a block of memory with
> a single call to add_memory as opposed to looping through and adding
> each section individually. A single call to add_memory is protected by
> the mem_hotplug mutex which will prevent the udev rule from onlining
> memory until the reservation of the entire block is complete.

Seems sane to me.  Makes the code simpler too, so win win.

Acked-by: Dave Hansen <dave.hansen@intel.com>
