Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3D3ABB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 18:56:09 +1000 (EST)
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B589DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 18:56:07 +1000 (EST)
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate6.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n5A8ssCV106902
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 08:54:54 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n5A8ssaf884906
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 09:54:54 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n5A8srUD020780
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 09:54:54 +0100
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2.6.31] ehca: Tolerate dynamic memory operations and huge
	pages
Date: Wed, 10 Jun 2009 10:54:50 +0200
References: <200906091559.24661.hannes.hering@linux.vnet.ibm.com>
	<1244592156.4680.5.camel@concordia>
In-Reply-To: <1244592156.4680.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200906101054.50822.hannes.hering@linux.vnet.ibm.com>
Cc: rdreier@cisco.com, alexs@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	ewg@lists.openfabrics.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wednesday 10 June 2009 02:02:36 Michael Ellerman wrote:
> For those of us who haven't read the HEA spec lately, can you give us
> some more detail on that? :)
first of all, please note that this patch is actually for the ehca infiniband
driver. The ehca driver uses an internal memory region, which is supposed to
contain all physical memory. A memory region maps a virtually contiguous
adapter address space to the physical or better absolute address space. The
limitation is that the memory region cannot map non-contiguous virtual adapter
address space. However, on ppc64 machines there is a feature to dynamically add
or remove memory to logical partitions during runtime. These operations scatter
the absolute memory so that the kernel memory has a non-contiguous layout. This
layout cannot be represented in a memory region. The purpose of this code is to
detect the memory layout so that the memory region can be made up of the
existing memory chunks. It also translates the kernel addresses to the memory
region address, which is needed for interaction with the HCA.
> How does it interact with kexec/kdump?
We never tested the ehca driver with kexec/kdump. This patch also doesn't
improve anything in this context.

> phys_to_abs() ? As below, or does it come from somewhere else?
You're right, actually that isn't needed on System p. On the other hand I
needed to choose an address type, which is the base of all mapping. The
"busmap" holds all addresses as absolute addresses. The absolute addresses can
then be converted in any other type (virt, phys). 

Regards

Hannes
