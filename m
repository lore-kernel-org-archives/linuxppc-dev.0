Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 430CDDDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 04:50:16 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9QIoCAP027495
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 14:50:12 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9QIoB2E107218
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 12:50:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9QIoBc1008275
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 12:50:11 -0600
Date: Fri, 26 Oct 2007 13:50:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/2] PowerPC: Add 44x NDFC device-tree aware support
Message-ID: <20071026135003.257b82bd@weaponx.rchland.ibm.com>
In-Reply-To: <20071026163058.GA11354@ru.mvista.com>
References: <20071026163058.GA11354@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, sr@denx.de,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 26 Oct 2007 20:30:58 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> I've worked in parallel with Stefan Roese on the new OF NDFC support.
> This version (as well as Stefan's) is based on the original NDFC driver by Thomas Gleixner.
> The major difference is that the original implements each chip connected NDFC banks as a
> separate MTD device. Here I try to have one MTD device spread on all chips found.
> However, the chips should have equal ID's and sizes, but I've never seen several different
> chips attached to single ndfc. 

Hm.  Why did you do that?  It adds restrictions to the driver that
really don't need to be present.  If people want a single MTD device
across multiple chips, they can use mtdconcat.

Remember, just because you've never seen something, doesn't mean it
doesn't exist.  Bamboo even has two different sized NAND chips
hooked to the NDFC, IIRC.

josh
