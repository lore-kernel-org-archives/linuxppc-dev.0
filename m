Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 588361A08EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:46:13 +1100 (AEDT)
Date: Mon, 22 Feb 2016 09:40:22 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 4/9] powerpc/mm/book3s-64: Move _PAGE_PRESENT to the
 most significant bit
Message-ID: <20160221224022.GC30309@fergus.ozlabs.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-5-git-send-email-paulus@samba.org>
 <87vb5j72s5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vb5j72s5.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 20, 2016 at 10:11:14PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > This changes _PAGE_PRESENT for 64-bit Book 3S processors from 0x2 to
> > 0x8000_0000_0000_0000, because that is where PowerISA v3.0 CPUs in
> > radix mode will expect to find it.
> 
> All the changes in this patch related to _PAGE_PRESENT movement or are
> they cleanup that got added to this patch. I am looking at the hpte slot
> array changes and wondering how that is related to _PAGE_PRESENT.

I was preserving the property mentioned in this comment:

> >  /*
> >   * The linux hugepage PMD now include the pmd entries followed by the address
> >   * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
> > - * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
> > + * [ 000 | 1 bit secondary | 3 bit hidx | 1 bit valid]. We use one byte per
> >   * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
> >   * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
> >   *
> > - * The last three bits are intentionally left to zero. This memory location
> > + * The top three bits are intentionally left as zero. This memory location
> >   * are also used as normal page PTE pointers. So if we have any pointers
> >   * left around while we collapse a hugepage, we need to make sure
> >   * _PAGE_PRESENT bit of that is zero when we look at them

I don't know if this comment still applies, but now that _PAGE_PRESENT
is the top bit of a byte rather than one of the low bits, then to avoid
having _PAGE_PRESENT overlap these HPTE location bits in a byte, we
need to move the location bits.

It seems pretty bogus to me that we might interpret an array of these
bytes as a PTE, and if you're sure we never do that, we can drop this
change (and the now-misleading comment).

Paul.
