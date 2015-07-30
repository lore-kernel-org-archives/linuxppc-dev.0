Return-Path: <cl@linux.com>
Received: from resqmta-ch2-02v.sys.comcast.net
 (resqmta-ch2-02v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:34])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 098891A17B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 06:07:31 +1000 (AEST)
Date: Thu, 30 Jul 2015 15:07:25 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 David Rientjes <rientjes@google.com>, Greg Thelen <gthelen@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Gleb Natapov <gleb@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Cliff Whickman <cpw@sgi.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Robin Holt <robinmholt@gmail.com>
Subject: Re: [PATCH v3 1/3] mm: rename alloc_pages_exact_node to
 __alloc_pages_node
In-Reply-To: <55BA822B.3020508@suse.cz>
Message-ID: <alpine.DEB.2.11.1507301506560.6410@east.gentwo.org>
References: <1438274071-22551-1-git-send-email-vbabka@suse.cz>
 <alpine.DEB.2.11.1507301255380.5521@east.gentwo.org>
 <55BA822B.3020508@suse.cz>
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Jul 2015, Vlastimil Babka wrote:

> > NAK. This is changing slob behavior. With no node specified it must use
> > alloc_pages because that obeys NUMA memory policies etc etc. It should not
> > force allocation from the current node like what is happening here after
> > the patch. See the code in slub.c that is similar.
>
> Doh, somehow I convinced myself that there's #else and alloc_pages() is only
> used for !CONFIG_NUMA so it doesn't matter. Here's a fixed version.

Acked-by: Christoph Lameter <cl@linux.com>
