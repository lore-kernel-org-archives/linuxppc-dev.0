Return-Path: <jimix@watson.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6FB567B9C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 20:44:44 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k79AifFP032251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 06:44:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k79AifAv305582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 04:44:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k79AiekD026132
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 04:44:41 -0600
In-Reply-To: <311550865236b8b45674.846930886.miltonm@bga.com>
References: <311550865236b8b45674.846930886.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F85E58BF-063E-4F25-85F0-C6741041E692@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [RFC] Debugging with a HW probe.
Date: Wed, 9 Aug 2006 06:44:38 -0400
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 8, 2006, at 9:22 PM, Milton Miller wrote:

> On Sun Aug  6 2006 09:42:16 AM CDT, Jimi Xenidis wrote:
>> On the XenPPC project we've been playing around with using GDB to
>> source debug Linux (and Xen) using a RiscWatch HW probe.
>
>> We have found it useful to teach xmon to make this call so we can  
>> then
>> debug the SW thru the probe. Is this useful to anyone else
>
> Since you only invoke the attention on command from the debugger, how
> is this better than just invoking the stop command from the probe?   
> Is it you
> are not dispatched out?  That you are not at a random point in the  
> input
> polling?

Thats exactly it!
If I get the probe to stop the CPU I could stop in the OS or in a  
user app.  Since we are working on Xen it could be Xen or any number  
of OSes or user apps on OSes.
When interrogating the machine state, the probe (almost) respects the  
modes of the CPU and MMU so memory accesses are translated (if xlate  
is on).  Since, probe "soft breakpoints" are ATTN instructions as  
well they get written into memory by the probe.

Having SW "call out" allows me to make sure that I'm in the address  
space I care about.
Since I only invoke it from xmon it assumes you have xmon support and  
to really be useful you need to SysReq to xmon.
I could be useful to make this part of SysReq, but I think we want to  
make sure that its use is entirely intentional.
You can also insert 'asm volatile(".long 0x200;nop");' in you own  
code or even add it to BUG()/panic() and skip the suffering the xmon/ 
SysReq trap.

BTW: I say "almost" because the probe does not respect the truncating  
of the upper bits when xlate is off and 0xC00... addresses are  
useless, we hacked the gdb stub to work around that.
BTW2: (I'm sure obvious to some), Since the probe writes ATTN  
instructions, I do not know what would happen if the probe wrote ATTN  
to an unmapped page, this is why debugging user space might be useless.
-JX
