Return-Path: <robherring2@gmail.com>
Received: from mail-oa0-x236.google.com (mail-oa0-x236.google.com
 [IPv6:2607:f8b0:4003:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 990702C0152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:03:01 +1000 (EST)
Received: by mail-oa0-f54.google.com with SMTP id o6so5893704oag.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 06:02:57 -0700 (PDT)
Message-ID: <5212177C.8000709@gmail.com>
Date: Mon, 19 Aug 2013 08:02:52 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop>
 <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
In-Reply-To: <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2013 05:19 AM, Mark Rutland wrote:
> On Sat, Aug 17, 2013 at 11:09:36PM +0100, Benjamin Herrenschmidt wrote:
>> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
>>> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
>>> which 
>>> the updated bindings[1] define #address-cells = <0> and so no reg 
>>> property.
>>>
>>> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795
>>
>> Why did you do that in the binding ? That sounds like looking to create
>> problems ... 
>>
>> Traditionally, UP setups just used "0" as the "reg" property on other
>> architectures, why do differently ?
> 
> The decision was taken because we defined our reg property to refer to
> the MPIDR register's Aff{2,1,0} bitfields, and on UP cores before v7
> there's no MPIDR register at all. Given there can only be a single CPU
> in that case, describing a register that wasn't present didn't seem
> necessary or helpful.

What exactly reg represents is up to the binding definition, but it
still should be present IMO. I don't see any issue with it being
different for pre-v7.

Rob

> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
