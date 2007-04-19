Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (mail.mdivac.com [68.253.104.89])
	by ozlabs.org (Postfix) with ESMTP id 98ECFDDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 08:23:45 +1000 (EST)
Message-ID: <4627EBEF.2090104@mdivac.com>
Date: Thu, 19 Apr 2007 18:23:43 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: Clint Thomas <cthomas@Soneticom.com>
Subject: Re: Kernel crash on mem= argument
References: <3C02138692C13C4BB675FE7EA2409529328770@bluefin.Soneticom.local>
In-Reply-To: <3C02138692C13C4BB675FE7EA2409529328770@bluefin.Soneticom.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clint Thomas wrote:
> My u-boot config does not currently have a CONFIG_PRAM variable defined.
> Is doing this as easy as dropping in a #define in my board config? Or do
> I need to address this in another part of the code? Up until now, I just
> assumed that if I passed mem=200M to the kernel, it would allocate as
> necessary, then I could use the remaining RAM as I saw fit, but since
> this is not working I need to deal with it appropriately.
>
> Clint
>
> -----Original Message-----
> From: Frank D Lombardo [mailto:lombardo@mdivac.com] 
> Sent: Thursday, April 19, 2007 2:39 PM
> To: Clint Thomas
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Kernel crash on mem= argument
>
> Clint Thomas wrote:
>   
Clint,

I believe whats happening is that u-boot is loading the initrd in the 
region of RAM above 200M.  Then you pass mem=200M to the kernel, and it 
can't access the initrd.  By adding the appropriate CONFIG_PRAM define 
to your board config file, you let u-boot know not to use the memory 
above 200M either.  That way u-boot will load the initrd in memory that 
is usable by the kernel.

Frank
