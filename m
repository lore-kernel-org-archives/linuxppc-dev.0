Return-Path: <Nick.Spence@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66D8BDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 16:31:18 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m486VCOO027381
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 23:31:12 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m486VBZs018431
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 01:31:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM non-cached.
Date: Wed, 7 May 2008 23:31:09 -0700
Message-ID: <9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
In-Reply-To: <18466.38047.531381.157886@cargo.ozlabs.ibm.com>
References: <1210224392246-git-send-email-nick.spence@freescale.com>
	<18466.38047.531381.157886@cargo.ozlabs.ibm.com>
From: "Spence Nick" <Nick.Spence@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> This says nothing about why you want to do this---what bad=20
> things arise from the present code, or what good things would=20
> happen if the change was made.  It needs to.

We found the problem when porting code from Linux 2.4 to 2.6, where a
user space application maps a 1 MByte region of DRAM with the O_SYNC=20
flag to communicate with an internal core that shares access to the
DRAM but does not have any cache snooping logic.

In 2.4 the mem driver honors the O_SYNC flag and makes the requested
memory
memory non-cached so that writes from user space are immediately
available
to the second core.

In 2.6 the powerpc mem driver no longer honors the O_SYNC flag so the
data
is only written out to DRAM (and becoming visible to the second core) as
the
cache reloads with other data.

> The change isn't acceptable as it is, because IBM machines=20
> with a hypervisor don't allow system memory to be mapped=20
> uncacheable.  It would at least have to have some=20
> platform-specific check in there.
>=20
> On other powerpc platforms, this would introduce possible=20
> cache paradoxes, where a page is mapped cacheable at one=20
> address (via the linear mapping) and uncacheable at another=20
> address (via /dev/mem).  If you really really want to do=20
> this, you'll need to add code to bust up the large pages (or=20
> TLB entries) used for the linear mapping so that the=20
> corresponding pages of the linear mapping can be unmapped, or=20
> mapped cacheable.  Plus you'll need to add the appropriate=20
> cache flushing code to make sure there aren't any cache lines=20
> for the page in cache.  Further, you'll need to arrange=20
> somehow to make sure that the kernel stack has a resident TLB=20
> entry during the unrecoverable parts of the exception entry=20
> and exit paths.
>=20

This is getting to be a much more elaborate project.

In our case the memory area is reserved so that the main processor will
not
touch it except when mapped by the mem driver.

Alternative solutions are to modify the user space code to flush out the
caches by reading a large area, or to implement a board specific=20
ppc_md.phys_mem_access_prot() function to do this.

Either of these will meet my needs, but this will leave the O_SYNC flag
ignored on the PowerPC architecture in 2.6, but honored by Linux 2.4 and
other architectures. Probably not a problem for most people.

Thanks,
  Nick
