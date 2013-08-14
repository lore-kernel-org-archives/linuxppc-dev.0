Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 475542C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 21:37:49 +1000 (EST)
Message-ID: <1376480227.4255.66.camel@pasglop>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Wed, 14 Aug 2013 21:37:07 +1000
In-Reply-To: <520B5584.7030608@arm.com>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
 <1376428024.4255.14.camel@pasglop> <520B5584.7030608@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Olof Johansson <olof@lixom.net>,
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

On Wed, 2013-08-14 at 11:01 +0100, Sudeep KarkadaNagesha wrote:
> Yes this doesn't cover the historical "ibm,ppc-interrupt-server#s",
> for
> which we can have PPC specific wrapper above the generic one i.e. get
> the cpu node and then parse for thread id under custom property.

A wrapper is wrong. I don't want to have to have all ppc callers to use
a different function.

As I said, just make a generic one that returns a thread ID, ie, same
signature as the powerpc one. Make it weak, we can override it in
powerpc-land, or we can move the ibm,ppc-interrupt-server#s handling
into the generic one, it won't hurt, but leave the thread_id return
there, it doesn't hurt it will come in handy in a few cases without
causing code duplication.

Cheers,
Ben.
