Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C1A97DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 02:51:09 +1100 (EST)
Message-ID: <45D9C764.1050400@am.sony.com>
Date: Mon, 19 Feb 2007 07:51:00 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: macros and dtc
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
In-Reply-To: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> After spending some time this weekend cleaning up dts files I figured  
> it would be nice if we can some to consensus on how we are going to  
> do macro support.  There is clearly a lot of duplication between  
> dts's and it only gets worse when you add in slight variations for  
> revs of boards.
> 
> I wasn't sure if we are thinking of using some style of preprocessor  
> (cpp, m4, etc..) or trying to add something into dtc itself.
> 
> However, I think it would be good for us to get some traction towards  
> a solution for in kernel dts files.

Based on the previous discussions, there were some concerns with using CPP
on the dts.  m4 is a nice preprocessor and I think that it sould be the
choice.

It would be good to have the kernel config available when running the
preprosessor, so that would mean running it from the makefile, not the
wrapper script.  It also seems then that having a different file extension
so the processing would fall naturally into a makefile target.

$(obj)/xyz.dts:	xyz.dts.m4
	$(call cmd,m4)


-Geoff
