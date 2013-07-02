Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E09922C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 08:28:57 +1000 (EST)
Message-ID: <1372804109.4122.25.camel@pasglop>
Subject: Re: [PATCH -V3 2/4] powerpc/kvm: Contiguous memory allocator based
 hash page table allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 03 Jul 2013 08:28:29 +1000
In-Reply-To: <51D2EDD7.9060205@suse.de>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <51D2EDD7.9060205@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, mina86@mina86.com,
 linux-mm@kvack.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-02 at 17:12 +0200, Alexander Graf wrote:
> Is CMA a mandatory option in the kernel? Or can it be optionally 
> disabled? If it can be disabled, we should keep the preallocated 
> fallback case around for systems that have CMA disabled.

Why ? More junk code to keep around ...

If CMA is disabled, we can limit ourselves to dynamic allocation (with
limitation to 16M hash table).

Cheers,
Ben.
