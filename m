Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 08CC02C009C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jan 2014 12:03:07 +1100 (EST)
Message-ID: <1389834172.6933.99.camel@pasglop>
Subject: Re: powerpc/powernv: Call OPAL sync before kexec'ing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 16 Jan 2014 12:02:52 +1100
In-Reply-To: <1389833903.31288.1.camel@concordia>
References: <1389765724.6933.78.camel@pasglop>
 <1389833903.31288.1.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-16 at 11:58 +1100, Michael Ellerman wrote:
> On Wed, 2014-01-15 at 17:02 +1100, Benjamin Herrenschmidt wrote:
> > From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> >     
> > Its possible that OPAL may be writing to host memory during
> > kexec (like dump retrieve scenario). In this situation we might
> > end up corrupting host memory.
> 
> Are we happy with that happening during kdump? (which doesn't call any of the
> shutdown paths)

Obviously not ... There's a problem there. Not sure what the right fix
is. Might need some ifdef KDUMP to take over in the new driver.

Ben.
