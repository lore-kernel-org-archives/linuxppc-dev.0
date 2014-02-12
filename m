Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 0D26D2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 01:21:26 +1100 (EST)
Date: Wed, 12 Feb 2014 06:23:34 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc: thp: Fix crash on mremap
Message-ID: <20140212142334.GB7688@kroah.com>
References: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211173129.GB30336@kroah.com>
 <87ioslt54d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ioslt54d.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, stable@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 12, 2014 at 08:22:02AM +0530, Aneesh Kumar K.V wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Feb 07, 2014 at 07:21:57PM +0530, Aneesh Kumar K.V wrote:
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> 
> >> This patch fix the below crash
> >> 
> >> NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
> >> LR [c0000000000439ac] .hash_page+0x18c/0x5e0
> >> ...
> >> Call Trace:
> >> [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
> >> [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
> >> [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
> >> 
> >> On ppc64 we use the pgtable for storing the hpte slot information and
> >> store address to the pgtable at a constant offset (PTRS_PER_PMD) from
> >> pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
> >> the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
> >> from new pmd.
> >> 
> >> We also want to move the withdraw and deposit before the set_pmd so
> >> that, when page fault find the pmd as trans huge we can be sure that
> >> pgtable can be located at the offset.
> >> 
> >> variant of upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
> >> for 3.12 stable series
> >
> > This doesn't look like a "variant", it looks totally different.  Why
> > can't I just take the b3084f4db3aeb991c507ca774337c7e7893ed04f patch
> > (and follow-on fix) for 3.12?
> 
> Because the code in that function changed in 3.13. Kirill added split
> ptl locks for huge pte, and we decide whether to withdraw and
> deposit again based on the ptl locks in 3.13. In 3.12 we do that only
> for ppc64 using #ifdef

I have no idea what that means...

If you want this patch applied, please be specific as to what is going
on, why the code is _very_ different, and all of that.  Make it
_obvious_ as to what is happening, and why I would be a fool not to take
it in the stable tree.

As it is, the code in this patch looks so different that I'm just
assuming you got something wrong and are trying to really send me
something else, so I'll just ignore it.

greg k-h
