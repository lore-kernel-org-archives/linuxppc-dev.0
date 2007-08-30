Return-Path: <jason.wessel@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 9112ADDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 12:13:05 +1000 (EST)
Message-ID: <46D627B6.9060208@windriver.com>
Date: Wed, 29 Aug 2007 21:13:10 -0500
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: pete@bluelane.com
Subject: Re: [Kgdb-bugreport] 2.6.23-rc3-mm1: kgdb build failure on powerpc
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>	<200708222104.29432.m.kozlowski@tuxland.pl>	<20070822124743.fc316963.akpm@linux-foundation.org>	<46CCBC3C.7010307@windriver.com>
	<20070822165318.b82da13c.akpm@linux-foundation.org>
	<46CCFE2C.4050306@windriver.com>
	<46D604BF.7090905@bluelane.com> <46D61B21.1010703@bluelane.com>
In-Reply-To: <46D61B21.1010703@bluelane.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kgdb-bugreport@lists.sourceforge.net, amitkale@linsyssoft.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pete/Piet Delaney wrote:
> We are getting a problem with VMware where kernel text is the schedler
> is getting wacked with four null bytes into the code. Thought I'd use
> the current linux-2.6-kgdb.git tree and possible the CONFIG_DEBUG_RODATA
> patch to make kernel text readonly:
>
>  https://www.x86-64.org/pipermail/patches/2007-March/003666.html
>
> I thought the kernel text was RO and gdb had to disable it to
> insert a breakpoint.
>
>   

If you are going to make all the kernel text RO, then you are going to 
have to add some code to the kgdb write memory so as to unprotect a 
given page or all the breakpoint writes are going to fail.  
Alternatively you can use HW breakpoints.  But, I have no idea if your 
VM Ware simulated HW emulate HW breakpoint registers or not.

Jason.
