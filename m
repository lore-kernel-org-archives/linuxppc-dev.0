Return-Path: <hollis@penguinppc.org>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF9D067A71
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 05:25:20 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.esmtp.ibm.com [9.14.4.129])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j1MFuDZR022497
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 10:56:14 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j1MFu6ua185982
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 10:56:06 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1MFu6Ib145122
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 08:56:06 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1MFu50m016719
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 08:56:05 -0700
In-Reply-To: <20050222130646.25bc9520.sonic_amiga@rambler.ru>
References: <20050222121809.351088dc.sonic_amiga@rambler.ru>
	<20050222093208.GE27891@gate.ebshome.net>
	<20050222130646.25bc9520.sonic_amiga@rambler.ru>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <efde43ce0c064cc8699fd850d594c7f1@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Tue, 22 Feb 2005 09:56:03 -0600
To: Pavel Fedin <sonic_amiga@rambler.ru>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Non-DMA mode for floppy on PowerPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 22, 2005, at 12:06 PM, Pavel Fedin wrote:

> On Tue, 22 Feb 2005 01:32:09 -0800
> Eugene Surovegin <ebs@ebshome.net> wrote:
>
>> Please, be patient and don't repost the same stuff every day.
>
>  Ok. How long does it take for a patch to get included into the 
> kernel? I posted if two weeks ago for the first time and nothing 
> happened. In LKML also nobody answers.

That generally means nobody cares (don't worry, we've all been there).

In your case, I would start by very clearly describing exactly why you 
can't use DMA on Pegasos, and why the current code is unusable. Can a 
PC floppy run in non-DMA mode? If so, your patch should probably be for 
floppy.c rather than asm-ppc/floppy.h . I notice there is already code 
for "virtual DMA mode" in floppy.c, apparently for when there is no 
memory available in the DMA zone. Why doesn't that code work for you?

As for code style, it seems that "TRACE_FLPY_INT" is something you 
invented. It hurts readability; I'd remove it. Drop that "register" 
stuff. Make your whitespace consistent (for example, add spaces after 
"if" and "for").

-Hollis
