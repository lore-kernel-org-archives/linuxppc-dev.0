Return-Path: <miltonm@bga.com>
In-Reply-To: <1177684950.24866.121.camel@luke-laptop>
References: <1177626236.24866.99.camel@luke-laptop> ,
	<1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177684950.24866.121.camel@luke-laptop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cac5fb599f53a436995c6ca37b46605e@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v3] powerpc: 64K page support for kexec
Date: Fri, 27 Apr 2007 11:51:36 -0500
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 27, 2007, at 9:42 AM, Luke Browning wrote:
> On Thu, 2007-04-26 at 23:36 -0500, Milton Miller wrote:
>> It appears the distros want to use a similar kernel for
>> their dump kernel.  The would prefer it be the same binary;
>> I'm trying to influence people that it is a softer requirement
>> than not slowing down the primary kernel.
>
> Here's anon-related question.  What is the pSeries strategy for
> automating the capture of the dump image and rebooting to a usable
> kernel.  Has anybody provided a customized initrd for this purpose that
> ultimately reboots the system to the default kernel. Seems like that is
> more important in terms of minimizing downtime than inlining a 
> function.

I'm not involved directly, but my understanding is the distros are
planning to use kdump and makedumpfile or similar, save it to
disk or network, then call the platform reboot (for pSeries, that
would be RTAS).  The platform would then be responsible for all
cleanup and reinitializing the new kernel.

So the page-table clear is part of the path to capture the dump.

>> I think a better way to debug this code is to call it from a
>> debugfs hook or xmon dump command to scan the table and do
>> the computation.  That code would have the full debugger to
>> notice and print the assert.
>
> I am not familiar with debugfs but I suspect that wasn't an option,
> because the system hung immediately.  xmon was not invoked either.

Referring to when you put the trap after the table?   Yes I would
expect it to hang, the 700 program check will bounce to 400,
which will then bounce repeatedly against instruction miss.

The point was to check if you could take down the table before
actually taking it down.  xmon uses the kernel virtual mappings.

>> Having a xmon function to dump the hash table or a slot
>> might be useful for other purposes.
>>
>
> agreed.
>
>> If you think you need the assert, then I ask it be put under
>> an ifdef or it not be triggered when kexec is called with
>> panic=1  (ie BUG_ON(x && !panic).  Alternatively you could
>> run the table with dry-run sometime between cpu_down and the
>> kernel copy.
>
> That is a good idea.  That way, people can use kexec -l to debug.
>
>>>> Appart from that,
>>>>
>>>> Acked-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
>>>>
>>
>> milton
>>
>
