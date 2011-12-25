Return-Path: <paulus@ozlabs.org>
Date: Mon, 26 Dec 2011 09:35:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/5] KVM: PPC: Book3s HV: Implement get_dirty_log using
 hardware changed bit
Message-ID: <20111225233524.GA5348@sammy.paulus.ozlabs.org>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
 <20111215120322.GE20629@bloggs.ozlabs.ibm.com>
 <C59FE93D-AD1B-4382-BE8B-FF2DDD22930E@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C59FE93D-AD1B-4382-BE8B-FF2DDD22930E@suse.de>
Cc: linuxppc-dev@ozlabs.org, KVM list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 23, 2011 at 02:23:30PM +0100, Alexander Graf wrote:

> So if I read things correctly, this is the only case you're setting
> pages as dirty. What if you have the following:
> 
>   guest adds HTAB entry x
>   guest writes to page mapped by x
>   guest removes HTAB entry x
>   host fetches dirty log

In that case the dirtiness is preserved in the setting of the
KVMPPC_RMAP_CHANGED bit in the rmap entry.  kvm_test_clear_dirty()
returns 1 if that bit is set (and clears it).  Using the rmap entry
for this is convenient because (a) we also use it for saving the
referenced bit when a HTAB entry is removed, and we can transfer both
R and C over in one operation; (b) we need to be able to save away the
C bit in real mode, and we already need to get the real-mode address
of the rmap entry -- if we wanted to save it in a dirty bitmap we'd
have to do an extra translation to get the real-mode address of the
dirty bitmap word; (c) to avoid SMP races, if we were asynchronously
setting bits in the dirty bitmap we'd have to do the double-buffering
thing that x86 does, which seems more complicated than using the rmap
entry (which we already have a lock bit for).

> PS: Always CC kvm@vger for stuff that other might want to review
> (basically all patches)

So why do we have a separate kvm-ppc list then? :)

Paul.
