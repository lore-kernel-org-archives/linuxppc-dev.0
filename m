Return-Path: <rsa@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56831DE0E7
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 01:59:08 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2EEuO8R012745
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 10:56:24 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2EEx4UR054260
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 10:59:04 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2EEx4Po030887
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 10:59:04 -0400
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
From: Ryan Arnold <rsa@us.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
	<FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 09:58:59 -0500
Message-Id: <1237042739.8874.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-03-14 at 14:49 +0100, Segher Boessenkool wrote:
> > Another option might be simply to say that if an app has used FP,  
> > VMX or
> > VSX -once-, then it's likely to do it again and just keep re-enabling
> > it :-)
> >
> > I'm serious here, do we know that many cases where these things are  
> > used
> > seldomly once in a while ?
> 
> For FP, I believe many apps use it only sporadically.  But for VMX  
> and VSX,
> yeah, it might well be optimal to keep it enabled all the time.  Someone
> should do some profiling...

We can do some VMX testing on existing POWER6 machines.  The VSX
instruction set hasn't been fully implemented in GCC yet so we'll need
to wait a bit for that.  Does anyone have an idea for a good VMX/Altivec
benchmark?

Ryan
