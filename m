Return-Path: <dave@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DBB3DE3B0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 04:25:35 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n07HOIqe024955
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 12:24:18 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n07HPUGv169286
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 12:25:30 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n07HPS9F006492
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 12:25:30 -0500
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Chandru <chandru@in.ibm.com>
In-Reply-To: <200901071828.13719.chandru@in.ibm.com>
References: <200812241325.49404.chandru@in.ibm.com>
	<200901051919.52327.chandru@in.ibm.com>
	<1231173033.19452.190.camel@nimitz>
	<200901071828.13719.chandru@in.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 09:25:25 -0800
Message-Id: <1231349125.23462.81.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 18:28 +0530, Chandru wrote:
> I don't know how you wanted NODE_DATA() to be consulted here. i.e before 
> calling reserve_bootmem_node() should we have a condition 
> 
>         if (PFN_UP(physbase+reserve_size) > node_end_pfn) 
>         then
>                 resize reserve_size again so that PFN_UP() will equate to node_end_pfn ??
>         end 

I'm just suggesting making your fix in the ppc code instead of in
mm/bootmem.c.

-- Dave
