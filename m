Return-Path: <cel@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32CCEDE177
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 02:34:17 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4GGYCC7012615
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 12:34:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4GGYCPo154944
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 12:34:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4GGYCtt008937
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 12:34:12 -0400
Subject: Re: [PATCH] Fix for OProfile callgraph for Power 64 bit user apps
From: Carl Love <cel@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1210874462.20791.54.camel@carll-linux-desktop>
References: <1210183924.7726.28.camel@carll-linux-desktop>
	<18476.5290.709729.582063@cargo.ozlabs.ibm.com>
	<1210874462.20791.54.camel@carll-linux-desktop>
Content-Type: text/plain
Date: Fri, 16 May 2008 09:32:03 -0700
Message-Id: <1210955523.20791.193.camel@carll-linux-desktop>
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


On Thu, 2008-05-15 at 11:01 -0700, Carl Love wrote:
> On Thu, 2008-05-15 at 20:47 +1000, Paul Mackerras wrote:
> > Carl Love writes:
> > 
> > > The following patch fixes the 64 bit user code backtrace 
> > > which currently may hang the system.  
> > 
> > What exactly is wrong with it?
> > 
> > Having now taken a much closer look, I now don't think Nate Case's
> > patch addresses this, since it only affects constant size arguments
> > <= 8 to copy_{to,from}_user_inatomic.
> > 
> > However, I don't see why your patch fixes anything.  It means we do
> > two access_ok calls and two __copy_from_user_inatomic calls, for 8
> > bytes, at sp and at sp + 16, rather than doing one access_ok and
> > __copy_from_user_inatomic for 24 bytes at sp.  Why does that make any
> > difference (apart from being slower)?
> > 
> > Paul
> 
> When I tried testing the oprofile call graph on a 64 bit app the system
> consistently hung.  I was able to isolate it to the
> __copy_from_user_inatomic() call.  When I made the change in my patch to
> make sure I was only requesting one of the values (8bytes) listed in the
> case statement this fixed the issue.  I do not know nor was I able to
> figure out why the __copy_from_user_inatomic() call failed trying to
> read 24 bytes.  The system would hang and any attempt to use printk to
> see what was going on failed as the output of the print would not go to
> the console before the system hangs.  
> 
> I backed out my patch, put in Nate's patch.  The call graph test ran
> fine.  I then backed out Nate's patch to go back and try to re-validate
> that the system still hangs with the original code and it is not
> hanging.  Not sure why it now seems to work.  I have done some other
> work on the system but I don't see how that would have changed this.
> Argh, I hate chasing phantom bugs!  I was working on 2.6.21. I believe
> the 2.6.21 kernel had not been changed. Let me load the latest 2.6.25
> and start over with a pristine kernel and see if I can reproduce the
> hang.  Sorry for all the hassle.
> 
>                  Carl Love
> 

I installed the latest 2.6.25 kernel and tested OProfile call graph on
the 64 bit user application.  I did not see any hangs for the tests that
I ran.  I tried things multiple times.  So, I guess we should drop the
OProfile callgraph patch.  Clearly if there still is a problem it is not
in how the OProfile call graph code is written but is probably in the
underlying calls, i.e. __copy_from_user_inatomic().  I will continue to
test the functionality and see if I can find a example where the system
will hang so we can investigate the underlying cause.

Thank you for your time on this. 

               Carl Love
