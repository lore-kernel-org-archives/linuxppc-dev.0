Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1D4EB2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 04:17:06 +1000 (EST)
Subject: Re: [PATCH] powerpc/smp: Do not disable IPI interrupts during suspend
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1C2FF4B5-3F3C-4A9D-941D-A4BC4F5C95DE@kernel.crashing.org>
Date: Thu, 13 Sep 2012 13:16:51 -0500
Message-Id: <287921FF-96B1-4BBC-B9F9-3F8D24244061@kernel.crashing.org>
References: <1342788421-27648-1-git-send-email-chenhui.zhao@freescale.com>
 <5028672F-1873-4E45-AA23-4CA9F191BE77@kernel.crashing.org>
 <1343427631.21647.1.camel@pasglop>
 <20120802100418.GA13777@localhost.localdomain>
 <1C2FF4B5-3F3C-4A9D-941D-A4BC4F5C95DE@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui <chenhui.zhao@freescale.com>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 7:40 AM, Kumar Gala wrote:

>=20
> On Aug 2, 2012, at 5:04 AM, Zhao Chenhui wrote:
>=20
>> On Sat, Jul 28, 2012 at 08:20:31AM +1000, Benjamin Herrenschmidt =
wrote:
>>> On Fri, 2012-07-27 at 16:58 -0500, Kumar Gala wrote:
>>>> On Jul 20, 2012, at 7:47 AM, Zhao Chenhui wrote:
>>>>=20
>>>>> During suspend, all interrupts including IPI will be disabled. In =
this case,
>>>>> the suspend process will hang in SMP. To prevent this, pass the =
flag
>>>>> IRQF_NO_SUSPEND when requesting IPI irq.
>>>>>=20
>>>>> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>> ---
>>>>> arch/powerpc/kernel/smp.c |    2 +-
>>>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>>=20
>>>> BenH,
>>>>=20
>>>> Can you ack?
>>>=20
>>> No I'll merge it but not until it's been in next for a bit unless =
you
>>> have some strong emergency there, it's on my mental list of things =
to
>>> shovel into next after rc1.
>>>=20
>>> Curiosity: didn't we use to disable all non-boot CPUs on suspend ?
>>>=20
>>> Cheers,
>>> Ben.
>>=20
>> Yes, we disabled all non-boot CPUs on suspend by calling =
disable_nonboot_cpus().
>> The disable_nonboot_cpus() needs IPIs to work. But prior to
>> calling disable_nonboot_cpus(), the IPIs are disabled in =
dpm_suspend_noirq().
>>=20
>> -Chenhui
>=20
> Benh, Ack?

Ben?

- k=
