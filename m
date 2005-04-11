Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 274D367B1A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2005 01:39:37 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D39@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D39@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ccf472df421e6d08840588571af40aaa@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 11 Apr 2005 10:39:20 -0500
To: Dan Malek <dan@embeddededge.com>,
	Fillod Stephane <stephane.fillod@thomson.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok,

After some debug on Friday and this weekend I understand what's going=20
on.  The reason we hit the code path in the kernel is due to the fact=20
that we are actually executing an integer load/store that is=20
misaligned, however when we read the instruction from memory we get a=20
float point instruction.  This is due to the fact that test app is not=20=

properly handling its self generated code.

Note, I was testing with math-emu turned on.

It seems to me that when we introduce CONFIG_PPC_FPU that we ifdef=20
around the code and return 0 in the 44x/e500 cases w/o FPUs

- kumar

On Apr 8, 2005, at 12:36 PM, Fillod Stephane wrote:

> Kumar Gala wrote:
>  > Are you running this via a ramdisk or nfs?=A0 If ramdisk can you =
post=20
> it
>
> > somewhere that I can get to?
>
> I'm running via NFS.
>
> > Also, can you email the list with the kernel oops that shows up.
>
> I'll do that next week.
>
> Anyway, reading the source suffices to realize there's a problem when
> MATH_EMULATION is disabled on a FPU-less system with user programs
> using load/store fp instructions.
>
> --=20
> Stephane
