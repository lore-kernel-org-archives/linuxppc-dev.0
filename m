Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54AAE474C1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 22:44:23 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB4BhlFe028834
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Dec 2008 06:43:47 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB4BiIge182832
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Dec 2008 06:44:18 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB4CiRRS022775
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Dec 2008 07:44:28 -0500
Date: Thu, 4 Dec 2008 06:44:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "A. Nolson" <alohanono@gmail.com>
Subject: Re: Weird strings in kernel uname when cross-compiling
Message-ID: <20081204064414.3b72ba91@zod.rchland.ibm.com>
In-Reply-To: <4937C1D1.5010002@gmail.com>
References: <4937C1D1.5010002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 04 Dec 2008 12:41:05 +0100
"A. Nolson" <alohanono@gmail.com> wrote:

> Hi all,
> 
>  anybody knows why every time I cross-compile my kernel (Denx 4.2 
> cross-compiling chain ) I get an extra string in my vermagic like this
> 
> 2.6.24-rc3-gd7ed933b-dirty
> 
> when my kernel's ( secretlabs 2.6.24-rc3) makefile has this parameters:
> 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 24
> EXTRAVERSION = -rc3
> 
> (So no -gd7ed933b-dirty anywhere... )
> 
>  Having that is a bit annoying when I try to natively compile modules, 
> so I need to workaround it by copying  that extra string into my other 
> Makefiles. Anybody knows how to get rid of it?

It gets added on if you are building from a git repository and you have
CONFIG_LOCALVERSION_AUTO set.  Disable that and it should go away.

(BTW, a quick grep in the top level Makefile would have told you all
that.)

josh
