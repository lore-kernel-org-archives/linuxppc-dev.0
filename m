Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F9EB474C3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 01:27:03 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9EQNrK003874
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 09:26:24 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9EQwXk2224190
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 09:26:59 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9EQtMq020895
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 07:26:55 -0700
Date: Tue, 9 Dec 2008 09:26:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 1/5] powerpc: booke: Don't hard-code size of struct tlbcam
Message-ID: <20081209092649.1d262327@zod.rchland.ibm.com>
In-Reply-To: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon,  8 Dec 2008 19:34:55 -0800
Trent Piepho <tpiepho@freescale.com> wrote:

> Some assembly code in head_fsl_booke.S hard-coded the size of struct tlbcam
> to 20 when it indexed the TLBCAM table.  Anyone changing the size of struct
> tlbcam would not know to expect that.
> 
> The kernel already has a system to get the size of C structures into
> assembly language files, asm-offsets, so let's use it.
> 
> The definition of the struct gets moved to a header, so that asm-offsets.c
> can include it.

I don't mean to be overly picky, but your patch subjects and changelog
descriptions are a bit wrong.  This series pertains to FSL BookE chips,
not BookE in general.  There are other variants of BookE, such as 4xx.

If you could keep that in mind for future revisions, I'd appreciate
it.  Something like:

[PATCH] powerpc/fsl-booke: 

or something similar would be a bit more correct.  Unless you really
are changing something global to all BookE processors (which is sort of
rare at the moment).

josh
