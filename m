Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DA3A1A0193
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:47:19 +1100 (AEDT)
Date: Mon, 8 Feb 2016 16:47:03 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 4/9] arch/powerpc: Clean up memory hotplug failure paths
Message-ID: <20160208054703.GD30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-5-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-5-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:23:58PM +1100, David Gibson wrote:
> This makes a number of cleanups to handling of mapping failures during
> memory hotplug on Power:
> 
> For errors creating the linear mapping for the hot-added region:
>   * This is now reported with EFAULT which is more appropriate than the
>     previous EINVAL (the failure is unlikely to be related to the
>     function's parameters)
>   * An error in this path now prints a warning message, rather than just
>     silently failing to add the extra memory.
>   * Previously a failure here could result in the region being partially
>     mapped.  We now clean up any partial mapping before failing.
> 
> For errors creating the vmemmap for the hot-added region:
>    * This is now reported with EFAULT instead of causing a BUG() - this
>      could happen for external reason (e.g. full hash table) so it's better
>      to handle this non-fatally
>    * An error message is also printed, so the failure won't be silent
>    * As above a failure could cause a partially mapped region, we now
>      clean this up.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Paul Mackerras <paulus@samba.org>
