Return-Path: <kumar.gala@freescale.com>
Received: from motgate3.mot.com (motgate3.mot.com [144.189.100.103])
	by ozlabs.org (Postfix) with ESMTP id DADCE2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Nov 2004 03:27:25 +1100 (EST)
In-Reply-To: <NFBBJCNFKLFMBACPKDKCCEANELAA.jdomogala@acmepacket.com>
References: <NFBBJCNFKLFMBACPKDKCCEANELAA.jdomogala@acmepacket.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <28CBA210-34C4-11D9-8B98-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 12 Nov 2004 10:01:48 -0600
To: <jdomogala@acmepacket.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PowerPC MMU questions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 11, 2004, at 9:36 PM, Jeff Domogala wrote:

> Folks,
>
> I am dealing with a PowerPC 7455.=A0 Here is my understanding =
regarding=20
> the
>  MMU translation order:=A0 If the address is covered in a BAT, that =
BAT
> translation is in effect.=A0 If there is no BAT entry, then the page=20=

> tables
>  are used to translate the address.=A0 If there is no page table =
entry,=20
> an
>  exception is thrown and the exception handler for the miss needs to=20=

> add a
>  new PTE.=A0 So, correct me if I'm wrong in my translation.
>
> Now, The system starts up with BAT entries to get the system off the=20=

> ground.
>  I have equivalent BAT entries for the instruction and data sides.=A0 =
I=20
> also
>  have the L1 I and D caches on as well as the L2 cache (I and D=20
> mode).=A0 The
>  reason for using the BATs is to create non-cached I/O regions until=20=

> the MMU
>  PTEs are populated.=A0 Once the MMU PTEs are setup, the caches are=20
> flsuhed and
>  disabled, the MMU is disabled, the BATS disabled, the MMU re-enabled=20=

> and the
>  caches re-enabled.=A0 So here are my questions:
>
> 1. Is it ok to have the same I and D BAT entries?

Yes, the I-BAT will be used for translations on instruction fetches,=20
the D-BAT will be used on data accesses (ld/st instructions).

>  2. Is it ok to setup the initial MMU PTEs with the BATs enabled or=20
> should
>  the caches be disabled and MMU disabled during the PTE setup?

There should be no harm setting up MMU PTEs with BATs enabled, as you=20
said the BATs will take preference over the PTEs

>  3. Is there some other esource out there (mailing list or otherwise)=20=

> that I
>  should be addressing these questions to?

This is as good as any, assuming your using linux :)  Also, the=20
Freescale website has a number of App Notes on the various PPC MMUs and=20=

an email support address risc10@freescale.com

- kumar
