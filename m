Return-Path: <paulus@ozlabs.org>
Date: Tue, 23 Apr 2013 17:01:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V6 05/27] powerpc: New hugepage directory format
Message-ID: <20130423070103.GB30092@iris.ozlabs.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 03:30:39PM +0530, Aneesh Kumar K.V wrote:

> Instead of storing shift value in hugepd pointer we use mmu_psize_def index
> so that we can fit all the supported hugepage size in 4 bits

That works, but does mean that we have to scan the mmu_psize_defs[]
array to work out the encoding for a particular page size.  Instead,
we could use the fact that all large page sizes are powers of 4, as
are all supported page sizes on embedded processors.  So we could
encode using page_code = (page_order - 12) / 2, where page_order is
the log base 2 of the page size, and that lets us represent all power
of 4 page sizes between 2^12 (4kB) and 2^42 bytes (4TB).

Paul.
