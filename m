Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id BCEE2B743A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 05:01:03 +1000 (EST)
Date: Fri, 1 Oct 2010 13:52:50 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/9] v3 Allow memory blocks to span multiple memory
	sections
Message-ID: <20101001185250.GK14064@sgi.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62917.80008@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA62917.80008@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 01, 2010 at 01:31:51PM -0500, Nathan Fontenot wrote:
> Update the memory sysfs code such that each sysfs memory directory is now
> considered a memory block that can span multiple memory sections per
> memory block.  The default size of each memory block is SECTION_SIZE_BITS
> to maintain the current behavior of having a single memory section per
> memory block (i.e. one sysfs directory per memory section).
> 
> For architectures that want to have memory blocks span multiple
> memory sections they need only define their own memory_block_size_bytes()
> routine.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
> ---
>  drivers/base/memory.c |  155 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 108 insertions(+), 47 deletions(-)
> 
> Index: linux-next/drivers/base/memory.c
> ===================================================================
> --- linux-next.orig/drivers/base/memory.c	2010-09-30 14:13:50.000000000 -0500
> +++ linux-next/drivers/base/memory.c	2010-09-30 14:46:00.000000000 -0500
...
> +static unsigned long get_memory_block_size(void)
> +{
> +	u32 block_sz;
        ^^^

I think this should be unsigned long.  u32 will work, but everything
else has been changed to use unsigned long.  If you disagree, I will
happily acquiesce as nothing is currently broken.  If SGI decides to make
memory_block_size_bytes more dynamic, we will fix this up at that time.

Robin
