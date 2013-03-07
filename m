Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 3BAE22C0395
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 21:11:00 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 15790-01 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  7 Mar 2013 10:10:56 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Thu, 7 Mar 2013 10:04:44 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7180@saturn3.aculab.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01BFA1D0@039-SN1MPN1-002.039d.mgd.msft.net>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 <1362440744.16575.6@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
 <1362509262.25308.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE9D9D@039-SN1MPN1-002.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7179@saturn3.aculab.com>
 <412C8208B4A0464FA894C5F0C278CD5D01BFA1D0@039-SN1MPN1-002.039d.mgd.msft.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jia Hongtao-B38951" <B38951@freescale.com>,
 "Wood Scott-B07421" <B07421@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> In my understanding filling the register could warn the executing =
process
> an error occurred in some cases. But no way to fix the wrong behavior =
caused
> by the instruction lost. So let's say that filling the register may =
benefit
> a little.

IIRC the only ppc instructions that should be accessing PCIe space
are simple memory reads/writes, locked exchanges probably don't work.
writes will be async - so we are talking about memory reads.

> On the other side, we should not access to the addresses of unknown =
process
> in Linux kernel. We must get the instruction before filling the =
register.
> If the instruction is not in the cache we have to access to the =
unknown
> addresses to get it. For system security I think this is strictly =
forbidden.

Eh???
The kernel fault handler will know whether the fault is from kernel
or userspace (in which case it must be the current process), and will
almost certainly already have code that looks at the faulting =
instruction
sequence.
If the faulting code address is 'user', then the normal functions for
reading user addresses have to be used.
If the faulting address is 'kernel' it might be in an ISR - restricting
what can be done - but the instruction is definitely readable.

> Although I think filling the register have some advantages but it's =
should
> be forbidden for security reason.

I'm sure security would say exactly the opposite.

	David
