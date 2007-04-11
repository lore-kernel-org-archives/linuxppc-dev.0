Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1176262253.8061.60.camel@localhost.localdomain>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<20070411025605.GB2197@localhost.localdomain>
	<1176262253.8061.60.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
Date: Wed, 11 Apr 2007 23:03:28 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I would personally prefer building the entire kernel with -mno-string
>>> when cell support is enabled...
>>
>> I'm about to resend the patch which prevent alignment interrupts on LS
>> by using memcpy_fromio() rather than putting a collection of -mno-* 
>> options
>> in Makefile. (only -mno-string is not enough to prevent that as 
>> Segher said)
>
> Sure, however we also know for sure that string instructions will suck 
> a
> LOT on a cell ... so for a multi platforms kernel that has cell support
> built-in, it makes some sense to not use them.

[That's a separate issue and should be handled as a
separate patch series.]

Not only string insns are slow on the current Cell core,
many more insns are, including all dot insns; and those
are way more expensive in comparison.  Turning off
generation of string insns only won't help Cell much.

Building a multiplatform kernel with all the insns that
are expensive on Cell turned off will hurt a lot on most
other CPUs.

This isn't just a kernel issue either; the same holds
for all of userspace.  It seems to me the only way to
get good performance on both Cell and all other platforms
is to have a separate binary distribution for Cell.


Segher
