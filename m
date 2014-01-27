Return-Path: <paulus@ozlabs.org>
Date: Mon, 27 Jan 2014 21:41:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
Message-ID: <20140127104106.GA11663@iris.ozlabs.ibm.com>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
Cc: kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Liu Ping Fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 27, 2014 at 10:11:40AM +0100, Alexander Graf wrote:
> 
> On 21.01.2014, at 10:42, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > Liu Ping Fan <kernelfans@gmail.com> writes:
> > 
> >> To make sure that on host, the pages marked with _PAGE_NUMA result in a fault
> >> when guest access them, we should force the checking when guest uses hypercall
> >> to setup hpte.
> >> 
> >> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> > 
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate_range_start and
> > mmu_notifier_invalidate_range_end, which will mark existing guest hpte
> > entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
> > guest hpte entries. This patch does that. 
> 
> So what happens next? We insert a page into the HTAB without HPTE_V_VALID set, so the guest will fail to use it. If the guest does an H_READ on it it will suddenly turn to V_VALID though?
> 
> I might need a crash course in the use of HPTE_V_ABSENT.

HPTE_V_ABSENT means present from the point of view of the guest but
not present from the host's point of view, so yes H_READ turns
HPTE_V_ABSENT into HPTE_V_VALID.

Paul.
