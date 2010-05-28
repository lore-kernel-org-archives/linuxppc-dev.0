Return-Path: <ananth@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05E89B7D27
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 15:54:47 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4S5mFk3027751
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:48:15 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S5si0M121914
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:54:44 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4S5siHW022916
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:54:44 -0600
Date: Fri, 28 May 2010 11:24:26 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
Message-ID: <20100528055426.GD25946@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com> <23979.1275013723@neuling.org>
	<20100528041645.GB25946@in.ibm.com> <7278.1275020610@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7278.1275020610@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 28, 2010 at 02:23:30PM +1000, Michael Neuling wrote:
> 
> 
> In message <20100528041645.GB25946@in.ibm.com> you wrote:
> > On Fri, May 28, 2010 at 12:28:43PM +1000, Michael Neuling wrote:
> > > 
> > > 
> > > In message <20100527141203.GA20770@in.ibm.com> you wrote:
> > > > Hi Paul,
> > > > 
> > > > While we are at it, can we also add nop to the list of emulated
> > > > instructions?
> > > > 
> > > > Ananth
> > > > ---
> > > > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > > > 
> > > > Emulate ori 0,0,0 (nop).
> > > > 
> > > > The long winded way is to do:
> > > > 
> > > >         case 24:
> > > >                 rd = (instr >> 21) & 0x1f;
> > > >                 if (rd != 0)
> > > >                         break;
> > > >                 rb = (instr >> 11) & 0x1f;
> > > >                 if (rb != 0)
> > > >                         break;
> > > 
> > > Don't we just need rb == rd?
> > 
> > Sure. But for this case, just checking against the opcode seems simple
> > enough.
> 
> Simple, sure.  You could not emulate anything and remove the code
> altogether.  That would be truly simple. :-P

Ah.. I misunderstood your initial point about rb == rd with imm = 0.

> Why not eliminate as much as possible?
> 
> Anyway, sounds like paulus as a better solution.

Right.

Ananth
