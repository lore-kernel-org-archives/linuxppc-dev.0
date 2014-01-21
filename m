Return-Path: <paulus@ozlabs.org>
Date: Tue, 21 Jan 2014 22:22:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
Message-ID: <20140121112204.GE8265@iris.ozlabs.ibm.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
 <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
 <62DB3340-5AF7-4DA4-A790-77EE00696F57@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <62DB3340-5AF7-4DA4-A790-77EE00696F57@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Liu ping fan <kernelfans@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 20, 2014 at 03:48:36PM +0100, Alexander Graf wrote:
> 
> On 15.01.2014, at 07:36, Liu ping fan <kernelfans@gmail.com> wrote:
> 
> > On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
> >> 
> >> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
> >> 
> >>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"
> >>> 
> >>> For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
> >>> (for which, I still try to get a machine to show nums)
> >>> 
> >>> But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
> >>> which is  well known.
> >> 
> >> This cover letter isn't really telling me anything. Please put a proper description of what you're trying to achieve, why you're trying to achieve what you're trying and convince your readers that it's a good idea to do it the way you do it.
> >> 
> > Sorry for the unclear message. After introducing the _PAGE_NUMA,
> > kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
> > should rely on host's kvmppc_book3s_hv_page_fault() to call
> > do_numa_page() to do the numa fault check. This incurs the overhead
> > when exiting from rmode to vmode.  My idea is that in
> > kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
> > there is no need to exit to vmode (i.e saving htab, slab switching)
> > 
> >>> If my suppose is correct, will CCing kvm@vger.kernel.org from next version.
> >> 
> >> This translates to me as "This is an RFC"?
> >> 
> > Yes, I am not quite sure about it. I have no bare-metal to verify it.
> > So I hope at least, from the theory, it is correct.
> 
> Paul, could you please give this some thought and maybe benchmark it?

OK, once I get Aneesh to tell me how I get to have ptes with
_PAGE_NUMA set in the first place. :)

Paul.
