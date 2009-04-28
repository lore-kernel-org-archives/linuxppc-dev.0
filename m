Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E16FDDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 02:02:54 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3SFwwp9027569
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:58:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3SG2nrA090474
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 12:02:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3SG2nKj009086
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 12:02:49 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
Date: Tue, 28 Apr 2009 18:02:47 +0200
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<1240931572.29485.77.camel@nimitz>
In-Reply-To: <1240931572.29485.77.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200904281802.47809.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, LKML <linux-kernel@vger.kernel.org>,
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

On Tuesday 28 April 2009 05:12:51 pm Dave Hansen wrote:
> On Tue, 2009-04-21 at 17:16 +0200, Stefan Roscher wrote:
> > From: Anton Blanchard <antonb at au1.ibm.com>
> > 
> > To improve performance of driver ressource allocation,
> > replace the vmalloc() call with kmalloc().
> 
> Just curious, but how big are these allocations?  Why was vmalloc() even
> ever used if we know they'll be small?
> 
> -- Dave
> 
> 

The theoretical maximum size can be 512k, but for common queue pairs 
less than 128k is used.Because of the theoretical maximum we implemented
vmalloc() first, but recognized a huge performance impact.

-- Stefan 
