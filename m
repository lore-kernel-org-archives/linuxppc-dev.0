Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 20C78680B4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 04:48:25 +1000 (EST)
Message-ID: <4626.198.22.236.230.1123786102.squirrel@198.22.236.230>
In-Reply-To: <20050810103750.253a2b74.kim.phillips@freescale.com>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
	<53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
	<20050803114749.739ae51e.kim.phillips@freescale.com>
	<30177.198.22.236.230.1123094006.squirrel@198.22.236.230>
	<20050803153540.3530e114.kim.phillips@freescale.com>
	<53521.198.22.236.230.1123620724.squirrel@198.22.236.230>
	<20050810103750.253a2b74.kim.phillips@freescale.com>
Date: Thu, 11 Aug 2005 14:48:22 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Kim Phillips" <kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler 'is' invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kim,
  While browsing the SIU came across TESCR1(0x10040) & TESTCR2(0x10044). I
dumped it during module_init (00000000::00000000)  and also in the ISR
after RNG was submitted to SEC core, this time I got
(0x814a0000::00000000).

TESCR1 after RNG descriptor submitted and SEC-ISR invoked=0x814a0000
bit 0 set -- 60x bus monitor timeout
bit 7-9=  101 --- SEC transaction
bit 11-15=01010 -- TT -- Single-beat-read or burst.

Now looking more into SIU -- SIU-BCR(bus Configuration register=0x10024)
has EBM bit , i set that. Did'nt make any difference. :(

I want to ask -- To make SEC 1.0 as master do i have to do several other
modifications to the SIU configurations so that 60x bus mode is enabled
for internal master. Like PPC_ACR(0x10028)  has 4-7 bits as PRKM-parking
master and PPC_ACR=0100 stands for SEC engine.

-vikas


> On Tue, 9 Aug 2005 16:52:04 -0400 (EDT)
> "Vikas Aggarwal" <va824363@albany.edu> wrote:
>
>> The address returned by kmalloc=0x009ffc5c  is 4 byte aligned.
>> Are u advicing that dma_map_single() should return 8 byte aligned ,
>> becuase thats what gets written into the Data-Paclet_descriptor later.
>>
> I wouldn't worry about alignment as much as the register write trace and
> checking the System Interface Unit and individual eu status registers.
>
> --
> Kim
>
