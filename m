Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 205BEDDF63
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 04:34:02 +1100 (EST)
Date: Tue, 4 Dec 2007 10:35:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071204173544.GA32420@mag.az.mvista.com>
References: <20071129152836.GB13751@ru.mvista.com>
	<1196715170.13230.228.camel@pasglop>
	<20071204012329.GA18903@mag.az.mvista.com>
	<47558E59.4040107@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47558E59.4040107@ru.mvista.com>
Cc: David.Jenkins@emerson.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 08:28:57PM +0300, Andrei Dolnikov wrote:
> Mark A. Greer wrote:
> >On Tue, Dec 04, 2007 at 07:52:50AM +1100, Benjamin Herrenschmidt wrote:
> >  
> >>>	#address-cells = <1>;
> >>>+	#size-cells = <1>;
> >>>+	model = "Katana-Qp"; /* Default */
> >>>+	compatible = "emerson,Katana-Qp";
> >>>+	coherency-off;
> >>>+
> >>>      
> >>What do that mean (coherency-off) ?
> >>
> >>Somebody is trying again to use a 74xx with non cache coherent DMA ?
> >>    
> >
> >Hi Ben.
> >
> >I suspect Andrei got that from the prpmc2800 dts which I made so I'll
> >jump in.  (BTW, this is the same debate we have every year or two. :)
> >
> >By looking at the dts, that board has an mv64460 which has a couple
> >issues when it comes to coherency (depending on the rev of the chip).
> >
> >One is about not being able to use DCBST instructions with coherency on
> >and the other is about limiting the length of one of the traces (which
> >at least one board manufacturer that I know of refuses to implement).
> >The first one is supposed to be fixed by rev A1 of the part and the second
> >is supposed to be fixed by rev B0 of the part.  I don't know what rev(s)
> >are on the board(s) Andrei is using.  If its B0 or later, in theory, the
> >part should work with coherency on.
> >
> >Andrei, have you tested with coherency on?
> >  
> Yes, I tested it with "coherency on", but it didn't work.
> 
> I checked chip revisions on all boards I have and they all are >= 
> mv64_4_60 B0.

FWIW, this is consistent with what I see.

Mark
