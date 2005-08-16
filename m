Return-Path: <dje@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4DB667F5E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 14:03:26 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.13.1/8.13.1/8.13.1-2005-04-25 igw) with ESMTP
	id j7G44wd7004682
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 00:04:58 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id j7G43M8111174
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 00:03:22 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id j7G43L3111172
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 00:03:21 -0400
Message-Id: <200508160403.j7G43Hd29692@makai.watson.ibm.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: Message from Kumar Gala <kumar.gala@freescale.com> of "Mon,
	15 Aug 2005 22:41:03 CDT."
	<473FD762-FB04-4B63-93E9-11931492AC60@freescale.com>
References: <17153.8284.3721.188488@cargo.ozlabs.ibm.com>
	<473FD762-FB04-4B63-93E9-11931492AC60@freescale.com>
Date: Tue, 16 Aug 2005 00:03:16 -0400
From: David Edelsohn <dje@watson.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org
Subject: Re: CONFIG_FRAME_POINTER on ppc/ppc64? 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> Kumar Gala writes:

>> Because -fomit-frame-pointer and -fno-omit-frame-pointer have no
>> effect on ppc or ppc64, I assume. :)

Kumar> I'm assuming that's a guess.  The reason I ask that is my memory  
Kumar> serves correctly r31 is used as the frame pointer if compiled that  
Kumar> way.  Maybe some GCC expert can chime in.  I'll copy David Edelsohn  
Kumar> and see if I get a response :)

	I am missing some context here.  On both 32-bit PowerPC Linux
(PowerPC SVR4) and 64-bit PowerPC Linux, GPR r31 is used as the frame
pointer.  PowerPC does not have a dedicated frame pointer and the PowerPC
ABI does not require an independent frame pointer in a function at all
times, so it can be omitted by default.  If the frame pointer is not
referenced for any unique needs, uses of the frame pointer are adjusted to
reference the stack pointer.  GCC only retains the PowerPC frame pointer
when dynamic stack allocation (alloca) is used within a function.
-fomit-frame-pointer has no effect on PowerPC because it is enabled by
default.

David
