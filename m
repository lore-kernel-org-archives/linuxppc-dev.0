Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50A05B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 10:35:31 +1100 (EST)
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef Simoens <stef.simoens@numericable.be>
In-Reply-To: <4BA2B570.2010202@numericable.be>
References: <4A68E1CE.4040307@scarlet.be> <1248425553.25467.20.camel@pasglop>
	<7704005f23c1dfcbfdc8f1963b290d98.squirrel@www.loft5.bisse17-21.be>
	<4BA2B570.2010202@numericable.be>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Mar 2010 10:35:24 +1100
Message-ID: <1268955324.2335.237.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-03-19 at 00:21 +0100, Stef Simoens wrote:
> Hello,
> 
> Some time ago (July 24th 2009 my mailbox says) I emailed you and the
> linuxppc-dev list about my problems booting from the mesh SCSI
> controller.
> 
> I just compiled 2.6.31 (actually, gentoo-sources-2.6.31-r10); but the
> problem remains
> I know that 2.6.33 is out, but as I didn't see any changes to the
> mesh-driver I guess that the problem is still there ...

Sadly I haven't had a chance to look. The MESH driver is a pretty
complicated thing that I didn't write and am not familiar with, so it's
going to take some work to sort out what's going on, and so far I
haven't had time to dedicate to this.

Cheers,
Ben.

> This is the logging I get when I boot (2.6.31):
> 
> mesh_abort(ef8501e0)
> mesh: state at ef9eaa50, regs at f1010000, dma at f1014a00
>     ct=   1 seq=47 bs=4027 fc= 0 exc= 0 err= 0 im= 7 int= 0 sp=f0
>     dma stat=e0 cmdptr=2f8c2010
>     phase=5 msgphase=0 conn_tgt=0 data_ptr=0
>     dma_st=0 dma_ct=0 n_msgout=0
>     target 0: req=ef85901e0 goes_out=0 saved_ptr=0
> mesh_abort(ef850280)
> mesh: state at ef9eaa50, regs at f1010000, dma at f1014a00
>     ct=   1 seq=47 bs=4027 fc= 0 exc= 0 err= 0 im= 7 int= 0 sp=f0
>     dma stat=e0 cmdptr=2f8c2010
>     phase=5 msgphase=0 conn_tgt=0 data_ptr=0
>     dma_st=0 dma_ct=0 n_msgout=0
>     target 0: req=ef8501e0 goes_out=0 saved_ptr=0
> mesh_host_reset
> mesh_abort(ef8501e0)
> mesh: state at ef9eaa50, regs at f1010000, dma at f1014a00
>     ct=   0 seq=6a bs=4026 fc= 5 exc= 0 err= 0 im= 7 int= 0 sp= 2
>  fifo data=c0
>  fifo data=01
>  fifo data=03
>  fifo data=01
>  fifo data=19
>     dma stat=e0 cmdptr=2f8c2010
>     phase=3 msgphase=1 conn_tgt=0 data_ptr=0
>     dma_st=0 dma_ct=0 n_msgout=6
>     target 0: req=ef8501e0 goes_out=0 saved_ptr=0
> mesh_host_reset
> ...
> [afterwards, it "disconnects" all the disks and then it panics as it
> cannot find the root partition]
> 
> 2.6.29 runs fine ... but I guess that at some point, I would like to
> upgrade to the latest stable kernel.
> 
> The machine is a PowerPC9600 with a 740 upgrade card, 1GB memory,
> kernel compiled with GCC 4.3.4 ...
> 
> Of course I am willing to offer you all assistance you need to help
> you pin-point the problem...
> 
> Thanks for your help
> 
> Stef
> 
> Stef Simoens schreef: 
> > Hello Ben,
> > 
> > Thank you for your reply.
> >   
> > > On Fri, 2009-07-24 at 00:18 +0200, Stef Simoens wrote:
> > >     
> > > > I tried the latest 2.6.31-rc3-git3 (without any other patch).
> > > > However, I have the same behaviour as the patched 2.6.30 (so: no BUG,
> > > > but the mesh_abort messages).
> > > >       
> > > Would it be possible for you to roughly find out at what kernel version
> > > it stopped working ? (Some kernels may need my patch to avoid crashing)
> > >     
> > 
> > I am currently running 2.6.29-gentoo-r5 (that's somewhere at the end of
> > 2.6.29, probably 2.6.29.5).
> > 
> > I compiled 2.6.30 as soon as it came 'stable'.
> > In any version of 2.6.30,  I encounter the BUG (dma-mapping.h:218).
> > 
> > I didn't react immediately, I actually guessed that the problem would have
> > been reported and solved in another 2.6.30.x.
> > Because it didn't, I started browsing the mailing-list (and found your
> > patch).
> > 2.6.30-gentoo-r3 with your patch applied doesn't give the bug,
> > but gives the mesh_abort.
> > 
> > Before asking the question, I wanted to build the latest 2.6.31-rc
> > available to make sure my problem didn't get solved in the meantime.
> > 2.6.31-rc3 gives the same mesh_abort.
> > 
> > Would you like me to try all the linux-2.6.30-rc?
> > Could you give me your best guess starting-point?
> > 
> > I know that there exists something as git-disect ... but I have never used
> > git (there always needs to be the first time, of course).
> > 
> > Kind regards,
> > 
> > Stef
> >   
> -- 
> Stef Simoens                                 stef.simoens@numericable.be
> +32 486 577 963                         http://users.numericable.be/stef
