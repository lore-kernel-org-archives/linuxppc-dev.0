Return-Path: <paulus@ozlabs.org>
Date: Sat, 31 Dec 2011 11:44:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: Re: [PATCH 4/5] KVM: PPC: Book3s HV: Implement get_dirty_log using
 hardware changed bit
Message-ID: <20111231004427.GA28401@bloggs.ozlabs.ibm.com>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
 <20111215120322.GE20629@bloggs.ozlabs.ibm.com>
 <C59FE93D-AD1B-4382-BE8B-FF2DDD22930E@suse.de>
 <20111225233524.GA5348@sammy.paulus.ozlabs.org>
 <4EF80090.7050008@oss.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EF80090.7050008@oss.ntt.co.jp>
Cc: linuxppc-dev@ozlabs.org, Takuya Yoshikawa <takuya.yoshikawa@gmail.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 26, 2011 at 02:05:20PM +0900, Takuya Yoshikawa wrote:

> From my x86 dirty logging experience I have some concern about your code:
> your code looks slow even when there is no/few dirty pages in the slot.
> 
> +	for (i = 0; i < memslot->npages; ++i) {
> +		if (kvm_test_clear_dirty(kvm, rmapp))
> +			__set_bit_le(i, map);
> +		++rmapp;
> +	}
> 
> The check is being done for each page and this can be very expensive because
> the number of pages is not small.
> 
> 	When we scan the dirty_bitmap 64 pages are checked at once and
> 	the problem is not so significant.
> 
> Though I do not know well what kvm-ppc's dirty logging is aiming at, I guess
> reporting cleanliness without noticeable delay to the user-space is important.
> 
> 	E.g. for VGA most of the cases are clean.  For live migration, the
> 	chance of seeing complete clean slot is small but almost all cases
> 	are sparse.

The alternative approach is not to use the hardware changed bit but
instead to install read-only HPTEs when the guest requests a
read/write mapping, and then when the guest writes to the page we
intercept the protection fault, mark the page dirty and change the
HPTE to allow writing.  Then when harvesting the dirty bits we have to
change any dirty page back to a read-only HPTE.

That is all quite doable, but I was worried about the performance
impact of the extra faults.  We intend to do some performance studies
to see whether the alternative approach would give better performance.
There is a trade-off in that the alternative approach would slow down
normal operation a little in order to speed up the harvesting of the
dirty log.  That may in fact be worthwhile.

For now, the patch I posted at least gets the dirty page tracking
working, so we can use VGA emulation.

Paul.
