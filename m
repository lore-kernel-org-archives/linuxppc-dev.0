Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id E338667A75
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 05:27:44 +1100 (EST)
Message-ID: <422C9D1B.1090400@mvista.com>
Date: Mon, 07 Mar 2005 11:27:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Hegde Ashok-aah024 <ashok.hegde@motorola.com>
References: <772BCEF88A1DD91191F80011856715F301C2B56C@zin24exm01.ap.mot.com>
In-Reply-To: <772BCEF88A1DD91191F80011856715F301C2B56C@zin24exm01.ap.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MV64360 MPSC - console problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ashok.

Hegde Ashok-aah024 wrote:

>Hi All,
>
>  I am trying to bring up linux-2.6.10 on ppc based system with
>MV64360(marvell controller).
>I am unable to use mpsc as the console, serial text debug messages are
>coming fine i.e. ppc_md.progress able to print properly on the serial port.
>I observed that  when console_init() is being called from init/main.c  none
>of our "mpsc" init functions are called.
>Also I see that there is no call to "console_initcall" in mpsc driver.
>According to my understanding this call is required in serial drivers used
>as consoles.
> I took this mpsc driver from "bk://source.mvista.com/linux-2.5-marvell" as
>mentioned in ppc mailinglist.
>   Hardware has been tested with linux-2.4.20 flavour and it is absolutely
>fine.
>
>Appreciate any help.
>  
>

It almost sounds like you don't have the mpsc config option selected.  
Make sure that "Marvell MPSC serial port support" and "Support for 
consol on Marvell MPSC serial port" under "Device Drivers"/"Character 
devices"/"Serial drivers" are selected.  If they don't appear then  you 
don't have CONFIG_PPC and/or CONFIG_MV64X60 defined.  Those two should 
be defined in arch/ppc/Kconfig under the appropriate board selection.

You also have to have the platform_data that is passed into the MPSC 
driver set up correctly for it to work correctly.

Mark
