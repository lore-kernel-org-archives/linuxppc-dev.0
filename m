Return-Path: <ananth@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 040FAB7D2E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 14:16:51 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4S4AHGo010744
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 22:10:17 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S4GncH111390
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 22:16:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4S4GmGK016720
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 22:16:49 -0600
Date: Fri, 28 May 2010 09:46:45 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
Message-ID: <20100528041645.GB25946@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com> <23979.1275013723@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23979.1275013723@neuling.org>
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

On Fri, May 28, 2010 at 12:28:43PM +1000, Michael Neuling wrote:
> 
> 
> In message <20100527141203.GA20770@in.ibm.com> you wrote:
> > Hi Paul,
> > 
> > While we are at it, can we also add nop to the list of emulated
> > instructions?
> > 
> > Ananth
> > ---
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > Emulate ori 0,0,0 (nop).
> > 
> > The long winded way is to do:
> > 
> >         case 24:
> >                 rd = (instr >> 21) & 0x1f;
> >                 if (rd != 0)
> >                         break;
> >                 rb = (instr >> 11) & 0x1f;
> >                 if (rb != 0)
> >                         break;
> 
> Don't we just need rb == rd?

Sure. But for this case, just checking against the opcode seems simple
enough.

Ananth
