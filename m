Return-Path: <chandru@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18E1DDDF2D
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 19:13:17 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n0J8C12P032506
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 19:12:01 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0J8CHBY700656
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 19:12:18 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0J8BxoB017290
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 19:12:00 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Mon, 19 Jan 2009 13:41:58 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<200901161746.36584.chandru@in.ibm.com>
	<1232128377.27278.69.camel@nimitz>
In-Reply-To: <1232128377.27278.69.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901191341.58437.chandru@in.ibm.com>
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

On Friday 16 January 2009 23:22:57 Dave Hansen wrote:
> Just looking at it, that calculation is OK.  But, there was one in your
> dmesg that looked a page too long, like page 0x1001 instead of 0x1000.
> I'd find out how that happened.

That is a result of PFN_UP() in reserve_bootmem_node() for which we hit the 
BUG_ON() eventually.   Prior to calling reserve_bootmem_node() we have...

node_ar.end_pfn = node->node_end_pfn = PFN_DOWN(physbase+reserve_size). 

Hence a PFN_UP() will raise the value of 'end'. The kernel has 
CONFIG_PPC_64K_PAGES enabled in the config. 

Chandru
