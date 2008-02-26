Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69AD0DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 13:57:00 +1100 (EST)
Subject: Re: copy_from_user problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: maynardj@us.ibm.com
In-Reply-To: <47C36FBA.1030600@us.ibm.com>
References: <47C36FBA.1030600@us.ibm.com>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 13:56:39 +1100
Message-Id: <1203994599.15052.84.camel@pasglop>
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


On Mon, 2008-02-25 at 19:47 -0600, Maynard Johnson wrote:
> Hi,
> I'm developing a kernel module that needs to parse the in-memory ELF 
> objects for a shared library (libc, to be specific).  When running my 
> test on a 32-bit library, it works fine, but for a 64-bit library, the 
> very first copy_from_user() fails:
>     Elf64_Ehdr ehdr;
>     copy_from_user(&ehdr, location_of_lib, sizeof(Elf64_Ehdr);
> 
> I talked this over a bit with Will Schmidt.  He determined that 
> access_ok (being done as a result of copy_from_user) was failing, but we 
> don't know why.  I have 32-bit and 64-bit testcases that start up and 
> then pause, waiting for input.  We look at the entry for libc in 
> /proc/<pid>/maps, and the permissions are the same for both 32-bit and 
> 64-bit.
> 
> I've run this test on both a stock SLES 10 SP1 kernel and on 2.6.24. 
> I'm sure this is a user error, but for the life of me, I don't know what 
> I'm doing wrong.
> 
> Can anyone out there help?

I would have to look at the code.

Ben.
