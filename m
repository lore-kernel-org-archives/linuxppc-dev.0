Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxjcc0HnGzDr48
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:00:00 +1000 (AEST)
Date: Tue, 27 Jun 2017 12:59:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH backport pre-4.9] powerpc/slb: Force a full SLB flush
 when we insert for a bad EA
Message-ID: <20170627105958.GA10609@kroah.com>
References: <87k244sed8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k244sed8.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 22, 2017 at 04:52:51PM +1000, Michael Ellerman wrote:
> The SLB miss handler calls slb_allocate_realmode() in order to create an
> SLB entry for the faulting address. At the very start of that function
> we check that the faulting Effective Address (EA) is less than
> PGTABLE_RANGE (ignoring the region), ie. is it an address which could
> possibly fit in the virtual address space.
> 
> For an EA which fails that test, we branch out of line (to label 8), but
> we still go on to create an SLB entry for the address. The SLB entry we
> create has a VSID of 0, which means it will never match anything in the
> hash table and so can't actually translate to a physical address.
> 
> However that SLB entry will be inserted in the SLB, and so needs to be
> managed properly like any other SLB entry. In particular we need to
> insert the SLB entry in the SLB cache, so that it will be flushed when
> the process is descheduled.
> 
> And that is where the bugs begin. The first bug is that slb_finish_load()
> uses cr7 to decide if it should insert the SLB entry into the SLB cache.
> When we come from the invalid EA case we don't set cr7, it just has some
> junk value from userspace. So we may or may not insert the SLB entry in
> the SLB cache. If we fail to insert it, we may then incorrectly leave it
> in the SLB when the process is descheduled.
> 
> The second bug is that even if we do happen to add the entry to the SLB
> cache, we do not have enough bits in the SLB cache to remember the full
> ESID value for very large EAs.
> 
> For example if a process branches to 0x788c545a18000000, that results in
> a 256MB SLB entry with an ESID of 0x788c545a1. But each entry in the SLB
> cache is only 32-bits, meaning we truncate the ESID to 0x88c545a1. This
> has the same effect as the first bug, we incorrectly leave the SLB entry
> in the SLB when the process is descheduled.
> 
> When a process accesses an invalid EA it results in a SEGV signal being
> sent to the process, which typically results in the process being
> killed. Process death isn't instantaneous however, the process may catch
> the SEGV signal and continue somehow, or the kernel may start writing a
> core dump for the process, either of which means it's possible for the
> process to be preempted while its processing the SEGV but before it's
> been killed.
> 
> If that happens, when the process is scheduled back onto the CPU we will
> allocate a new SLB entry for the NIP, which will insert a second entry
> into the SLB for the bad EA. Because we never flushed the original
> entry, due to either bug one or two, we now have two SLB entries that
> match the same EA.
> 
> If another access is made to that EA, either by the process continuing
> after catching the SEGV, or by a second process accessing the same bad
> EA on the same CPU, we will trigger an SLB multi-hit machine check
> exception. This has been observed happening in the wild.
> 
> The fix is when we hit the invalid EA case, we mark the SLB cache as
> being full. This causes us to not insert the truncated ESID into the SLB
> cache, and means when the process is switched out we will flush the
> entire SLB. Note that this works both for the original fault and for a
> subsequent call to slb_allocate_realmode() from switch_slb().
> 
> Because we mark the SLB cache as full, it doesn't really matter what
> value is in cr7, but rather than leaving it as something random we set
> it to indicate the address was a kernel address. That also skips the
> attempt to insert it in the SLB cache which is a nice side effect.
> 
> Another way to fix the bug would be to make the entries in the SLB cache
> wider, so that we don't truncate the ESID. However this would be a more
> intrusive change as it alters the size and layout of the paca.
> 
> This bug was fixed in upstream by commit f0f558b131db ("powerpc/mm:
> Preserve CFAR value on SLB miss caused by access to bogus address"),
> which changed the way we handle a bad EA entirely removing this bug in
> the process.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/mm/slb_low.S | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Note this patch is not upstream. The bug fix was fixed differently in
> upstream prior to the bug being identified.

Now applied to 4.4 and 3.18-stable kernels, thanks,

greg k-h
