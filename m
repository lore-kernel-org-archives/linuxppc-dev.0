Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 37018DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 09:26:18 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Wed, 11 Mar 2009 23:26:15 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1236807566.7086.51.camel@pasglop>
Message-ID: <20090311222615.63410@gmx.net>
MIME-Version: 1.0
References: <4C4E1899-9086-4DF5-A5BF-832AEBEAA8E9@semihalf.com>
	<1236807566.7086.51.camel@pasglop>
Subject: Re: NFS problems on a MPC5200-based board
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, tur@semihalf.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 12 Mar 2009 08:39:26 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: "Bartłomiej Sięka" <tur@semihalf.com>
> CC: linuxppc-dev@ozlabs.org, gerhard_pircher@gmx.net, Grant Likely <grant.likely@secretlab.ca>
> Betreff: Re: NFS problems on a MPC5200-based board

> On Wed, 2009-03-11 at 16:08 +0100, Bartłomiej Sięka wrote:
> > Hi,
> > 
> > This is a follow-up on NFS problems on an MPC5200-based board reported  
> > here a while back:
> > 
> >
> http://www.nabble.com/-PATCH--Add-support-for-the-digsy-MTC-board.-to21750004.html#a21792612
> > 
> > To recap: while using NFS, especially while mounting the root  
> > filesystem over NFS, the system is really slow and displays a bunch of  
> > "nfs: server 192.168.1.1 not responding, still trying" messages.  
> > Sometimes it is able to get to the login prompt, sometimes not. In  
> > cases where the login is successful, the system is still extremely  
> > sluggish (console hangs for tens of seconds and longer).
> > 
> > git bisect narrows down the troublesome commit as:
> 
> Maybe you need to set CPU_FTR_NEED_COHERENT for the 5200 ?
I would say the same, as the patch just replicates the
CPU_FTR_NEED_COHERENT handling of the hash page table code.

regards,

Gerhard

> > commit 4c456a67f501b8b15542c7c21c28812bf88f484b
> > Author: Gerhard Pircher <gerhard_pircher@gmx.net>
> > Date:   Fri Jan 23 06:51:28 2009 +0000
> > 
> >     powerpc/mm: Fix handling of _PAGE_COHERENT in BAT setup code
> > 
> >     _PAGE_COHERENT is now always set in _PAGE_RAM resp. PAGE_KERNEL.
> >     Thus it has to be masked out, if the BAT mapping should be non
> >     cacheable or CPU_FTR_NEED_COHERENT is not set.
> > 
> >     This will work on normal SMP setups because we force-set
> >     CPU_FTR_NEED_COHERENT as part of CPU_FTR_COMMON on SMP.
> > 
> >     Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> >     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > 
> > We have tested recent mainline kernel (past 2.6.29-rc7) with the  
> > 4c456a6...
> > commit reverted and NFS problems went away.
> > 
> > Other people have also reported similar problems (original posters on  
> > Cc):
> >
> http://www.nabble.com/-PATCH--Add-support-for-the-digsy-MTC-board.-tp21750004p21792825.html
> >
> http://www.nabble.com/-PATCH--Add-support-for-the-digsy-MTC-board.-tp21750004p21792612.html
> > 
> > The commit in question does not look directly related to NFS/ 
> > networking; moreover it is a fix for some other problem, so just  
> > reverting it is not an option, it seems (?). So how do we go about  
> > having NFS operational again? Any comments?
> > 
> > Regards,
> > Bartlomiej Sieka

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
