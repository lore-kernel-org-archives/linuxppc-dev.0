Return-Path: <petkan@mip-labs.com>
Received: from zztop.nucleusys.com (lan.nucleusys.com [92.247.61.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8bFL3rxFzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 01:49:58 +1000 (AEST)
Date: Wed, 10 Aug 2016 18:48:49 +0300
From: Petko Manolov <petkan@mip-labs.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-ima-devel@lists.sourceforge.net"
 <linux-ima-devel@lists.sourceforge.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Linux-ima-devel] [PATCH 1/7] ima: on soft reboot, restore the
 measurement list
Message-ID: <20160810154849.GE4087@localhost>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar>
 <87r39xthnv.fsf@concordia.ellerman.id.au>
 <18857164.IzlezsQllh@hactar>
 <87vaz9rlx2.fsf@concordia.ellerman.id.au>
 <1470833676.2881.183.camel@linux.vnet.ibm.com>
 <20160810143230.GD4087@localhost>
 <063D6719AE5E284EB5DD2968C1650D6D5F50F2BB@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F50F2BB@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16-08-10 14:40:13, David Laight wrote:
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+david.laight=aculab.com@lists.ozlabs.org] On Behalf Of
> > > > So given what you have above, you'd use something like:
> > > >
> > > > struct ima_kexec_hdr {
> > > > 	u16 version;
> > > > 	u16 _reserved0;
> > > > 	u32 _reserved1;
> > > > 	u64 buffer_size;
> > > > 	u64 count;
> > > > };
> > > >
> > > > cheers
> > >
> > > Thanks, I'll make this change.
> > 
> > I would suggest:
> > 
> > struct ima_kexec_hdr {
> > 	u64 buffer_size;
> > 	u64 count;
> > 	u16 version;
> > };
> > 
> > and let the compiler add the proper padding, depending on the architecture.  On
> > 32bit machine we'll have 4 bytes smaller allocations (compared to 64bit) while
> > retaining the same functionality.
> 
> AAAArrrrgggg.....
> 
> That doesn't work for 32bit applications on 64bit hosts.

Which part won't work?

> The extra bytes will make 0 difference to the allocation cost and lots to the 
> processing.

An example?


		Petko
