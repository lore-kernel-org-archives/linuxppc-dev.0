Return-Path: <kas@node.shutemov.name>
Received: from jenni2.inet.fi (mta-out.inet.fi [195.156.147.13])
 by ozlabs.org (Postfix) with ESMTP id 923822C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 09:30:44 +1100 (EST)
Date: Tue, 14 Jan 2014 00:30:28 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc: thp: Fix crash on mremap
Message-ID: <20140113223028.GA8488@node.dhcp.inet.fi>
References: <1388570027-22933-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1388572145.4373.41.camel@pasglop>
 <20140102021951.GA26369@node.dhcp.inet.fi>
 <20140113141748.0b851e1573e41bf26de7c0ae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140113141748.0b851e1573e41bf26de7c0ae@linux-foundation.org>
Cc: aarcange@redhat.com, linux-mm@kvack.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 13, 2014 at 02:17:48PM -0800, Andrew Morton wrote:
> On Thu, 2 Jan 2014 04:19:51 +0200 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > On Wed, Jan 01, 2014 at 09:29:05PM +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2014-01-01 at 15:23 +0530, Aneesh Kumar K.V wrote:
> > > > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > > > 
> > > > This patch fix the below crash
> > > > 
> > > > NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
> > > > LR [c0000000000439ac] .hash_page+0x18c/0x5e0
> > > > ...
> > > > Call Trace:
> > > > [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
> > > > [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
> > > > [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
> > > > 
> > > > On ppc64 we use the pgtable for storing the hpte slot information and
> > > > store address to the pgtable at a constant offset (PTRS_PER_PMD) from
> > > > pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
> > > > the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
> > > > from new pmd.
> > > > 
> > > > We also want to move the withdraw and deposit before the set_pmd so
> > > > that, when page fault find the pmd as trans huge we can be sure that
> > > > pgtable can be located at the offset.
> > > > 
> 
> Did this get fixed?

New version: http://thread.gmane.org/gmane.linux.kernel.mm/111809

-- 
 Kirill A. Shutemov
