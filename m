Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98BA6DDED2
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 07:01:11 +1000 (EST)
Received: from e1.ny.us.ibm.com ([192.168.1.101])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m4TKne1F013711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:49:40 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TKf2lO006894
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:41:02 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4TKf2JW136894
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:41:02 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4TKf1xF005025
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:41:01 -0400
Date: Thu, 29 May 2008 15:34:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] Move to runtime allocated exception stacks
Message-ID: <20080529153441.0718e499@zod.rchland.ibm.com>
In-Reply-To: <1211259767-4796-1-git-send-email-galak@kernel.crashing.org>
References: <1211259767-4796-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 May 2008 00:02:45 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> For the additonal exception levels (critical, debug, machine check) on
> 40x/book-e we were using "static" allocations of the stack in the
> associated head.S.
> 
> Move to a runtime allocation to make the code a bit easier to read as
> we mimic how we handle IRQ stacks.  Its also a bit easier to setup the
> stack with a "dummy" thread_info in C code.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Fixed 40x handling based on Josh's feedback and help.

I tested this series on 44x and 40x today.  Both boot up and function
normally.  GDB is able to set breakpoints, single step, and operate as
well as it normally does.

Again, no hard stress testing but it does appear to work.

josh
