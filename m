Return-Path: <cel@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06D74DDFA6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 04:03:25 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FI03hL006233
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 14:00:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FI3GX4023866
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 12:03:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FI3Csh000365
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 12:03:12 -0600
Subject: Re: [PATCH] Fix for OProfile callgraph for Power 64 bit user apps
From: Carl Love <cel@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18476.5290.709729.582063@cargo.ozlabs.ibm.com>
References: <1210183924.7726.28.camel@carll-linux-desktop>
	<18476.5290.709729.582063@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 15 May 2008 11:01:01 -0700
Message-Id: <1210874462.20791.54.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-15 at 20:47 +1000, Paul Mackerras wrote:
> Carl Love writes:
> 
> > The following patch fixes the 64 bit user code backtrace 
> > which currently may hang the system.  
> 
> What exactly is wrong with it?
> 
> Having now taken a much closer look, I now don't think Nate Case's
> patch addresses this, since it only affects constant size arguments
> <= 8 to copy_{to,from}_user_inatomic.
> 
> However, I don't see why your patch fixes anything.  It means we do
> two access_ok calls and two __copy_from_user_inatomic calls, for 8
> bytes, at sp and at sp + 16, rather than doing one access_ok and
> __copy_from_user_inatomic for 24 bytes at sp.  Why does that make any
> difference (apart from being slower)?
> 
> Paul

When I tried testing the oprofile call graph on a 64 bit app the system
consistently hung.  I was able to isolate it to the
__copy_from_user_inatomic() call.  When I made the change in my patch to
make sure I was only requesting one of the values (8bytes) listed in the
case statement this fixed the issue.  I do not know nor was I able to
figure out why the __copy_from_user_inatomic() call failed trying to
read 24 bytes.  The system would hang and any attempt to use printk to
see what was going on failed as the output of the print would not go to
the console before the system hangs.  

I backed out my patch, put in Nate's patch.  The call graph test ran
fine.  I then backed out Nate's patch to go back and try to re-validate
that the system still hangs with the original code and it is not
hanging.  Not sure why it now seems to work.  I have done some other
work on the system but I don't see how that would have changed this.
Argh, I hate chasing phantom bugs!  I was working on 2.6.21. I believe
the 2.6.21 kernel had not been changed. Let me load the latest 2.6.25
and start over with a pristine kernel and see if I can reproduce the
hang.  Sorry for all the hassle.

                 Carl Love
