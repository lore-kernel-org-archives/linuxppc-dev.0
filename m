Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0053.outbound.protection.outlook.com [104.47.34.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnsNV4yS2zDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 17:22:34 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: UIO memmap of PCi devices not working?
Date: Thu, 7 Sep 2017 07:22:26 +0000
Message-ID: <1504768943.27247.149.camel@infinera.com>
References: <1504711235.27247.110.camel@infinera.com>
 <1504768612.12628.19.camel@kernel.crashing.org>
In-Reply-To: <1504768612.12628.19.camel@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 17:16 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2017-09-06 at 15:20 +0000, Joakim Tjernlund wrote:
> > Having problems to mmap PCI UIO devices and stumbeled over this page:
> >  http://billfarrow.blogspot.se/2010/09/userspace-access-to-pci-memory.h=
tml
> > it claims some adjustments are needed for UIO mmap over PCI to work.
> > These are #if 0 ATM and trying to enable them fails build.
> >=20
> > Can this be fixed to at least build again ?
> > The reason for having #if 0 in the first place appears to be old X serv=
ers,
> > is that still true? Can the special casing be removed now?
>=20
> This article seems out of date... I *think* things should work without
> change by just mmap'ing the appropriate sysfs files. I'm not sure why
> the author thought that had to be ifdef'ed out...

Isn't that what the article is doing(mmaping sysfs files)?
And the article author is #ifdefing it back, not out.

>=20
> Let me know if you have problems.

Sure, we still are looking=20

>=20
> As far as I know, the generic code will call pci_resource_to_user()
> which on powerpc will return a physical address that already includes
> the offset, which is why we don't later add it.
>=20
> Now we could probably tear all that out and use the new generic code
> instead as I *think* X has (very) long been fixed but I'd have to spend
> some time triple checking and testing on old HW which I don't have the
> bandwidth for right now.=20

Could you fixup the code which is now #if 0 ? I wan't to test the
difference and I not sure how to fix the build problem after changing
those two #if 0 to #if 1
Even better if they could be a CONFIG option instead.

 Jocke=
