Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D498CDDF28
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 01:23:08 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l25EN5Fj001539
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 09:23:05 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l25EN5QI546538
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 07:23:05 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l25EN5T9020854
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 07:23:05 -0700
Subject: Re: [PATCH 10/15] Add device tree for Ebony
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070305032452.B8CC0DDF1B@ozlabs.org>
References: <20070305032452.B8CC0DDF1B@ozlabs.org>
Content-Type: text/plain
Date: Mon, 05 Mar 2007 08:23:04 -0600
Message-Id: <1173104584.6561.5.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> Add a device tree for the Ebony evaluation board (440GP based).  This
> tree is not complete or finalized.  This tree needs a very recent
> version of dtc to process.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---
> +
> +	chosen {
> +		linux,stdout-path = "/plb/opb@0/serial@140000200";
> +		linux,initrd-start = <0>; /* FIXME */
> +		linux,initrd-end = <0>;

Could we add a bootargs property here?  It needs to be present to allow
set_cmdline in the wrapper to actually function.  Without it, the
console ops allow you to specify on at the

Linux/PowerPC load:

line, but it doesn't actually get set in the DT.  In my testing, having

bootargs = "";

was sufficient to allow the cmdline editing (or inserting in this case)
to work.

josh
