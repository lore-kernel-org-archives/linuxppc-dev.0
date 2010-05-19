Return-Path: <dvhltc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21A5CB7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 00:17:17 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4JE6fuR007435
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 10:06:41 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4JEH45h1441944
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 10:17:05 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4JEH21o017026
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 10:17:04 -0400
Message-ID: <4BF3F2DB.7030701@us.ibm.com>
Date: Wed, 19 May 2010 07:16:59 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
In-Reply-To: <1274232324.29980.9.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jan-Bernd Themann <themann@de.ibm.com>, dvhltc@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Doug Maxey <doug.maxey@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2010 06:25 PM, Michael Ellerman wrote:
> On Tue, 2010-05-18 at 15:22 -0700, Darren Hart wrote:
>> On 05/18/2010 02:52 PM, Brian King wrote:
>>> Is IRQF_NODELAY something specific to the RT kernel? I don't see it in mainline...
>>
>> Yes, it basically says "don't make this handler threaded".
>
> That is a good fix for EHEA, but the threaded handling is still broken
> for anything else that is edge triggered isn't it?

No, I don't believe so. Edge triggered interrupts that are reported as 
edge triggered interrupts will use the edge handler (which was the 
approach Sebastien took to make this work back in 2008). Since XICS 
presents all interrupts as Level Triggered, they use the fasteoi path.

>
> The result of the discussion about two years ago on this was that we
> needed a custom flow handler for XICS on RT.

I'm still not clear on why the ultimate solution wasn't to have XICS 
report edge triggered as edge triggered. Probably some complexity of the 
entire power stack that I am ignorant of.

> Apart from the issue of loosing interrupts there is also the fact that
> masking on the XICS requires an RTAS call which takes a global lock.

Right, one of may reasons why we felt this was the right fix. The other 
is that there is no real additional overhead in running this as 
non-threaded since the receive handler is so short (just napi_schedule()).

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
