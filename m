Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC981DE0C1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 02:00:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3MFvFn0031404
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:57:15 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3MG0kUW170944
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 12:00:46 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3MG0hBW019953
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 12:00:45 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: michael <michael@evidence.eu.com>
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
Date: Wed, 22 Apr 2009 18:00:41 +0200
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<200904221602.29028.ossrosch@linux.vnet.ibm.com>
	<49EF254A.6020106@evidence.eu.com>
In-Reply-To: <49EF254A.6020106@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904221800.41399.ossrosch@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 April 2009 04:10:18 pm michael wrote:
> Hi,
> 

> I don't take the point, if it is not import use the vmalloc. Why you try 
> with a kmalloc
> alloc first? and why do not use kzalloc?

Because kmalloc() is faster than vmalloc() causing a huge performance win
when someone allocates a large number of queue pairs. We fall back to
vmalloc() only if kmalloc() can't deliver the memory chunk.
We don't need kzalloc because we fill the list right after the alloc.

regards Stefan
