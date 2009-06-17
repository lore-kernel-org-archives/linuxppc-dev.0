Return-Path: <alexs@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 18E46B714B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 16:42:03 +1000 (EST)
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 320FEDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 16:42:01 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n5H6fs2f016909
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 06:41:54 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n5H6fstx1388680
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 07:41:54 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n5H6frTv013389
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 07:41:54 +0100
Date: Wed, 17 Jun 2009 08:41:51 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ewg] Re: [PATCH 2.6.31] ehca: Tolerate dynamic memory
	operations and huge pages
Message-ID: <20090617084151.010562c5@BL3D1974.boeblingen.de.ibm.com>
In-Reply-To: <adazlc8w45c.fsf@cisco.com>
References: <200906091559.24661.hannes.hering@linux.vnet.ibm.com>
	<adar5xoybwt.fsf@cisco.com>
	<20090616090809.34d162fc@BL3D1974.boeblingen.de.ibm.com>
	<adazlc8w45c.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	raisch@de.ibm.com, linux-kernel@vger.kernel.org, ewg@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Jun 2009 09:10:39 -0700
Roland Dreier <rdreier@cisco.com> wrote:

> 
>  > Yeah, the notifier code remains untouched as we still do not allow dynamic
>  > memory operations _while_ our module is loaded. The patch allows the driver to
>  > cope with DMEM operations that happened before the module was loaded, which
>  > might result in a non-contiguous memory layout. When the driver registers
>  > its global memory region in the system, the memory layout must be considered.
>  > 
>  > We chose the term "toleration" instead of "support" to illustrate this.
> 
> I see.  So things just silently broke in some cases when the driver was
> loaded after operations you didn't tolerate?
> 
> Anyway, thanks for the explanation.

Well, things did not break silently. The registration of the MR failed with
an error code which was reported to userspace.

Will you push the patch for .31 or .32?

Thanks,
Alex
