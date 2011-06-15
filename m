Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id D534BB6F93
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 19:32:42 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 27342-02 for <linuxppc-dev@ozlabs.org>;
	Wed, 15 Jun 2011 10:32:32 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Relocatable kernel for ppc44x
Date: Wed, 15 Jun 2011 10:30:58 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD9E@saturn3.aculab.com>
In-Reply-To: <4DF84D92.2030803@in.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Suzuki Poulose" <suzuki@in.ibm.com>,
	<monstr@monstr.eu>
Cc: linuxppc-dev@ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> The PPC440X currently uses 256M TLB entries to pin the=20
> lowmem. When we go for a relocatable kernel we have to :
>=20
> 1) Restrict the kernel load address to be 256M aligned
>=20
> OR
>=20
> 2) Use 16M TLB(the next possible TLB page size supported)=20
> entries till the first
> 256M and then use the 256M TLB entries for the rest of lowmem.

What is wrong with:

3) Use 256M TLB entries with the lowest one including
   addresses below the kernel base.

Clearly the kernel shouldn't be accessing the addresses
below its base address - but that is true of a lot of
address space mapped into the kernel.

	David
