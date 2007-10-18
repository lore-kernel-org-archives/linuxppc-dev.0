Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18198.41946.697397.255427@cargo.ozlabs.ibm.com>
Date: Thu, 18 Oct 2007 10:07:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-mm1 - build failure with advansys
In-Reply-To: <20071012235242.9d7daf05.akpm@linux-foundation.org>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	<47104D26.7050206@linux.vnet.ibm.com>
	<20071012235242.9d7daf05.akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> On Sat, 13 Oct 2007 10:14:22 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> > The functions virt_to_bus and bus_to_virt are begin defined between ifdef CONFIG_PPC32
> > but when i compile allyesconfig with ppc64 box,i get this error. This patch removes the
> > ifdef.

Which is totally bogus, because virt_to_bus/bus_to_virt only work on
systems without an IOMMU.  Most if not all ppc64 systems have one or
more IOMMUs.  This patch is nacked.

The correct fix is to make advansys depend on CONFIG_VIRT_TO_BUS, or
alternatively fix advansys.c properly by making it use the interfaces
described in Documentation/DMA-mapping.txt (or the equivalent scsi
helpers).

> Please copy the powerpc developers on powerpc patches.

Definitely.

Paul.
