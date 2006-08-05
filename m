Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 2C4E0679FB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Aug 2006 07:19:24 +1000 (EST)
Date: Sat, 5 Aug 2006 16:18:06 -0500
From: Milton Miller <miltonm@bga.com>
To: hch@lst.de, mikey@neuling.org,
Subject: Re: [PATCH] SLB shadow buffer
Message-Id: <1115481268674b0dc511.424238335.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Aug  5 2006 07:45:44 AM CDT, Christoph Hellwig wrote:
> On Fri, Aug 04, 2006 at 03:53:19PM +1000, Michael Neuling wrote:
> > This adds a shadow buffer for the SLBs and regsiters it with PHYP.
> > Only the bolted SLB entries (first 3) are saved.
> 
> What is a SLB shadow buffer and why do we need it?  (I don't want to
> question the patch but rather learn a little more about lowlevel ppc64
> mmu details)

The SLB is the segment lookaside buffer and holds mappings from the 
effective address space (the address you get adding the register and 
offset) to the virtual address space.  Each entry covers 256MB (2^28) 
and includes an access lookup switch for both problem states (a single 
bit for each user and kernel mode), allowing the same or different 
access permissions.  The virtual address space, 80 bits shared by all 
processes in the system (partition in lpar), is translated to a real address 
and page permissions via the hash table, which is cached in the TLB.  
The original 64 bit archiecture filled the SLB from a segment table 
buffer (STAB), but this was changed to expicit software management in 
version 2, used by POWER4 and later processors.  The 32 bit 
architecture uses 16 fixed segment registers to perfom this mapping to 
a 52 bit virtual space.  

The SLB shadow buffer is a pure software construct recording the required 
segment translations.  Registering a the shadow buffer informs the 
hypervisor which entries are required when switching partitions, and may 
allow it to recover the partition from a hardware error. 

milton
