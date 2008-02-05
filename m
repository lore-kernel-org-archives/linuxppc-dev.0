Return-Path: <chirag@linux.vnet.ibm.com>
Received: from e28esmtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13AA5DDE04
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 20:08:34 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m1597iMH022871
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 14:37:44 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1597hPM802872
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 14:37:43 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m1597hGU023661
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 09:07:43 GMT
Date: Tue, 5 Feb 2008 14:37:42 +0530
From: Chirag Jog <chirag@linux.vnet.ibm.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] [POWERPC] Use a sensible default for clock_getres() in
	the vdso.
Message-ID: <20080205090742.GA11087@linux.vnet.ibm.com>
References: <200801271932.59823.sripathik@in.ibm.com>
	<20080205051648.GX6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20080205051648.GX6887@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, Sripathi Kodi <sripathik@in.ibm.com>,
	paulus@samba.org, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Tony Breeds <tony@bakeyournoodle.com> [2008-02-05 16:16:48]:

> On Sun, Jan 27, 2008 at 07:32:59PM +0530, Sripathi Kodi wrote:
> > Hi Paul,
> > 
> > On PPC, I see a disparity between clock_getres implementations in the
> > vdso and syscall. I am using a IBM Openpower hardware and 2.6.24 kernel
> > with CONFIG_HIGH_RES_TIMERS=y. 
> > 
> > clock_getres call for CLOCK_REALTIME returns 1 millisecond. However,
> > when I edit arch/powerpc/kernel/vdso*/gettimeofday.S to force it to use 
> > sys_clock_getres, I get 1 nanosecond resolution. The code in vdso seems
> > to be returning some pre-defined (incorrect) variables.
> > 
> > Could you please let me know the reason for this? Is it something that
> > should be fixed in vdso?
> 
> Can you try the attached patch and see it if works for you?
I tried this patch.
It seems to solve the reported problem and give a 1ns resolution.
Thanks.
 

-- 
Cheers,
Chirag Jog
