Return-Path: <cel@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0FC8DE0CF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 00:52:22 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FEqJ3o016278
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 10:52:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FEqJ7k097302
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:52:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FEqInv020821
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:52:19 -0600
Subject: Re: [patch 1/4] powerpc: fix for OProfile callgraph for Power 64
	bit user apps
From: Carl Love <cel@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18475.46317.936165.577835@cargo.ozlabs.ibm.com>
References: <200805142312.m4ENCqLg026256@imap1.linux-foundation.org>
	<1210810844.7603.17.camel@localhost>
	<18475.46317.936165.577835@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 15 May 2008 07:50:08 -0700
Message-Id: <1210863008.7726.129.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, carll@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-15 at 13:58 +1000, Paul Mackerras wrote:
> Michael Ellerman writes:
> 
> > __copy_from_user_inatomic() accepts any value for n, it just has a
> > special case for 1, 2, 4 and 8 - but it should still work for other
> > values.
> 
> There is a bug in __copy_from_user_inatomic that
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=18418
> 
> fixes, and I'm about to send that Linus-wards.
> 
> Carl, to what extent does that fix eliminate the need for the changes
> in your patch?
> 
> Paul.

Paul:

I will have to apply the above mentioned patch to see if it fixes the
issue.  What I found was when the original code tried to copy three
unsigned long into stack_frame[3], i.e. 24 bytes my system consistently
failed.  The comment about 48 bytes is a note that is all that is
guaranteed to be there according to the API.  I found by restricting the
copy to the values in the case statement, things worked.  

              Carl Love
