Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 36E60DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 14:07:16 +1000 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [ofa-general] [PATCH 1/5] ehca: Supports large page MRs
References: <200707201601.52277.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 20 Jul 2007 21:07:13 -0700
In-Reply-To: <200707201601.52277.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Fri, 20 Jul 2007 16:01:51 +0200")
Message-ID: <adabqe67632.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, fenkes@de.ibm.com, stefan.roscher@de.ibm.com,
	linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I applied this, but I agree with checkpatch.pl:

 > WARNING: externs should be avoided in .c files
 > #227: FILE: drivers/infiniband/hw/ehca/ehca_mrmw.c:67:
 > +extern int ehca_mr_largepage;
 > 
 > WARNING: externs should be avoided in .c files
 > #949: FILE: drivers/infiniband/hw/ehca/hcp_if.c:753:
 > +	extern int ehca_debug_level;

if you need to use a variable in more than one .c file, put the extern
declaration in a common header that's included everywhere you use the
variable, including the .c file that it is defined in.  That way the
compiler can see if you get confused about the type of the variable.

When you get a chance, please post a follow-on patch to fix this.

 - R.
