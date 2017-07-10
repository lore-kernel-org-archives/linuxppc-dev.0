Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5ZLj4m04zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 16:00:13 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A5xXOG107616
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 02:00:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjux6qsbc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 02:00:11 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 10 Jul 2017 02:00:10 -0400
Date: Sun, 9 Jul 2017 22:59:59 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 38/38] Documentation: PowerPC specific updates to memory
 protection keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
 <d94ab2c1-8be5-f618-6f42-cac2813059a5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d94ab2c1-8be5-f618-6f42-cac2813059a5@linux.vnet.ibm.com>
Message-Id: <20170710055959.GD5713@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 08:37:04AM +0530, Anshuman Khandual wrote:
> On 07/06/2017 02:52 AM, Ram Pai wrote:
> > Add documentation updates that capture PowerPC specific changes.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  Documentation/vm/protection-keys.txt |   85 ++++++++++++++++++++++++++--------
> >  1 files changed, 65 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
> > index b643045..d50b6ab 100644
> > --- a/Documentation/vm/protection-keys.txt
> > +++ b/Documentation/vm/protection-keys.txt
> > @@ -1,21 +1,46 @@
> > -Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
> > -which will be found on future Intel CPUs.
> > +Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature found in
> > +new generation of intel CPUs and on PowerPC 7 and higher CPUs.
> >  
> >  Memory Protection Keys provides a mechanism for enforcing page-based
> > -protections, but without requiring modification of the page tables
> > -when an application changes protection domains.  It works by
> > -dedicating 4 previously ignored bits in each page table entry to a
> > -"protection key", giving 16 possible keys.
> > -
> > -There is also a new user-accessible register (PKRU) with two separate
> > -bits (Access Disable and Write Disable) for each key.  Being a CPU
> > -register, PKRU is inherently thread-local, potentially giving each
> > -thread a different set of protections from every other thread.
> > -
> > -There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> > -to the new register.  The feature is only available in 64-bit mode,
> > -even though there is theoretically space in the PAE PTEs.  These
> > -permissions are enforced on data access only and have no effect on
> > +protections, but without requiring modification of the page tables when an
> > +application changes protection domains.
> > +
> > +
> > +On Intel:
> > +
> > +	It works by dedicating 4 previously ignored bits in each page table
> > +	entry to a "protection key", giving 16 possible keys.
> > +
> > +	There is also a new user-accessible register (PKRU) with two separate
> > +	bits (Access Disable and Write Disable) for each key.  Being a CPU
> > +	register, PKRU is inherently thread-local, potentially giving each
> > +	thread a different set of protections from every other thread.
> > +
> > +	There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> > +	to the new register.  The feature is only available in 64-bit mode,
> > +	even though there is theoretically space in the PAE PTEs.  These
> > +	permissions are enforced on data access only and have no effect on
> > +	instruction fetches.
> > +
> > +
> > +On PowerPC:
> > +
> > +	It works by dedicating 5 page table entry bits to a "protection key",
> > +	giving 32 possible keys.
> > +
> > +	There  is  a  user-accessible  register (AMR)  with  two separate bits;
> > +	Access Disable and  Write  Disable, for  each key.  Being  a  CPU
> > +	register,  AMR  is inherently  thread-local,  potentially  giving  each
> > +	thread a different set of protections from every other thread.  NOTE:
> > +	Disabling read permission does not disable write and vice-versa.
> 
> We can only enable/disable entire access or write. Then how
> read permission can be changed with protection keys directly ?

Good catch. On powerpc there is a disable read and disable write. They
both can be combined to disable access. Will fix the error. Read it
as 'Access Read' . thanks.

RP
