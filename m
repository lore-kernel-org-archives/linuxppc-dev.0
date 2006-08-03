Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [204.127.192.84])
	by ozlabs.org (Postfix) with ESMTP id B2C8F67B76
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 02:49:32 +1000 (EST)
Message-ID: <44D22914.6060509@dlasys.net>
Date: Thu, 03 Aug 2006 12:49:24 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Booting Linux Kernel without bootloader
References: <311545913012eb141f24.1102520059.miltonm@bga.com>
	<528646bc0608030734j163acdd0gf37f19ece6f18c09@mail.gmail.com>
In-Reply-To: <528646bc0608030734j163acdd0gf37f19ece6f18c09@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>
> I've got a similar situation on my Virtex-4 platform.  The FPGA takes
> care of all device initialization.  However, the kernel is loaded of a
> CF card via a *slow* JTAG interface.  Loading an uncompressed image is
> more time consuming than loading a compressed image and uncompressing
> it in software.
>
>   
    I am working with the Pico E-12. It is a CF formfactor device. It
has only a pseudo Parallel/Jtag
    interface exported through the CF connector Pico calls the Keyhole
Port, and A UartLite, and TEMAC off some mini connector.
    Pico has their own "monitor" program that fits in 32K of ram inside
the FPGA that loads and executes ELF files (or FPGA bit images)
    from a very simple FileSystem (basically a linked list). Then they
have Host software to Read/Write the Flash, update files in Flash, ...
    that works primarily through the Keyhole.

    I just build the Kernel as an ELF file, update the ELF File in Flash
and tell it to boot that file and away it goes.
   
   
   
   

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
