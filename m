Return-Path: <livio@eecg.toronto.edu>
Received: from picton.eecg.toronto.edu (picton.eecg.toronto.edu
	[128.100.10.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "picton.eecg.toronto.edu",
	Issuer "picton.eecg.toronto.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EA2D7DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 04:56:43 +1100 (EST)
Date: Sun, 14 Jan 2007 12:56:34 -0500
From: Livio Soares <livio@eecg.toronto.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix performance monitor exception in 2.6.20-series
Message-ID: <20070114175634.GA8444@eecg.toronto.edu>
References: <20070113154029.GA32292@eecg.toronto.edu>
	<1168734544.5011.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168734544.5011.78.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Hi Ben,

  First,  I'd  like to  state  that  I have,  since  writting  my first  e-mail,
experimented with Oprofile on 2.6.20-rc4, and it _is_ affected as I theorized. I
get  something around  5  to  7 PMU  exceptions,  and no  more.  With my  patch,
exceptions keep coming as before the lazy IRQ patch.

Benjamin Herrenschmidt writes:
> 
> >   IMHO, option  #1 is very  nice, as long  as the PMU interrupt  handler behaves
> > itself.  One reason option #1 is desirable is, with PC-sampling, we are now able
> > to  sample  regions _inside_  interrupt-disabled  sections  (assuming an  actual
> > external interrupt  hasn't really occured yet). Before,  with hardware disabling
> > of  interrupts,  the  PMU  exceptions  were  necessarily  delivered  outside  of
> > interrupt disabled sections. 
> > 
> >   Anyways, does anyone see a problem with the following patch? 
> 
> Well, are you absolutely sure that nothing will break as a result of
> having a PMU interrupt happening right when it's not expected to ?
> 
> You are basically turning the PMU interrupt into an NMI... I'm not sure
> how safe that is.

  Yes, it is turning the PMU exception into an NMI. And, you are correct, it has
potential  for  problems. However,  if  you  look  closely through  the  current
Oprofile code it doesn't seem to execute anything dangerous. We have:

a) Looking at local CPU registers

b) Looking at current stack (when logging backtrace is enabled)

c) Writting information to a  per-CPU pre-allocated buffer. This is done without
   any form of locking. 

d) PMU  exception nesting cannot  occur (at least  on the PowerPC  machines I've
   looked  at).  Handling  must  'rfid'  before  the  PMU  can  deliver  another
   exception. 


  So, unless I missed something, the current code seems to be safe. 

  Another thing I tried was stress testing 2.6.20-rc4 with my patch and Oprofile
turned on. I  used an Apache2 benchmark for about  30 minutes. Everything worked
as  usual. I realize  this test  does not  guarantee the  safeness of  the code,
however, it served as a sanity check for obvious, easy to trigger bugs. 

  Thanks,

			Livio
