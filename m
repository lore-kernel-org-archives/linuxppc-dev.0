Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 33F4BB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 04:42:29 +1000 (EST)
Received: by gxk7 with SMTP id 7so3144224gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 11:42:27 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1251351981.20467.37.camel@pasglop>
References: <20090826060659.30936.75706.stgit@localhost.localdomain>
	<20090826060716.30936.40578.stgit@localhost.localdomain>
	<1251351981.20467.37.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 28 Aug 2009 12:42:07 -0600
Message-ID: <fa686aa40908281142v20102adbudf02d15d6f546e01@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] powerpc/pci: Merge ppc32 and ppc64 versions of
	phb_scan()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 26, 2009 at 11:46 PM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> On Wed, 2009-08-26 at 00:07 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> The two versions are doing almost exactly the same thing. =A0No need to
>> maintain them as separate files. =A0This patch also has the side effect
>> of making the PCI device tree scanning code available to 32 bit powerpc
>> machines, but no board ports actually make use of this feature at this
>> point.
>
> You missed various calls to scan_phb() in arch/powerpc :-)
>
> At least pSeries with dynamic LPAR is broken

Oops, yup.  I also broke CONFIG_PPC_OF_PLATFORM_PCI in of_platform.c.
Fixed now.

> I think iSeries might break too.

iSeries has its own unrelated scan_phb() implementation.  I don't
think I broke it.

> Try a ppc64_defconfig.

Done.

> I tentatively applied the other patches to -test

Thanks.  New scan_phb() patch to follow.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
