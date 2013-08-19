Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 477962C012C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 20:21:23 +1000 (EST)
Message-ID: <5211F1B3.4080206@arm.com>
Date: Mon, 19 Aug 2013 11:21:39 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 4/4] of: move of_get_cpu_node implementation to
 DT core library
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376691273.25016.5.camel@pasglop>
In-Reply-To: <1376691273.25016.5.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
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

On 16/08/13 23:14, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
>> +#ifdef CONFIG_PPC
>> +               /* Check for historical "ibm,ppc-interrupt-server#s" pro=
perty
>> +                * for thread ids on PowerPC. If it doesn't exist fallba=
ck to
>> +                * standard "reg" property.
>> +                */
>> +               if (__of_find_n_match_cpu_property(cpun,
>> +                               "ibm,ppc-interrupt-server#s", cpu, threa=
d))
>> +                       return cpun;
>> +#endif
>=20
> It's not "historical". It's still very much in use and well defined in PA=
PR :-)
>=20
By historical, I meant it should not be used in future bindings.

Ah, sorry missed it in ePAPR, because its not under CPU node section.
What's more interesting is that ePAPR has it as an example for
non-standard property names :)

Can I mark it as custom/non-standard instead ? I mainly want to indicate
that we need to use 'reg' property and not introduce any more custom
properties for thread ids.

Can I add your ACK with this comment fixed ?

Regards,
Sudeep
