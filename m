Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A3851402D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 10:06:48 +1000 (EST)
Message-ID: <1399334797.20388.71.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 06 May 2014 10:06:37 +1000
In-Reply-To: <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677558.50900@suse.de> <87r4489ttk.fsf@linux.vnet.ibm.com>
 <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 17:16 +0200, Alexander Graf wrote:
> Isn't this a greater problem? We should start swapping before we hit
> the point where non movable kernel allocation fails, no?

Possibly but the fact remains, this can be avoided by making sure that
if we create a CMA reserve for KVM, then it uses it rather than using
the rest of main memory for hash tables.

> The fact that KVM uses a good number of normal kernel pages is maybe
> suboptimal, but shouldn't be a critical problem.

The point is that we explicitly reserve those pages in CMA for use
by KVM for that specific purpose, but the current code tries first
to get them out of the normal pool.

This is not an optimal behaviour and is what Aneesh patches are
trying to fix.

Cheers,
Ben.
