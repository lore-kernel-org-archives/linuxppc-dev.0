Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC6C0DDF8B
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 23:06:39 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: Always use -mno-string & -mno-multiple
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <5fd8e208c5e6c87f852d6a528589dce3@kernel.crashing.org>
References: <1174543838.10836.21.camel@localhost.localdomain>
	<5fd8e208c5e6c87f852d6a528589dce3@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 23:06:31 +1100
Message-Id: <1174565191.10836.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Akinobu Mita <mita@fixstars.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-22 at 13:02 +0100, Segher Boessenkool wrote:
> > powerpc: Always use -mno-string and -mno-multiple
> >
> > The string and multiple load/store instructions are causing more
> > damage than help on a lot of processors where they are microcoded
> > and are generally no good for the kernel to use. Let's make sure
> > we don't emit them on any powerpc variant.
> 
> And they help a lot on many 32-bit CPUs.  NAK.
> 
> If you tell your GCC to compile for a certain CPU where
> these insns would be very slow, GCC will automagically
> not generate them, already.

multiple do, strings really don't much except maybe on 601.... we don't
quite yet have the options to compile for specific CPUs on arch/powerpc
so -mno-string is a good idea generally, though I agree -mno-multiple
isn't, thus my next patch :-)

Ben.
