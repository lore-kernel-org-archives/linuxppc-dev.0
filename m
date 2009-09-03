Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 12B5EB7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 06:38:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Thu, 3 Sep 2009 13:27:02 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1251993890.2548.14.camel@Adam>
References: <1251926572.10090.17.camel@Adam>
	<4A9F78AF.4010206@oxtel.com><1251971849.15089.28.camel@pasglop>
	<1251993890.2548.14.camel@Adam>
From: "Prodyut Hazarika" <phazarika@amcc.com>
To: <azilkie@datacast.com>,
	<benh@kernel.crashing.org>
Cc: Tom Burns <tburns@datacast.com>, Chris Pringle <chris.pringle@oxtel.com>,
	Andrea Zypchen <azypchen@intldata.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Adam,

> Are you sure there is L2 cache on the 440?

It depends on the SoC you are using. SoC like 460EX (Canyonlands board)
have L2Cache.
It seems you are using a Sequoia board, which has a 440EPx SoC. 440EPx
has a 440 cpu core, but no L2Cache.
Could you please tell me which SoC you are using?
You can also refer to the appropriate dts file to see if there is L2C.
For example, in canyonlands.dts (460EX based board), we have the L2C
entry.
        L2C0: l2c {
              ...
        }

>I am seeing this problem with our custom IDE driver which is based on=20
>pretty old code. Our driver uses pci_alloc_consistent() to allocate the

>physical DMA memory and alloc_pages() to allocate a virtual page. It=20
>then uses pci_map_sg() to map to a scatter/gather buffer. Perhaps I=20
>should convert these to the DMA API calls as you suggest.

Could you give more details on the consistency problem? It is a good
idea to change to the new DMA APIs, but pci_alloc_consistent() should
work too

Thanks
Prodyut=09

On Thu, 2009-09-03 at 19:57 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
> > Hi Adam,
> >=20
> > If you have a look in include/asm-ppc/pgtable.h for the following
section:
> > #ifdef CONFIG_44x
> > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED |
_PAGE_GUARDED)
> > #else
> > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> > #endif
> >=20
> > Try adding _PAGE_COHERENT to the appropriate line above and see if
that=20
> > fixes your issue - this causes the 'M' bit to be set on the page
which=20
> > sure enforce cache coherency. If it doesn't, you'll need to check
the=20
> > 'M' bit isn't being masked out in head_44x.S (it was originally
masked=20
> > out on arch/powerpc, but was fixed in later kernels when the cache=20
> > coherency issues with non-SMP systems were resolved).
>=20
> I have some doubts about the usefulness of doing that for 4xx. AFAIK,
> the 440 core just ignores M.
>=20
> The problem lies probably elsewhere. Maybe the L2 cache coherency
isn't
> enabled or not working ?
>=20
> The L1 cache on 440 is simply not coherent, so drivers have to make
sure
> they use the appropriate DMA APIs which will do cache flushing when
> needed.
>=20
> Adam, what driver is causing you that sort of problems ?
>=20
> Cheers,
> Ben.
>=20
>=20
--=20
Adam Zilkie
Software Designer,
International Datacasting Corp.

This message and the documents attached hereto are intended only for the
addressee and may contain privileged or confidential information. Any
unauthorized disclosure is strictly prohibited. If you have received
this message in error, please notify us immediately so that we may
correct our internal records. Please then delete the original message.
Thank you.


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--------------------------------------------------------

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =
is for the sole use of the intended recipient(s) and contains =
information that is confidential and proprietary to AppliedMicro =
Corporation or its subsidiaries. It is to be used solely for the purpose =
of furthering the parties' business relationship. All unauthorized =
review, use, disclosure or distribution is prohibited. If you are not =
the intended recipient, please contact the sender by reply e-mail and =
destroy all copies of the original message.
