Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6A2267A64
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 04:16:08 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <074219cef09e4112ab23d9168d881517@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 31 Mar 2005 13:15:57 -0500
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2005, at 12:47 PM, Fillod Stephane wrote:

> When CPU has no (classic) FPU, and math emulation is disabled,
> fp instructions are not allowed in kernel mode.

FP Instructions are never allowed in kernel mode regardless of the CPU.
However, with math emulation disabled and no FPU, we still emulate
FP load/store operations because they are usually hard coded in
some of the context save/restore functions of the C library.

> This bug has been found with crashme (crash01) of LTP, on a e500 
> system.

What is the bug?  This patch disables a big feature we have been
using for many years.  Please take another look at this.

Thanks.


	-- Dan
