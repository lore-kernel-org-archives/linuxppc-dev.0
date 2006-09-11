Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABC1067B58
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 01:37:23 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BFbJsq012559
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 11:37:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8BFbJ7T277164
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 11:37:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8BFbJ0l024327
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 11:37:19 -0400
Subject: Re: Kernel panic: kernel access of bad area pc
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: ppc64@storix.com
In-Reply-To: <200609081532.59764.ppc64@storix.com>
References: <200609081532.59764.ppc64@storix.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:37:12 -0500
Message-Id: <1157989033.27328.16.camel@farscape>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-09 at 15:32 -0700, ppc64@storix.com wrote:
> I have a process to create tape boot images by combining the kernel and initrd 
> into a zImage. The process works for 2.4 (RHEL 3.3) & 2.6 kernels (SLES9 & 
> RHEL4). However on SLES8 ppc64 the kernel panics with "error kernel access of 
> bad area pc". 
> Anyone have an idea what is causing the failure? The error message appears to 
> be pretty generic.


The exception is a "TRAP: 0600"  which is an alignment interrupt.  

the trap occurred at NIP: C000000000085874 

Get an objdump of your kernel, (or drop into xmon/kdb and use the
disassembler commands) and see what instruction lives at that NIP
address, and which registers it is referencing.   (Then its a matter of
finding out why the registers have bad data in them). 

(You probally have already done this, but if not... )  If you're booting
off of tape in this instance, may want to try booting off of disk, and
doing some tape operations after successful boot, to ensure the driver
is all OK.  

-Will

> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
