Return-Path: <paulus@ozlabs.org>
Date: Sat, 1 Feb 2014 09:17:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 01/10] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR
 emulation
Message-ID: <20140131221743.GA12086@iris.ozlabs.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E92D15.8000901@suse.de> <87y51wjv0w.fsf@linux.vnet.ibm.com>
 <5C99D2BA-7E11-4012-B3BD-9B01F4F865ED@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5C99D2BA-7E11-4012-B3BD-9B01F4F865ED@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 31, 2014 at 11:47:44AM +0100, Alexander Graf wrote:
> 
> On 31.01.2014, at 11:38, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > Alexander Graf <agraf@suse.de> writes:
> > 
> >> On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
> >>> We definitely don't need to emulate mtspr, because both the registers
> >>> are hypervisor resource.
> >> 
> >> This patch description doesn't cover what the patch actually does. It 
> >> changes the implementation from "always tell the guest it uses 100%" to 
> >> "give the guest an accurate amount of cpu time spent inside guest
> >> context".
> > 
> > Will fix that
> > 
> >> 
> >> Also, I think we either go with full hyp semantics which means we also 
> >> emulate the offset or we go with no hyp awareness in the guest at all 
> >> which means we also don't emulate SPURR which is a hyp privileged
> >> register.
> > 
> > Can you clarify this ?
> 
> In the 2.06 ISA SPURR is hypervisor privileged. That changed for 2.07 where it became supervisor privileged. So I suppose your patch is ok. When reviewing those patches I only had 2.06 around because power.org was broken.

It's always been supervisor privilege for reading and hypervisor
privilege for writing, ever since it was introduced in 2.05, and that
hasn't changed.  So I think what Aneesh is doing is correct.

Regards,
Paul.
