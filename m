Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id 2B77B67A65
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Feb 2005 05:57:07 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so382802wri
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 10:57:06 -0800 (PST)
Message-ID: <528646bc05021210572aaeaa3f@mail.gmail.com>
Date: Sat, 12 Feb 2005 11:57:06 -0700
From: Grant Likely <glikely@gmail.com>
To: Wolfgang Denk <wd@denx.de>, Albert.David@barco.com
In-Reply-To: <20050212182105.A5967C1430@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <528646bc05021202175e967842@mail.gmail.com>
	<20050212182105.A5967C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Fwd: Memory Size Requirement to Run Linux on Embedded
	Environment
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 12 Feb 2005 19:21:00 +0100, Wolfgang Denk <wd@denx.de> wrote:
> In message <528646bc05021202175e967842@mail.gmail.com> you wrote:
> >
> > > There will be parameters of about 65KB are to be used and these parameters
> > > can be changed in the field. This parameter block will have 2 copies to
> > > avoid data corruption due to power fail. Hence to avoid the use of NAND
> > > Flash I will be using 2 Parameter files to read and write(into flash) in a
> > > linux environment during normal operation. Am I right??
> > You could map the FLASH as a MTD device and write to two different
> > sectors directly; then you can use a RAM disk instead of going with
> > JFFS on your flash.  Use a separate RedBoot partition for each
> > parameter sector.  (Note; using RedBoot partitions does not preclude
> > using u-boot)
> 
> I can't parse that. Using a ramdisk (as root filesystem?) has nothing
> to do with using a JFFS2 (not JFFS) filesystem for data storage.  And
True.

> actually  it's  usually  better to use a cramfs based root filesystem
> plus tmpfs for transient data  storage.  Finally,  I  don't  see  any
> reason  for  a "RedBoot" partition - any MTD partition will work just
> fine.
Yes, your right; I mentioned RedBoot partitioning specifically because
that happens to be what I've used.  Any scheme will work.

> 
> > > In this mailing list I have read the typical size of U-BOOT will be around
> > > 256KB as suggested by Wolfgang Denk.
> > U-boot will live at the beginning of flash.  The u-boot environment
> > will take up another sector.  Your parameter files will take up at
> 
> This is not correct. U-Boot is located where your memory map dictates
> it, this can be the begining or the end or right  in  the  middle  of
> your flash - depending on your hardware design.
I suggested the beginning of flash under the assumption that u-boot
would be the first code to execute.  Albert, if it is not then you
will need to have some other code at the boot location.

> 
> And 256 kB is an upper size limit  including  the  environment  (with
> enough spare even for redundand environment in most configuration). A
> typical U-Boot image (including environment) is 150...190 kB.
> 
> > least one sector each.  The rest can be dedicated to the kernel and
> > initrd images.  Set up a RedBoot partition for each.
> 
> What for?
Simply suggestions that I've found useful myself; I'm certainly not
saying that that is the best or only way.
> 
> > How much RAM does your app need?  32M is gobs for a simple system.  If
> > it's ultra simple you may even be able to go down to 16 (don't quote
> 
> In 16 MB you can run a native GCC  which  definitely  is  far  beyond
> being "ultra simple".
I stand corrected.

> 
> > me though).  Add more if your app is RAM hungry.  16M of flash should
> > also be gobs.  (Assuming 1-2M for the kernel and the rest for the
> > initrd image)
> 
> It is very difficult to make recommendations without more information
> about system requirements. Yes, it is usually possible  to  implement
> simple devices like a firewall / router / WLAN AP etc. in 4 or better
> 8 MB flash and 16 MB RAM. But you will also have to take into account
> if  there  are  requirements  like  reliable  software  updates  with
> guaranteed fall-back (which may  require  storage  capacity  for  the
> fall-back version) or similar features

Yes, my suggestions are based on assumptions.  Albert is still
responsible to do his own due diligence to make sure that makes the
right decisions.  Thanks for the clarifications.

Cheers,
g.
