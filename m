Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0151.outbound.protection.outlook.com [207.46.163.151])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2AD92C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 08:46:23 +1100 (EST)
Message-ID: <1389217564.25654.25.camel@snotra.buserror.net>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 8 Jan 2014 15:46:04 -0600
In-Reply-To: <20140108024235.GA20739@pek-khao-d1.corp.ad.wrs.com>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
 <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
 <1388796549.11795.100.camel@snotra.buserror.net>
 <20140104063452.GA11548@pek-khao-d1.corp.ad.wrs.com>
 <1389138364.11795.205.camel@snotra.buserror.net>
 <20140108024235.GA20739@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-08 at 10:42 +0800, Kevin Hao wrote:
> On Tue, Jan 07, 2014 at 05:46:04PM -0600, Scott Wood wrote:
> > On Sat, 2014-01-04 at 14:34 +0800, Kevin Hao wrote:
> > > > I'm having a hard time following the logic here.  What is PAGE_OFFSET -
> > > > offset supposed to be?  Why would we map anything belowe PAGE_OFFSET?
> > > 
> > > No, we don't map the address below PAGE_OFFSET.
> > >     memstart_addr is the physical start address of RAM.
> > >     start is the kernel running physical address aligned with 64M.
> > > 
> > >     offset = memstart_addr - start
> > > 
> > > So if memstart_addr < start, the offset is negative. The PAGE_OFFSET - offset
> > > is the virtual start address we should use for the init 64M map. It's above
> > > the PAGE_OFFSET instead of below.
> > 
> > Oh.  I think it'd be more readable to do "offset = start -
> > memstart_addr" and add offset instead of subtracting it.
> 
> Yes, I agree. The reason that I use "offset = memstart_addr - start" is that
> it seems "memstart_addr" is always greater than "start" when we are booting
> a kdump kernel with a kernel option like "crashkernel=64M@80M". :-)

...so there is a situation where you map below PAGE_OFFSET. :-)
 
> > Also, offset should be phys_addr_t -- even if you don't expect to
> > support offsets greater than 4G on 32-bit, it's semantically the right
> > type to use.  Plus, "int" would break if this code were ever used with
> > 64-bit.
> 
> I thought about using phy_addr_t for the "offset" originally but gave it up
> for the following reasons:
>   * It will not be greater than 4G.
>   * We have to use the ugly #ifdef CONFIG_PHYS_64BIT in restore_to_as0().
>   * Need more registers for arguments for restore_to_as0().
> 
> Of course you can change it to phys_addr_t if you prefer.

I'd at least like to make it "long".

-Scott
