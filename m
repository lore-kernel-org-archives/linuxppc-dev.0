Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E21F0B6F7D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 13:49:01 +1000 (EST)
In-Reply-To: <4E03F8C1.60706@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop>
	<4DF814A37aeb6b66@schlenkerla.am.freescale.net>
	<59f786bfaced051a14e2bb75d3d1ce77@kernel.crashing.org>
	<4E03F8C1.60706@freescale.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <53807ffa0f2275ffbf492a6d8905dc32@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under the
	hypervisor
Date: Fri, 24 Jun 2011 05:50:41 +0200
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(context put back:)

>> But does that mean that a guest should never be allowed to modify a 
>> virtualized
>> timebase register, even if the hypervisor can support it?
>
> The book3e mtspr writeup doesn't appear to specify the behavior when
> writing to a read-only SPR, so perhaps you could argue that something 
> other
> than a no-op is implementation-specific behavior.

>> v2.06 III-E 9.2.1:
>> "Writing the Time Base is hypervisor privileged."
>>
>> v2.06 III-E 2.1:
>> "If a hypervisor-privileged register is accessed in the guest 
>> supervisor
>> state (MSR[GS PR] = 0b10), an Embedded Hypervisor Privilege exception
>> occurs."
>>
>> (v2.06 III-E 5.4.1, the big SPR table, also shows the TB regs (for 
>> writing,
>> i.e. 284 and 285) to be hypervisor privileged.  Consistency, hurray 
>> :-) )
>
> To me, all this means that a guest cannot write to the actual timebase
> register.

It also means that the hypervisor gets a trap when a guest tries to do 
this.

>   I'm not interpreting this to mean that a hypervisor can't
> virtualize the timebase and allow a guest to read/write a virtual 
> timebase
> register, so that it thinks it's writing to the real hardware timebase 
> register.

Yes, a hypervisor can do this.  The behaviour of the hardware is not
implementation-specific (modulo bugs ;-) ); when a guest tries to write
to the timebase, the hypervisor gets a trap.  The hypervisor can then
do whatever it wants with it.


Segher
