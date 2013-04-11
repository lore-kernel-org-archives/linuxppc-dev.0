Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41DA12C0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:12:56 +1000 (EST)
Subject: Re: recommended method of netbooting kernel/dtb in u-boot?
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5166DA49.5000907@genband.com>
Date: Thu, 11 Apr 2013 13:12:50 -0500
Message-Id: <3B81A930-A4AB-4AA7-BC36-FCCE55D33C66@kernel.crashing.org>
References: <5166DA49.5000907@genband.com>
To: Chris Friesen <chris.friesen@genband.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 11, 2013, at 10:44 AM, Chris Friesen wrote:

>=20
> Hi all,
>=20
> We've got a powerpc system that uses u-boot.  In our environment on =
bootup u-boot does a DHCP to get networking info, then uses TFTP to get =
the kernel, which then does DHCP again and NFS-mounts the initial root =
filesystem.
>=20
> What's the standard practice for this sort of thing when using device =
tree blobs?  Do most people use multi-file images or do they TFTP =
scripts to load and execute separate kernel/dtb files?
>=20
> For multi-part images is there an in-kernel way of generating a file =
containing a kernel and dtb combined?  I saw a patch proposed in 2008 to =
add a uImage.<dt> build target but it was shot down because it used the =
legacy multi-file format.  Is there an equivalent build target that uses =
the FIT format?


We've normally just done multiple tftp fetches and one grabs dtb and one =
grabs kernel.

- k=
