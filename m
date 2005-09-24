Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050924104827.114939ca.sfr@canb.auug.org.au>
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<17204.38908.767118.59625@cargo.ozlabs.ibm.com>
	<20050924104827.114939ca.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BCC97EBE-6171-4FF9-A696-B98B11046391@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sat, 24 Sep 2005 10:35:03 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, arnd@arndb.de,
	linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2005, at 7:48 PM, Stephen Rothwell wrote:

> On Sat, 24 Sep 2005 10:04:12 +1000 Paul Mackerras  
> <paulus@samba.org> wrote:
>
>>
>> Kumar Gala writes:
>>
>>
>>> +#ifdef __powerpc64__
>>> +extern struct cpu_spec        *cur_cpu_spec;
>>> +#else /* __powerpc64__ */
>>> +extern struct cpu_spec        *cur_cpu_spec[];
>>> +#endif /* __powerpc64__ */
>>>
>>
>> I would like to see this unified - it makes no sense for them to be
>> different.  We are unlikely to support asymmetric multiprocessing any
>> time soon, so let's go with the single cur_cpu_spec pointer (a la
>> ppc64).
>>
>
> Michael Ellerman also has a patch that makes this a struct (i.e. not a
> pointer) which allows us to mark the array of cpuspec's that we test
> against at boot time as __init.  Maybe he could do the ppc32 single
> cpu_spec as part of that.

I'm all for unifying this as well.  If Michael can post his patch  
I'll look at fixing up this issue. Let's merge the current patch and  
follow it up with an update that includes this fix and Michael's work.

- kumar
