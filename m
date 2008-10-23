Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 15AF0DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 22:57:47 +1100 (EST)
Received: by gxk7 with SMTP id 7so1592776gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 04:57:46 -0700 (PDT)
Date: Thu, 23 Oct 2008 07:56:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix error path in kernel_thread function
Message-ID: <20081023115604.GA2206@yoda.jdub.homelinux.org>
References: <20081007161003.GA5727@yoda.jdub.homelinux.org>
	<18669.29473.856007.689260@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18669.29473.856007.689260@cargo.ozlabs.ibm.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, jpoimboe@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 01:57:37PM +1100, Paul Mackerras wrote:
>Josh Boyer writes:
>
>> From: Josh Poimboeuf <jpoimboe@us.ibm.com>
>> 
>> The powerpc 32-bit and 64-bit kernel_thread functions don't properly
>> propagate errors being returned by the clone syscall.  (In the case of
>> error, the syscall exit code returns a positive errno in r3 and sets
>> the CR0[SO] bit.)
>> 
>> This patch fixes that by negating r3 if CR0[SO] is set after the syscall.
>> 
>> Signed-off-by: Josh Poimboeuf <jpoimboe@us.ibm.com>
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
>Acked-by: Paul Mackerras <paulus@samba.org>

Should we send this patch to -stable for 2.6.27?  Seems valid enough to
do so.

josh
