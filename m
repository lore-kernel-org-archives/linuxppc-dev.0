Return-Path: <dingel@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09F781A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 17:46:59 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dingel@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 08:46:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 09F7A2190061
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 08:46:33 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t527krDm24051776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 07:46:53 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t527kjAe019389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 01:46:52 -0600
Date: Tue, 2 Jun 2015 09:46:40 +0200
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle
 <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "David S.
 Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Zhang Zhen <zhenzhang.zhang@huawei.com>, David
 Rientjes <rientjes@google.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Nathan Lynch <nathan_lynch@mentor.com>,
 Andy Lutomirski <luto@amacapital.net>, Michael Holzheu
 <holzheu@linux.vnet.ibm.com>, Hugh Dickins <hughd@google.com>, Naoya
 Horiguchi <n-horiguchi@ah.jp.nec.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Davidlohr Bueso
 <dave@stgolabs.net>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Luiz Capitulino
 <lcapitulino@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove s390 sw-emulated hugepages and cleanup
Message-ID: <20150602094640.4fedc046@BR9TG4T3.de.ibm.com>
In-Reply-To: <556C0B5D.40205@de.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
 <556C0B5D.40205@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 01 Jun 2015 09:35:57 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 28.05.2015 um 13:52 schrieb Dominik Dingel:
> > Hi everyone,
> > 
> > there is a potential bug with KVM and hugetlbfs if the hardware does not
> > support hugepages (EDAT1).
> > We fix this by making EDAT1 a hard requirement for hugepages and 
> > therefore removing and simplifying code.
> 
> The cleanup itself is nice and probably the right thing to do. 
> Emulating large pages makes the code more complex and asks for
> trouble (as outlined above)
> 
> The only downside that I see is that z/VM as of today does not
> announce EDAT1 for its guests so the "emulated" large pages for
> hugetlbfs would be useful in that case. The current code allocates
> the page table only once and shares it for all mappers - which is
> useful for some big databases that spawn hundreds of processes with
> shared mappings of several hundred GBs. In these cases we do save
> a decent amount of page table memory. 

To limit the damage done, we could always allocate page tables with pgstes for that case.
That would allow one guest manipulating another guests storage keys,
but at least would prevent random memory overwrites in the host.

Another thing we could do, make software emulated large pages a kernel config option
and only if KVM is not selected allow it, visa versa.

@Martin what do you think?

Thanks,
	Dominik

> Not sure if that case is actually important, though.
> 
> Christian
> 
