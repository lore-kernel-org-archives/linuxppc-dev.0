Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7CD79DDFF6
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:16:55 +1000 (EST)
Message-ID: <46F2B8D7.4080006@ru.mvista.com>
Date: Thu, 20 Sep 2007 22:15:51 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC: add setup_cpu for 44x for processor-specific init
References: <200709201732.l8KHWuGA035995@sullivan.realtime.net>	<20070920175558.GA3191@ru.mvista.com>
	<20070920131336.58df01e7@weaponx.rchland.ibm.com>
In-Reply-To: <20070920131336.58df01e7@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 20 Sep 2007 21:55:58 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> This adds cpu_setup functionality to PowerPC 44x platform.
>> The cpu_setup callback is invoked by head_32 code and 
>> the identify_cpu() function at early init and is used to 
>> initialize FPU on 440EP(x) processors. The FPU initialization 
>> was previously done in head_44x.S. Also a workaround for 
>> the incorrect write to DDR SDRAM 440EPx/440GRx errata added.
>> Data can be written to wrong address in SDRAM when write 
>> pipelining is enabled on plb0. The setup_cpu function
>> for these processors disables write pipelining.
> 
> Wow, you're fast ;)
> 
> I'd like to see this split up a bit so there's not so much in one
> patch.  Essentially, introduce cpu_setup_44x.S, move the FPU init to
> use it, and then add the PLB workaround.

OK

> 
> I still need to look at the code too :)

sure :)

> 
> josh

Thanks,
Valentine.
