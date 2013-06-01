Return-Path: <michael@ellerman.id.au>
Date: Sat, 1 Jun 2013 21:19:08 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Always invalidate tlb on hpte invalidate and
 update
Message-ID: <20130601111908.GA16571@concordia>
References: <1369998204-31490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369998204-31490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 31, 2013 at 04:33:24PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> If a hash bucket gets full, we "evict" a more/less random entry from it.
> When we do that we don't invalidate the TLB (hpte_remove) because we assume
> the old translation is still technically "valid". This implies that when
> we are invalidating or updating pte, even if HPTE entry is not valid
> we should do a tlb invalidate.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Has this always been a bug? I assume not.

I'm asking because I have a kernel that's crashing and I'm wondering if
I might need this commit.

cheers
