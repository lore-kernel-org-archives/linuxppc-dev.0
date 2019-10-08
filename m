Return-Path: <SRS0=I7zA=YB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE1C4360C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 17:45:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C9A2070B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 17:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C9A2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46nl9b35pJzDqRb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Oct 2019 04:45:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=linux.com
 (client-ip=3.19.106.255; helo=gentwo.org; envelope-from=cl@linux.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
Received: from gentwo.org (gentwo.org [3.19.106.255])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46nl7Q1wk9zDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2019 04:43:13 +1100 (AEDT)
Received: by gentwo.org (Postfix, from userid 1002)
 id 6438A3EC04; Tue,  8 Oct 2019 17:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by gentwo.org (Postfix) with ESMTP id 60AB53EC00;
 Tue,  8 Oct 2019 17:43:10 +0000 (UTC)
Date: Tue, 8 Oct 2019 17:43:10 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 02/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
In-Reply-To: <6e8877bff034603e75b35599797a39d9bc4840f1.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1910081741460.2923@www.lameter.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-3-leonardo@linux.ibm.com>
 <alpine.DEB.2.21.1910081509070.1734@www.lameter.com>
 <6e8877bff034603e75b35599797a39d9bc4840f1.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org,
 Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jann Horn <jannh@google.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Allison Randal <allison@lohutok.net>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Reza Arbab <arbab@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Souptick Joarder <jrdr.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Roman Gushchin <guro@fb.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 8 Oct 2019, Leonardo Bras wrote:

> > You are creating contention on a single exclusive cacheline. Doesnt this
> > defeat the whole purpose of the lockless page table walk? Use mmap_sem or
> > so should cause the same performance regression?
>
> Sorry, I did not understand that question.
> I mean, this is just a refcount and never causes a lock.

Locks also use atomic operations like a refcount increment. Both require
the cacheline to be in exclusive state. So the impact is very similar.
