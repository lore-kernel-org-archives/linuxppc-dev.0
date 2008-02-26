Return-Path: <maynardj@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EF21DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 12:47:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1Q1ld13023615
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 20:47:39 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1Q1lcih101932
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 18:47:39 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1Q1lc9g026883
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 18:47:38 -0700
Received: from [127.0.0.1] (9-10-86-150.rchland.ibm.com [9.10.86.150])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1Q1lcxp026875
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 18:47:38 -0700
Message-ID: <47C36FBA.1030600@us.ibm.com>
Date: Mon, 25 Feb 2008 19:47:38 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: copy_from_user problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I'm developing a kernel module that needs to parse the in-memory ELF 
objects for a shared library (libc, to be specific).  When running my 
test on a 32-bit library, it works fine, but for a 64-bit library, the 
very first copy_from_user() fails:
    Elf64_Ehdr ehdr;
    copy_from_user(&ehdr, location_of_lib, sizeof(Elf64_Ehdr);

I talked this over a bit with Will Schmidt.  He determined that 
access_ok (being done as a result of copy_from_user) was failing, but we 
don't know why.  I have 32-bit and 64-bit testcases that start up and 
then pause, waiting for input.  We look at the entry for libc in 
/proc/<pid>/maps, and the permissions are the same for both 32-bit and 
64-bit.

I've run this test on both a stock SLES 10 SP1 kernel and on 2.6.24. 
I'm sure this is a user error, but for the life of me, I don't know what 
I'm doing wrong.

Can anyone out there help?

Thanks.
Maynard Johnson
LTC POWER Toolchain
