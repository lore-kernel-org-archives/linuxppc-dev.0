Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E511FB6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 02:58:26 +1000 (EST)
In-Reply-To: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FD50883E-3CB5-48E7-B6AD-D6C33210B6EB@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Date: Tue, 29 Jun 2010 18:58:23 +0200
To: "Steve Deiters" <SteveDeiters@BASLER.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> These processors will corrupt data if accessing the local bus with
> unaligned
> addresses. This version fixes the typical case of copying from  
> Flash on
> the
> local bus by keeping the source address always aligned.

On many platforms accessing ROM as RAM simply doesn't work(*).  You  
shouldn't
map ROM as if it is RAM, and shouldn't use the same access functions  
on it.


Segher


(*) Example: any existing 970 system will checkstop as soon as you  
try to
do any cacheable access to some ROM.  Another example of course is  
unaligned
accesses on pretty much any system, no matter whether it's called a  
bug or
a feature on that system :-P
