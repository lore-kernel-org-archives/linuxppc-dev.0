Return-Path: <ashwin.tanugula@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 5BA3267A6B
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2005 05:15:19 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so211035wra
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 11:15:18 -0800 (PST)
Message-ID: <838f7c5005033011157895e746@mail.gmail.com>
Date: Wed, 30 Mar 2005 14:15:17 -0500
From: ashwin tanugula <ashwin.tanugula@gmail.com>
To: Brad Boyer <flar@allandria.com>
In-Reply-To: <20050330072558.GA13087@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <838f7c50050329170146631318@mail.gmail.com>
	<20050330072558.GA13087@pants.nu>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ptrace and ORIG_EAX on ppc
Reply-To: ashwin tanugula <ashwin.tanugula@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Mar 2005 23:25:58 -0800, Brad Boyer <flar@allandria.com> wrote:
> On Tue, Mar 29, 2005 at 08:01:06PM -0500, ashwin tanugula wrote:
> > Hi!
> > Can somebody tell me how to set references to ORIG_EAX in ppc kernel.
> > We know ORIG_EAX is defined in unistd.h of i386. How do i make the
> > following program print two same pids in ppc?
> 
> The ORIG_EAX is a reference to a register as saved in the stack. The
> equivalent on ppc would seem to be PT_ORIG_R3. You're digging around
> in an area that is extremely non-portable. This program appears to
> be messing around with the syscall number before dispatch in the
> syscall table. The implementation of ptrace on ppc and ppc64
> explicitly does not allow changing this value, so I think you'll need
> to find a completely different way to achieve your desired result.
> 
> Just to lessen the confusion, what are you trying to accomplish? Not
> in the low-level detail sense, but what is the big picture goal?
> 
>         Brad Boyer
>         flar@allandria.com
> 
> 
Hi,
Thanks to Brad for his help.
ORIG_EAX has to be changed to PT_R0 not to PT_ORIG_R3.
The output i got after changing ORIG_EAX to PT_R0 is
root@slemieux:/home/ashwin # gcc ptrace_test.c
root@slemieux:/home/ashwin # ./a.out
Parent pid = 16682
getpid() returned 16682
getpid() returned 16682

--Ashwin.
