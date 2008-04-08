Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E38A4DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 13:25:40 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m383Ni2p025097
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 23:23:44 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m383Pa99194422
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 21:25:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m383PaAp026695
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 21:25:36 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 2 of 3] [KVM] Add DCR access information to struct kvm_run
Date: Mon, 7 Apr 2008 22:25:32 -0500
References: <patchbomb.1207601611@localhost.localdomain>
	<474b35009da7b7bdb58c.1207601613@localhost.localdomain>
	<20080408011128.GA13454@localhost.localdomain>
In-Reply-To: <20080408011128.GA13454@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804072225.33040.hollisb@us.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 April 2008 20:11:28 David Gibson wrote:
> On Mon, Apr 07, 2008 at 03:53:33PM -0500, Hollis Blanchard wrote:
> > 1 file changed, 7 insertions(+)
> > include/linux/kvm.h |    7 +++++++
> >
> >
> > Device Control Registers are essentially another address space found on
> > PowerPC 4xx processors, analogous to PIO on x86. DCRs are always 32 bits,
> > and are identified by a 32-bit number.
>
> Well... 10-bit, actually.

The mtdcrux description in the ppc440x6 user manual says the following:

	Let the contents of register RA denote a Device Control Register.
	The contents of GPR[RS] are placed into the designated Device Control 
Register.

I take that to mean that we must worry about 32 bits worth of DCR numbers. 
Perhaps I should say "no more than" rather than "always".

-- 
Hollis Blanchard
IBM Linux Technology Center
