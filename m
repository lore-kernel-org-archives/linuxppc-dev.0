Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 May 2014 14:20:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
Message-ID: <20140506042058.GA25186@drongo>
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677834.5010808@suse.de> <87lhug9taz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lhug9taz.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 05, 2014 at 08:17:00PM +0530, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
> 
> > On 05/04/2014 07:30 PM, Aneesh Kumar K.V wrote:
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >
> > No patch description, no proper explanations anywhere why you're doing 
> > what. All of that in a pretty sensitive piece of code. There's no way 
> > this patch can go upstream in its current form.
> >
> 
> Sorry about being vague. Will add a better commit message. The goal is
> to export MPSS support to guest if the host support the same. MPSS
> support is exported via penc encoding in "ibm,segment-page-sizes". The
> actual format can be found at htab_dt_scan_page_sizes. When the guest
> memory is backed by hugetlbfs we expose the penc encoding the host
> support to guest via kvmppc_add_seg_page_size. 

In a case like this it's good to assume the reader doesn't know very
much about Power CPUs, and probably isn't familiar with acronyms such
as MPSS.  The patch needs an introductory paragraph explaining that on
recent IBM Power CPUs, while the hashed page table is looked up using
the page size from the segmentation hardware (i.e. the SLB), it is
possible to have the HPT entry indicate a larger page size.  Thus for
example it is possible to put a 16MB page in a 64kB segment, but since
the hash lookup is done using a 64kB page size, it may be necessary to
put multiple entries in the HPT for a single 16MB page.  This
capability is called mixed page-size segment (MPSS).  With MPSS,
there are two relevant page sizes: the base page size, which is the
size used in searching the HPT, and the actual page size, which is the
size indicated in the HPT entry.  Note that the actual page size is
always >= base page size.

> Now the challenge to THP support is to make sure that our henter,
> hremove etc decode base page size and actual page size correctly
> from the hash table entry values. Most of the changes is to do that.
> Rest of the stuff is already handled by kvm. 
> 
> NOTE: It is much easier to read the code after applying the patch rather
> than reading the diff. I have added comments around each steps in the
> code.

Paul.
