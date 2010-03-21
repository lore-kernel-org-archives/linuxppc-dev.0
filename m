Return-Path: <fthain@mail.telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id 35160B7CF1
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 20:16:11 +1100 (EST)
Date: Sun, 21 Mar 2010 20:16:02 +1100 (EST)
From: fthain@telegraphics.com.au
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] Macintosh: fix brace and trailing statement coding style
	issues in adb-iop.c This is a patch to the adb-iop.c file that cleans
	up
	brace and trailing statement warnings found by the checkpatch.pl tool.
	Signed-off-by: Michael Beardsworth <mbeards2@uoregon.edu>
In-Reply-To: <20100320230801.GA5000@cynthia.pants.nu>
Message-ID: <alpine.LNX.2.00.1003212013350.5911@nippy.intranet>
References: <1268171180-75624-1-git-send-email-mbeards2@uoregon.edu>
	<20100320230801.GA5000@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Beardsworth <mbeards2@uoregon.edu>, linux-m68k@vger.kernel.org,
	benh@kernel.crashing.or,
	Michael Beardsworth <mbeards@mbeards-mbp.lulzzzzzzz.info>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> On Tue, Mar 09, 2010 at 01:46:20PM -0800, Michael Beardsworth wrote:

> >...
> >  
> >  #ifdef DEBUG_ADB_IOP
> > -	printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X", req,
> > -		(uint) amsg->count + 2, (uint) amsg->flags, (uint) amsg->cmd);
> > +	printk(KERN_WARNING "adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X",
> > +		req, (uint) amsg->count + 2, (uint) amsg->flags, (uint) amsg->cmd);
> >  	for (i = 0; i < amsg->count; i++)
> >  		printk(" %02X", (uint) amsg->data[i]);
> >  	printk("\n");

> >...
> >  #ifdef DEBUG_ADB_IOP
> > -	printk("adb_iop_start %p: sending packet, %d bytes:", req, req->nbytes);
> > +	printk(KERN_WARNING "adb_iop_start %p: sending packet, %d bytes:", req, req->nbytes);
> >  	for (i = 0 ; i < req->nbytes ; i++)
> >  		printk(" %02X", (uint) req->data[i]);
> >  	printk("\n");

KERN_DEBUG is used for debugging messages, not KERN_WARNING.

Finn
