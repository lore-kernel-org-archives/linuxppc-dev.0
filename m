Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C65ED67A3E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 05:14:19 +1000 (EST)
Date: Thu, 14 Sep 2006 12:14:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <17671.64971.450232.870486@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0609141208510.4388@g5.osdl.org>
References: <17671.64971.450232.870486@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 13 Sep 2006, Paul Mackerras wrote:
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

Hmm. I'm not at all sure this pull caused the problem, and it may have 
started long before, but right now I have problems printing on my G5 
machine. 

I'll get around to trying to bisect it at some point, but before I even 
start, I should probably check if anybody recognizes this immediately.

I blamed cupsd at first, because the problem ends up being that it just 
hangs in running state, and I just assumed it was broken user space as 
usual. But straceing the dang thing shows something strange, like this:

	...
	time(NULL)                              = 1024 <0.000009>
	select(1024, [7 8 9 10 11 12 13 14], [], NULL, {1, 0}) = 0 (Timeout) <0.000006>
	time(NULL)                              = 1024 <0.000006>
	select(1024, [7 8 9 10 11 12 13 14], [], NULL, {1, 0}) = 0 (Timeout) <0.000004>
	time(NULL)                              = 1024 <0.000007>
	select(1024, [7 8 9 10 11 12 13 14], [], NULL, {1, 0}) = 0 (Timeout) <0.000006>
	time(NULL)                              = 1024 <0.000007>
	select(1024, [7 8 9 10 11 12 13 14], [], NULL, {1, 0}) = 0 (Timeout) <0.000005>
	...

which actually looks like something is broken (it says timeout in 5 
microseconds, even though the timeout structure is shown as being one 
second).

Now, it's entirely possible that the _broken_ thing is actually strrace 
itself (that return value from "time()" looks a bit strange too), and that 
it's some tracing problem with rinning 32-bit programs on a 64-bit kernel.

But I thought I'd ask if somebody recognizes this before I start wasting 
any more time on it..

		Linus
