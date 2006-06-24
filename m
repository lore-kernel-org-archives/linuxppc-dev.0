Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18D0E67A3A
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jun 2006 01:50:14 +1000 (EST)
In-Reply-To: <20060624192136.41e9987d@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
	<20060623231707.6721.43277.stgit@localhost.localdomain>
	<10C0FB27-7351-4578-9CE5-3EFA476C2661@kernel.crashing.org>
	<20060624192136.41e9987d@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64AF3E64-2E2E-492F-9A8E-31268219BA8C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] CPM_UART: unify clock sources
Date: Sat, 24 Jun 2006 10:50:10 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2006, at 10:21 AM, Vitaly Bordug wrote:

> Kumar,
>
> Thanks for feedback! My comment below.
>
> On Sat, 24 Jun 2006 08:46:54 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
> [snip]
>>> +
>>> +#ifndef FS_PD_H
>>> +#define FS_PD_H
>>> +
>>> +#define GET_BAUDRATE()	(((bd_t *) __res)->bi_baudrate ?
>>> ((bd_t *) __res)->bi_baudrate : -1)
>>> +#define FS_UART_CLK()	(((bd_t *) __res)->bi_intfreq)
>>> +
>>> +#endif
>>
>> We shouldn't hide these differences in a header like this.  As we
>> slowly try to removing things from arch/ppc.  Why not just add
>> platform data for these two pieces of data and set it up like we do
>> other platform data.
>>
> That was my first guess as well, but:
> The aim is yet moving to powerpc not to break existing ppc/ stuff.
> So if alternatively platform_data may be utilized, all relevant ppc
> stuff that uses cpm uart should be updated. While doing the driver
> "platformize" trick, I made it possible to keep legacy behaviour
> (pd-less), this is not going to afford such a thing.
>
> IOW, I don't see much sense in updating ppc/ BSP files, just to keep
> the right way. It does not look very neat now, but does the job of
> moving FW and keeping existing stuff sane. If there is better approach
> envisioned, I'll definitely follow..

Fair enough, then I would suggest getting ride of all this header/ 
MACRO indirection and just implement these as functions with  
different implementations in arch/powerpc vs arch/ppc.

- k
