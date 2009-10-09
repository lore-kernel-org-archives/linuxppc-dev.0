Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id BBC15B7B77
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Oct 2009 00:58:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Donald Kayser <linux@kayser.net>,
 linuxppc-dev@ozlabs.org
Subject: Re: ppc_md.SMI replacement for 2.6
Date: Fri, 9 Oct 2009 15:50:24 +0200
References: <61241B44-32BD-4708-954F-AEE7560382DE@kayser.net>
	<7AD77164-8476-4138-A390-B604CD18A221@kayser.net>
	<449C2FDE-42DD-490C-8288-CF03224BDA34@kayser.net>
In-Reply-To: <449C2FDE-42DD-490C-8288-CF03224BDA34@kayser.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200910091550.25032.arnd@arndb.de>
Cc: linuxkernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 09 October 2009, Donald Kayser wrote:
> On further comparison, this section of code has been added by the  
> vendor that actually ported linux 2.4 to this PPC HPPB target. So, if  
> anyone would like to lend a thought towards System Managment  
> Exceptions on PPC, please cc me at linux@kayser.net. I will be  
> stopping the subscription to this list shortly. Regards, Donald

Hi Donald,

You should ask ppc specific questions on the linuxppc-dev@ozlabs.org
mailing list instead of the global linux-kernel list to increase the
chances of someone reading it who knows the answer.

The world of powerpc linux has changed a lot since 2.4, as you
undoubtedly found out. You are certainly encouraged to submit
your platform code for inclusion in the mainline kernel (if you
can do the usual cleanups necessary to do that), even for
old code.

I don't know a specific reason why the SMI callback was removed,
but I would guess that if you have a platform that requires it
and want it in the mainline kernel, a callback for it can be
added back, either through ppc_md or some other method.

	Arnd <><

> On Oct 8, 2009, at 8:37 AM, Donald Kayser wrote:
> 
> > I have found the differences between the 2.4 and 2.6 kernel. It is  
> > in linux-2.4/arch/ppc/kernel/traps.c and linux-2.6/arch/powerpc/ 
> > kernel/traps.c in the function SMIException(). There is no longer  
> > the code segment
> >
> > if (ppc_md.SMI)
> > {
> >  ppc_md.SMI(regs);
> >  return;
> > }
> >
> > There is now only a
> >
> > die("System Management Interrupt", regs, SIGABRT);
> >
> > I am guessing that the SMI callback is no longer needed by the linux  
> > community at large, so I modified the code for my specific hardware  
> > (HPPB) and acknowledged the exception as in the 2.4 kernel, and  
> > returned from the exception without the call to die(). My problem  
> > now is that it doesn't seem to work. Does anyone have a reason why  
> > the SMI exception might hang the system when it has been provided a  
> > handler?
> >
> > Thanks in advance.
> >
> > Donald Kayser
> >
> > On Oct 7, 2009, at 10:06 AM, Donald Kayser wrote:
> >
> >> I have ported the 2.6 kernel to an embedded PPC target (old stuff).  
> >> I have managed to figure everything out, but can't find any  
> >> replacement for a SMI handler. The original 2.4 version for this  
> >> target has a bit of code ppc_md.SMI == SmiFuncHandler; I have not  
> >> been able to find in the current source anything like this. I am  
> >> not certain that I need to provide a handler at all, but the  
> >> original developers saw some reason for including it. The  
> >> particular handler does not do anything more than cancel a watchdog  
> >> listener for this specific target. I have been living without the  
> >> handler, but would like to find any kind of replacement if it is  
> >> supported.
> >>
> >> Thanks,
> >> Donald Kayser
> >> linux@kayser.net
