Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Feb 2008 10:59:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080211235958.GD18348@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47AFC5E3.20101@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 10, 2008 at 10:49:55PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > On Sun, Feb 10, 2008 at 09:40:19PM -0500, Sean MacLennan wrote:
> >   
> >> David Gibson wrote:
> >>     
> >>> This doesn't seem right.  warp_fixup_one_nor() changes only the
> >>> partition's offset, so you're not changing the size of any
> >>> partitions.  If you're not going to actually use any of the extra
> >>> flash space with 64M, I can't see why you'd bother moving around the
> >>> partitions you have.
> >>>   
> >>>       
> >> u-boot must be at the bottom of the flash. Also, for the 64M NOR flash 
> >> you can put everything in the NOR flash, I just don't show the 
> >> partitions. Booting from NOR is *much* faster than  booting from
> >> NAND.
> >>     
> >
> > Sorry, still not really following what's going on.  Without worrying
> > about the dts formatting or fixup code, can you summarise what the two
> > flash maps look like?
> >
> >   
> I guess what is confusing is that I am actually working with 3 flash 
> maps right now, although there will only be one map in the final version.
> 
> Map1:
> 
> NOR:
>   Kernel @ 0
>   Ramdisk
>   User
>   FPGA
>   Env
>   U-boot @ 63.5M
> 
> Map 2:
> 
> NOR:
>   FPGA
>   Env
>   U-boot @ 63.5M
> NAND:
>   Kernel @ 0
>   Ramdisk
>   User
> 
> Map 3:
>   Same as Map 2 only 4M NOR rather than 64M, so u-boot @ 3.5M.

But the partitions are all the same size, so in Map 2 there's a great
big gap between Env and U-boot?  Or there's a great big gap before
FPGA?

> The u-boot, env, and FPGA are anchored at the bottom of the flash. 
> Kernel is anchored at the top. Everything else goes in the middle.

Um.. so "bottom" actually means "high addresses" in the above?

> The FPGA partition contains the FPGA image. The user partition contains 
> a persistent JFFS2 file system. I don't use the user partition, so it 
> doesn't show up in the map I sent.
> 
> So map 1 was used until we got the NAND working. Map 2 is an interim 
> solution until we get the 4M flash. Map 3 is the final version.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
