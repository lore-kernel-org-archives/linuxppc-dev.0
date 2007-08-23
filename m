Return-Path: <jason.wessel@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id ED358DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:25:31 +1000 (EST)
Message-ID: <46CCFE2C.4050306@windriver.com>
Date: Wed, 22 Aug 2007 22:25:32 -0500
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Kgdb-bugreport] 2.6.23-rc3-mm1: kgdb build failure on powerpc
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>	<200708222104.29432.m.kozlowski@tuxland.pl>	<20070822124743.fc316963.akpm@linux-foundation.org>	<46CCBC3C.7010307@windriver.com>
	<20070822165318.b82da13c.akpm@linux-foundation.org>
In-Reply-To: <20070822165318.b82da13c.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kgdb-bugreport@lists.sourceforge.net, amitkale@linsyssoft.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> On Wed, 22 Aug 2007 17:44:12 -0500
> Jason Wessel <jason.wessel@windriver.com> wrote:
>
>   
>> +	while (!atomic_read(&debugger_active));
>>     
>
> eek.  We're in the process of hunting down and eliminating exactly this
> construct.  There have been cases where the compiler cached the
> atomic_read() result in a register, turning the above into an infinite
> loop.
>
> Plus we should never add power-burners like that into the kernel anyway. 
> That loop should have a cpu_relax() in it.  Which will also fix the
> compiler problem described above.
>
>   
Agreed, and fixed with a cpu_relax.

> Thirdly, please always add a newline when coding statements like that:
>
> 	while (expr())
> 		;
>   

The other instances I found of the same problem in the kgdb core are 
fixed too.

I merged all the changes into the for_mm branch in the kgdb git tree.

Thanks,
Jason.
