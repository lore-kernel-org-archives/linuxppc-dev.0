Return-Path: <paulus@ozlabs.org>
Date: Wed, 7 Aug 2013 10:24:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
Message-ID: <20130807002408.GE19254@iris.ozlabs.ibm.com>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1375484319.26902.4.camel@snotra.buserror.net>
 <1375485408.15999.67.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FCC@039-SN2MPN1-012.039d.mgd.msft.net>
 <1375503847.15999.80.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070FAD49@039-SN2MPN1-012.039d.mgd.msft.net>
 <1375730341.13074.38.camel@snotra.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070FBE3B@039-SN2MPN1-012.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070FBE3B@039-SN2MPN1-012.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 07:02:48AM +0000, Bhushan Bharat-R65777 wrote:
> 
> I am trying to me the Linux pte search and update generic so that this can be used for powerpc as well.
> 
> I am not sure which of the below two should be ok, please help

Given that the BookE code uses gfn_to_pfn_memslot() to get the host
pfn, and then kvm_set_pfn_dirty(pfn) on pages that you're going to let
the guest write to, I don't think you need to set the dirty and/or
accessed bits in the Linux PTE explicitly.  If you care about the
WIMGE bits you can do find_linux_pte_or_hugepte() and just look at the
PTE, but you really should be using mmu_notifier_retry() to guard
against concurrent changes to the Linux PTE.  See the HV KVM code or
patch 21 of my recent series to see how it's used.  You probably
should be calling kvm_set_pfn_accessed() as well.

Paul.
