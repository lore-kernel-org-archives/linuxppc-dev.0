Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 757A8B7B97
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 11:12:19 +1100 (EST)
Date: Thu, 29 Oct 2009 19:12:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Message-ID: <20091030001228.GA29259@loki.buserror.net>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 17, 2009 at 02:01:38PM +0200, Joakim Tjernlund wrote:
> Joakim Tjernlund/Transmode wrote on 17/10/2009 13:24:18:
> >
> > Rex Feany <RFeany@mrv.com> wrote on 16/10/2009 22:25:41:
> > >
> > > Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
> > >
> > > > Right, it is the pte table walk that is blowing up.
> > > > I just noted that 2.6 lacks a tophys() call in its table walk
> > > > so I removed that one(there is one more tophys call but I don't think
> > > > it should be removed).
> > > > Try this addon patch:
> > >
> > > no difference
> 
> > OK, thinking a bit more, this part should not be executed as
> > copy_tofrom_user executes in kernel space.
> >
> > Any chance you can stick a HW breakpoint on FixupDAR?
> > Perhaps there is something different with kernel
> > virtual address to phys address?
> > A simple topys() works in 2.4, but perhaps not in 2.6?
> > this is the part of interest:
> > FixupDAR: /* Entry point for dcbx workaround. */
> >  /* fetch instruction from memory. */
> >  mfspr r10, SPRN_SRR0
> >  andis. r11, r10, 0x8000
> >  tophys  (r11, r10)
> >  beq- 139b  /* Branch if user space address */
> > 140: lwz r11,0(r11)
> 
> Probably better to walk the kernel page table too. Does this
> make a difference(needs the tophys() patch I posted earlier):

After applying by hand (whitespace damage), I get this and a bunch more:

VFS: Mounted root (nfs filesystem) readonly on device 0:12.                     
Freeing unused kernel memory: 96k init                                          
INIT: version 2.85 booting                                                      
Mounting /proc and /sys                                                         
Oops: Machine check, sig: 7 [#1]                                                
Embedded Planet EP88xC                                                          
NIP: 00002020 LR: c0089c58 CTR: 00000038                                        
REGS: c38d7de0 TRAP: 0200   Not tainted  (2.6.32-rc4-00971-g2edbf13-dirty)      
MSR: 00001000 <ME>  CR: 44002428  XER: 00000000                                 
TASK = c383b7a0[173] 'udev' THREAD: c38d6000                                    
GPR00: 00000001 c38d7e90 c383b7a0 00000014 c380bffc 0000000c 3001fffc 00000001  
GPR08: 00000038 0000039b c001137c c021c000 00000000 100c7368 c01f59f4 c01f59d0  
GPR16: c0240000 100982dc 100c0aac 10095ccc 00000047 c38a5868 c38d7f20 00000000  
GPR24: c38dd880 00000400 30020000 00000000 c38d7ea0 00000000 0000039c c38a5840  
NIP [00002020] 0x2020                                                           
LR [c0089c58] seq_read+0x488/0x558                                              
Call Trace:                                                                     
[c38d7e90] [c0089a74] seq_read+0x2a4/0x558 (unreliable)                         
[c38d7ee0] [c00ac264] proc_reg_read+0x4c/0x70                                   
[c38d7ef0] [c006f7f4] vfs_read+0xb4/0x158                                       
[c38d7f10] [c006fb04] sys_read+0x4c/0x90                                        
[c38d7f40] [c000dfb8] ret_from_syscall+0x0/0x38                                 
Instruction dump:                                                               
00000000 XXXXXXXX XXXXXXXX XXXXXXXX 7d5a02a6 XXXXXXXX XXXXXXXX XXXXXXXX         
41800010 XXXXXXXX XXXXXXXX XXXXXXXX 816b0000 XXXXXXXX XXXXXXXX XXXXXXXX         
---[ end trace fab819d28e265675 ]---                                            
/etc/rc.d/rcS: line 24:   173 Bus error               /etc/rc.d/init.d/$i $mode 

-Scott
