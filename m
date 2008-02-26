Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6B0FDDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 10:23:16 +1100 (EST)
Subject: Re: copy_from_user problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: maynardj@us.ibm.com
In-Reply-To: <47C426F8.7070203@us.ibm.com>
References: <47C36FBA.1030600@us.ibm.com>
	<1203994599.15052.84.camel@pasglop>  <47C426F8.7070203@us.ibm.com>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 10:22:26 +1100
Message-Id: <1204068146.15052.188.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-26 at 08:49 -0600, Maynard Johnson wrote:
> 2. Compile C program as 32-bit; then run it.  While the program is 
> waiting for input, obtain its PID and do 'cat /proc/<pid>/maps' to
> get 
> the address of where libc is loaded.
> 3. From the dir where you build the uaccess_test kernel module:
>          'insmod ./uaccess_test.ko lib_addr=0x<mem_loc_libc>'
>     This should succeed.  dmesg to verify.
> 4. Unload the module.
> 5. Recompile your C program with -m64; start it up and obtain the 
> address of libc again (now a 64-bit address).
> 6. Load the uaccess_test kernel module and pass 
> 'lib_addr=0x<mem_loc_libc>'.  Note that this time, the load fails. 
> dmesg to see debug printk's.

Sounds to me that your kernel module will try to copy_from_user() from
the user context of ... insmod :-)

You need to do your copy_from_user() from within the context of the
program you try to access the memory from !

If you need to access another context than the current one, you then
need to use a different mechanism, such as get_user_pages(), though
beware that you can only do that for memory, not SPE local store or
register mappings.

Ben.
