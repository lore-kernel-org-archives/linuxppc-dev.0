Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BB5A4DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 13:40:21 +1100 (EST)
Message-ID: <47AFB593.30805@pikatech.com>
Date: Sun, 10 Feb 2008 21:40:19 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
In-Reply-To: <20080211001451.GA11572@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This doesn't seem right.  warp_fixup_one_nor() changes only the
> partition's offset, so you're not changing the size of any
> partitions.  If you're not going to actually use any of the extra
> flash space with 64M, I can't see why you'd bother moving around the
> partitions you have.
>   
u-boot must be at the bottom of the flash. Also, for the 64M NOR flash 
you can put everything in the NOR flash, I just don't show the 
partitions. Booting from NOR is *much* faster than  booting from NAND.
>
> In practice, probably not.  We already do a similar fixup on Ebony for
> different flash layouts that won't leave the unit names correct.  We
> really should get this right - and the fdt_set_name() function that's
> now in libfdt should make that possible, it just needs some wiring up
> to use in the bootwrapper.  That can come later, though, for now I
> think applying your fixups without correcting the unit addresses is
> adequate.
>
>   
Ok.
>> If anybody has suggestions on better ways to do this, fire away.
>>
>> And looking at this code, and other board ports, why is sysclk a local 
>> variable and all the other numbers hardcoded in the args? I left it the 
>> same way as the others but it does look a bit strange.
>>     
>
> I think this also came from Ebony.  IIRC, the sysclk isn't strictly
> speaking fixed, although it almost always has initialized value.  The
> point of the local variable was that I planned to replace the static
> initialization with some sort of probing once I figured out the
> details.
>   
That makes sense. I don't think you can probe for the sysclk on the 
taco, so I may just put it as a constant to the function.

Cheers,
   Sean
