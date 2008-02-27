Return-Path: <maynardj@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C423DDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:28:05 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1RCS1MH002154
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 07:28:01 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1RCS15H207444
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 05:28:01 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1RCS1xn013956
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 05:28:01 -0700
Message-ID: <47C5574D.2090409@us.ibm.com>
Date: Wed, 27 Feb 2008 06:27:57 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: copy_from_user problem
References: <47C36FBA.1030600@us.ibm.com> <1203994599.15052.84.camel@pasglop>
	<47C426F8.7070203@us.ibm.com> <1204068146.15052.188.camel@pasglop>
In-Reply-To: <1204068146.15052.188.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-02-26 at 08:49 -0600, Maynard Johnson wrote:
>   
>> 2. Compile C program as 32-bit; then run it.  While the program is 
>> waiting for input, obtain its PID and do 'cat /proc/<pid>/maps' to
>> get 
>> the address of where libc is loaded.
>> 3. From the dir where you build the uaccess_test kernel module:
>>          'insmod ./uaccess_test.ko lib_addr=0x<mem_loc_libc>'
>>     This should succeed.  dmesg to verify.
>> 4. Unload the module.
>> 5. Recompile your C program with -m64; start it up and obtain the 
>> address of libc again (now a 64-bit address).
>> 6. Load the uaccess_test kernel module and pass 
>> 'lib_addr=0x<mem_loc_libc>'.  Note that this time, the load fails. 
>> dmesg to see debug printk's.
>>     
>
> Sounds to me that your kernel module will try to copy_from_user() from
> the user context of ... insmod :-)
>   
Yeah, that's probably the problem (along with my lack of understanding 
how VM works  -- heh).  I guess I was just getting lucky with the 32-bit 
test in that the 32-bit libc was being loaded for my insmod process at 
the same virtual memory address as for my C test program.
> You need to do your copy_from_user() from within the context of the
> program you try to access the memory from !
>   
Can't do that in the "real" code I'm developing, so I guess I'll need to 
use get_user_pages.  Hmmm . . . not quite as simple to use as 
copy_from_user, and I don't see any doc on it.  But at least I've found 
a couple examples in the kernel tree.
> If you need to access another context than the current one, you then
> need to use a different mechanism, such as get_user_pages(), though
> beware that you can only do that for memory, not SPE local store or
> register mappings.
>   
The "real" code I'm developing is targeted at POWER, not Cell.

Thanks, Ben!

-Maynard
> Ben.
>
>
>   
