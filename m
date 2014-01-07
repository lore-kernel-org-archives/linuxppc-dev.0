Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D62102C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 10:46:16 +1100 (EST)
Message-ID: <1389138364.11795.205.camel@snotra.buserror.net>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Tue, 7 Jan 2014 17:46:04 -0600
In-Reply-To: <20140104063452.GA11548@pek-khao-d1.corp.ad.wrs.com>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
 <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
 <1388796549.11795.100.camel@snotra.buserror.net>
 <20140104063452.GA11548@pek-khao-d1.corp.ad.wrs.com>
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

On Sat, 2014-01-04 at 14:34 +0800, Kevin Hao wrote:
> On Fri, Jan 03, 2014 at 06:49:09PM -0600, Scott Wood wrote:
> > On Fri, 2013-12-20 at 15:43 +0800, Kevin Hao wrote:
> > > On Wed, Dec 18, 2013 at 05:48:25PM -0600, Scott Wood wrote:
> > > > On Wed, Aug 07, 2013 at 09:18:31AM +0800, Kevin Hao wrote:
> > > > > This is based on the codes in the head_44x.S. The difference is that
> > > > > the init tlb size we used is 64M. With this patch we can only load the
> > > > > kernel at address between memstart_addr ~ memstart_addr + 64M. We will
> > > > > fix this restriction in the following patches.
> > > > 
> > > > Which following patch fixes the restriction?  With all seven patches
> > > > applied, I was still only successful booting within 64M of memstart_addr.
> > > 
> > > There is bug in this patch series when booting above the 64M. It seems
> > > that I missed to test this previously. Sorry for that. With the following
> > > change I can boot the kernel at 0x5000000.
> > 
> > I tried v4 and it still doesn't work for me over 64M (without increasing
> > the start of memory).  I pulled the following out of the log buffer when
> > booting at 0x5000000 (after cleaning up the binary goo -- is that
> > something new?):
> > 
> > Unable to handle kernel paging request for data at address 0xbffe4008
> 
> Actually there still have one limitation that we have to make sure
> that the kernel and dtb are in the 64M memory mapped by the init tlb entry.
> I booted the kernel successfully by using the following u-boot commands:
>   setenv fdt_high 0xffffffff
>   dhcp 6000000 128.224.162.196:/vlm-boards/p5020/uImage
>   tftp 6f00000 128.224.162.196:/vlm-boards/p5020/p5020ds.dtb
>   bootm 6000000 - 6f00000                                                                                                                                         

OK, that was it -- I hadn't set fdt_high and thus U-Boot was relocating
the fdt under 64M.

We should probably be using ioremap_prot() (or some other mechanism) to
create a special mapping, rather than assuming the fdt is covered by the
initial TLB entry.  That doesn't need to happen as part of this
patchset, of course, as it's not a new limitation.

> > I'm having a hard time following the logic here.  What is PAGE_OFFSET -
> > offset supposed to be?  Why would we map anything belowe PAGE_OFFSET?
> 
> No, we don't map the address below PAGE_OFFSET.
>     memstart_addr is the physical start address of RAM.
>     start is the kernel running physical address aligned with 64M.
> 
>     offset = memstart_addr - start
> 
> So if memstart_addr < start, the offset is negative. The PAGE_OFFSET - offset
> is the virtual start address we should use for the init 64M map. It's above
> the PAGE_OFFSET instead of below.

Oh.  I think it'd be more readable to do "offset = start -
memstart_addr" and add offset instead of subtracting it.

Also, offset should be phys_addr_t -- even if you don't expect to
support offsets greater than 4G on 32-bit, it's semantically the right
type to use.  Plus, "int" would break if this code were ever used with
64-bit.

If you're OK with these changes, I can fix it while applying.

-Scott
