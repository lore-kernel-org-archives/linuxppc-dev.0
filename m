Return-Path: <lorenzo@alphagolf.com>
Received: from fallback-mx3.atl.registeredsite.com
	(fallback-mx3.atl.registeredsite.com [64.224.219.97])
	by ozlabs.org (Postfix) with ESMTP id 226B2DDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jul 2008 11:48:40 +1000 (EST)
Received: from mail20.atl.registeredsite.com (mail20.atl.registeredsite.com
	[216.247.37.40])
	by fallback-mx3.atl.registeredsite.com (8.12.11.20060308/8.12.11) with
	ESMTP id m681f9WK020911
	for <linuxppc-embedded@ozlabs.org>; Mon, 7 Jul 2008 21:41:09 -0400
Message-ID: <4872C4D0.4060006@alphagolf.com>
Date: Mon, 07 Jul 2008 18:37:20 -0700
From: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
MIME-Version: 1.0
To: David Baird <dhbaird@gmail.com>
Subject: Re: booting an ML405
References: <486D774A.7000102@alphagolf.com>
	<440abda90807031902u766eb4dby932e8741e947488e@mail.gmail.com>
In-Reply-To: <440abda90807031902u766eb4dby932e8741e947488e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David,

Thanks for the response. I searched a little more and found that many 
people recommend looking through __log_buf to see if info is getting 
printed to memory. Below I've added the printouts I get both before and 
after the system hangs. Also, I'm not using Uartlite. I'm using 16550; 
however, I have created the same design with Uartlite and adjusted the 
console parameter to reflect that change. In both instances the kernel 
hangs. You're right too, this is common...I just need to figure out how 
to read out this __log_buf address:

If I stop the processor after it hangs:

XMD% mrd 0xc0259fa4 10
C0259FA4:   3C353E5B
C0259FA8:   20202020
C0259FAC:   302E3030
C0259FB0:   30303030
C0259FB4:   5D204C69
C0259FB8:   6E757820
C0259FBC:   76657273
C0259FC0:   696F6E20
C0259FC4:   322E362E
C0259FC8:   32352D72

If I stop it before it hangs:
XMD% mrd 0xc0259fa4 10
C0259FA4:   00000000
C0259FA8:   00000000
C0259FAC:   00000000
C0259FB0:   00000000
C0259FB4:   00000000
C0259FB8:   00000000
C0259FBC:   00000000
C0259FC0:   00000000
C0259FC4:   00000000
C0259FC8:   00000000

according to my system.map file __log_buf is located at C0259FA4

If I cut off the 0xc0000000:

XMD% mrd 0x259fa4 10
  259FA4:   FFFFFFFF
  259FA8:   FFFFFFFF
  259FAC:   FFFFFFFF
  259FB0:   FFFFFFFF
  259FB4:   FFFFFFFF
  259FB8:   FFFFFFFF
  259FBC:   FFFFFFFF
  259FC0:   FFFFFFFF
  259FC4:   FFFFFFFF
  259FC8:   FFFFFFFF

Any insight as to how to figure out what these values mean using XMD 
would be great. Or if you guys have any other recommendations for using 
the JTAG (not with XMD) I would greatly appreciated!

thanks,
Lorenzo



David Baird wrote:
> On Thu, Jul 3, 2008 at 7:05 PM, Lorenzo T. Flores <lorenzo@alphagolf.com> wrote:
>   
>> I'm trying to compile the Xilinx patched kernel tree (v2.6.25-rc9) and run
>> it on an ML405
>>
>> So far, I get to the following point in the boot sequence:
>>
>> loaded at:     00400000 005AF5A0
>> board data at: 005AD524 005AD5A0
>> relocated to:  00405058 004050D4
>> zimage at:     00405E90 0051D6CC
>> initrd at:     0051E000 005ACC0D
>> avail ram:     005B0000 80000000
>>
>> Linux/PPC load: console=ttyS0,9600 ip=on root=/dev/ram rw
>> Uncompressing Linux...done.
>> Now booting the kernel
>>
>> The system hangs after it says "Now booting the kernel."
>>     
>
> This seems to come up a lot, so I'm surprised you didn't find it in
> the archives ;-)
>
> Are you using uartlite?  You'll need to change the "console" option if you are.
>
> -David
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
