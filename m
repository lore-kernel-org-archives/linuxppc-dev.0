Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C58D12BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Dec 2004 05:27:37 +1100 (EST)
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647403@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A647403@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <A1E3B6C2-5690-11D9-A059-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sat, 25 Dec 2004 10:18:37 -0600
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: seeking advise on porting custom PPC platform (in my case it is
	variant of 8xx ) from Linux 2.4.(.26) to Linux 2.6(.10-rc3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex,

Its my understanding that code moved out of arch/ppc/platforms and=20
arch/ppc/kernel in 2.4 into arch/ppc/syslib.  The code in 'syslib'=20
deals with items that are not directly related with the CPU cores=20
(arch/ppc/kernel) or with board issues (arch/ppc/platforms).  Any code=20=

that is generic for a number of systems should be in arch/ppc/syslib. =20=

So code managing pci, interrupt controllers, generic system setup, etc=20=

lives in arch/ppc/syslib.

The transition predates my work with 2.6, I would guess that Paul M.=20
was influential in this change.

If you are just doing a board port then your files should end up in=20
arch/ppc/platforms.  It should be rare that you would need to touch=20
anything in arch/ppc/syslib.

- kumar

On Dec 24, 2004, at 11:05 AM, Povolotsky, Alexander wrote:

> Hi,
>
> In Linux 2.6 I see the new directory arch/ppc/syslib, which does not=20=

> exist
>  in Linux 2.4(.26).
>  I would GREATLY APPRECIATE if Tom or Dan (or someone else) could=20
> explain
>  what are the reasons for creating this new directory and describe on=20=

> what
>  basis existing
>  Linux 2.4 files went there and why=A0 ...
> and if there any new files (vs Linux 2.4) were created in that new=20
> directory
>  ?=A0
>
>  In general, I am seeking advise on porting PPC platform
>  (in my case it isvariant of 8xx ) from Linux 2.4.(.26) to Linux
>  2.6(.10-rc3).
>  =A0Did anyone created howto document on this subject ?
>
> Thanks,
>
> Alex
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
