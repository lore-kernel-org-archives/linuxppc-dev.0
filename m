Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Rmw1WMjzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:10:55 +1000 (AEST)
Date: Thu, 13 Jul 2017 02:10:46 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 Matt Brown <matthew.brown.dev@gmail.com>
Subject: Re: [PATCH 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
Message-ID: <20170713071046.GA13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <5baaa1d2-b57d-3330-b496-b011cd209815@au1.ibm.com>
 <20170713064352.GY13471@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713064352.GY13471@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 01:43:53AM -0500, Segher Boessenkool wrote:
> On Thu, Jul 13, 2017 at 01:51:30PM +1000, Andrew Donnellan wrote:
> > On 13/07/17 13:25, Matt Brown wrote:
> > >@@ -1049,6 +1066,13 @@ int analyse_instr(struct instruction_op *op, struct 
> > >pt_regs *regs,
> > > 			do_cmp_unsigned(regs, val, val2, rd >> 2);
> > > 			goto instr_done;
> > >
> > >+		case 19173952: /* cmpb */
> > 
> > This looks wrong and should never trigger, given that the switch 
> > statement is comparing against ((instr >> 1) & 0x3ff).
> > 
> > How did you get this value?
> 
> The correct number is 508, and 19173952 = 37744*508.  How to get
> 37744 is a mystery though :-)

Ah.  Take the binary representation of 508, and interpret that as if
it were octal :-)  Those pesky meddling leading zeroes!


Segher
