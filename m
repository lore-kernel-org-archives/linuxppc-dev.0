Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 651FF1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:47:19 +1100 (AEDT)
Date: Mon, 8 Feb 2016 13:48:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 2/9] arch/powerpc: Clean up error handling for
 htab_remove_mapping
Message-ID: <20160208024832.GB30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-3-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-3-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:23:56PM +1100, David Gibson wrote:
> Currently, the only error that htab_remove_mapping() can report is -EINVAL,
> if removal of bolted HPTEs isn't implemeted for this platform.  We make
> a few clean ups to the handling of this:
> 
>  * EINVAL isn't really the right code - there's nothing wrong with the
>    function's arguments - use ENODEV instead
>  * We were also printing a warning message, but that's a decision better
>    left up to the callers, so remove it
>  * One caller is vmemmap_remove_mapping(), which will just BUG_ON() on
>    error, making the warning message irrelevant, so no change is needed
>    there.
>  * The other caller is remove_section_mapping().  This is called in the
>    memory hot remove path at a point after vmemmap_remove_mapping() so
>    if hpte_removebolted isn't implemented, we'd expect to have already
>    BUG()ed anyway.  Put a WARN_ON() here, in lieu of a printk() since this
>    really shouldn't be happening.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Paul Mackerras <paulus@samba.org>
