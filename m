Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 6058C2C012B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:55:54 +1000 (EST)
Message-ID: <521223FA.5050903@arm.com>
Date: Mon, 19 Aug 2013 14:56:10 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop>
 <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
 <5212177C.8000709@gmail.com>
In-Reply-To: <5212177C.8000709@gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Mark Rutland <Mark.Rutland@arm.com>, Jonas Bonn <jonas@southpole.se>,
 Michal Simek <monstr@monstr.eu>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On 19/08/13 14:02, Rob Herring wrote:
> On 08/19/2013 05:19 AM, Mark Rutland wrote:
>> On Sat, Aug 17, 2013 at 11:09:36PM +0100, Benjamin Herrenschmidt wrote:
>>> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
>>>> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
>>>> which=20
>>>> the updated bindings[1] define #address-cells =3D <0> and so no reg=20
>>>> property.
>>>>
>>>> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795
>>>
>>> Why did you do that in the binding ? That sounds like looking to create
>>> problems ...=20
>>>
>>> Traditionally, UP setups just used "0" as the "reg" property on other
>>> architectures, why do differently ?
>>
>> The decision was taken because we defined our reg property to refer to
>> the MPIDR register's Aff{2,1,0} bitfields, and on UP cores before v7
>> there's no MPIDR register at all. Given there can only be a single CPU
>> in that case, describing a register that wasn't present didn't seem
>> necessary or helpful.
>=20
> What exactly reg represents is up to the binding definition, but it
> still should be present IMO. I don't see any issue with it being
> different for pre-v7.
>=20
Yes it's better to have 'reg' with value 0 than not having it.
Otherwise this generic of_get_cpu_node implementation would need some
_hack_ to handle that case.

Regards,
Sudeep
