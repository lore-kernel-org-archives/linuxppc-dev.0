Return-Path: <medp@primagraphics.co.uk>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id EC78C2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 19:47:17 +1000 (EST)
Message-ID: <4178D591.4080806@primagraphics.co.uk>
Date: Fri, 22 Oct 2004 10:40:33 +0100
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <41777D14.7090108@primagraphics.com>
	<35fb2e5904102106303edb204b@mail.gmail.com>
	<4177CB07.4000302@primagraphics.com>
In-Reply-To: <4177CB07.4000302@primagraphics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: gdb on a 440GP ELDK
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Mark Powell wrote:

> Jon Masters wrote:
>
>> On Thu, 21 Oct 2004 10:10:44 +0100, Mark Powell 
>> <medp@primagraphics.com> wrote:
>>
>>> The system seems to basically run fine apart from the fact that gdb
>>> doesn't stop at any breakpoints.
>>
>> Even the most simple scenario doesn't work, e.g.:
>
I have been able to borrow an Ebony system to compare and gdb worked 
fine on that system.
The difference is that kernel debugging (with BDI2000 support) was 
configured in my kernel but not in the Ebony kernel.
I tried disabling the BDI2000 support in my kernel and gdb works again.

Seeing this in ebony_setup_arch():

#if !defined(CONFIG_BDI_SWITCH)
    /*
     * The Abatron BDI JTAG debugger does not tolerate others
     * mucking with the debug registers.
     */
        mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
#endif

leads me to suspect that the BDI2000 support for kernel debugging stops 
gdb working in userland.
Does that sound likely? If so, I guess it is worth recording so that the 
info is in the archives.

BTW thanks to you guys for resurrecting the list and recovering the 
archives.

-- 
Mark Powell, Senior Software Engineer
Curtiss-Wright Controls Embedded Computing
Tel: +44 (0) 1763 852222
Email: medp@primagraphics.com
