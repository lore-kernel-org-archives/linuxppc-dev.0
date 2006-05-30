Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (unknown [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1627B67A3A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:56:11 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.6/8.13.5) with ESMTP id k4U4wjtI165126
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:58:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4U4xBrX228340
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:59:13 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4U4tnkG030399
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:55:49 +1000
Subject: Re: [PATCH] powerpc: Fix buglet with MMU hash management
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060530043626.GC5101@pb15.lixom.net>
References: <1148962460.15722.19.camel@localhost.localdomain>
	<20060530043626.GC5101@pb15.lixom.net>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:55:47 +1000
Message-Id: <1148964948.15722.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-29 at 23:36 -0500, Olof Johansson wrote:
> On Tue, May 30, 2006 at 02:14:19PM +1000, Benjamin Herrenschmidt wrote:
> 
> > This fixes by allowing the updating of the protection bits in the native
> > hash handling to also set (but not clear) the "C" bit, and, in order to
> > also improve performances in the general case, by always setting that
> > bit on newly inserted hash PTE so that writeback really never happens.
> 
> Good catch!
> 
> However, you'll have a writeback on the R bit too, you should set that
> together with C.

Nope, R is always set at PTE insertion (it's _PAGE_ACCESSED)

Ben.
