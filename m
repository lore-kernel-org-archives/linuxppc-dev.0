Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1dvZ0XcVzDsPC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 21:26:49 +1000 (AEST)
Date: Tue, 26 Sep 2017 06:26:24 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>,
 raji@linux.vnet.ibm.com,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20170926112623.GZ8421@gate.crashing.org>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
 <1506383986.2918.4.camel@gmail.com> <87k20mf2fn.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k20mf2fn.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 26, 2017 at 03:34:36PM +1000, Michael Ellerman wrote:
> Cyril Bur <cyrilbur@gmail.com> writes:
> > This was written for userspace which doesn't have to explicitly enable
> > VMX in order to use it - we need to be smarter in the kernel.
> 
> Well the kernel has to do it for them after a trap, which is actually
> even more expensive, so arguably the glibc code should be smarter too
> and the threshold before using VMX should probably be higher than in the
> kernel (to cover the cost of the trap).

A lot of userspace code uses V*X, more and more with newer CPUs and newer
compiler versions.  If you already paid the price for using vector
registers you do not need to again :-)

> But I digress :)

Yeah sorry :-)


Segher
