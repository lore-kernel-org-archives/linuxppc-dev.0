Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB190B6F6F
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 12:34:26 +1000 (EST)
In-Reply-To: <20110623124802.7aeb6b66@schlenkerla.am.freescale.net>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop> <4DF814A3.7070209@freescale.com>
	<1308105196.2635.16.camel@pasglop>
	<083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
	<4E020268.2020809@freescale.com>
	<20110623122210.06ee9f55@schlenkerla.am.freescale.net>
	<4E0378F4.5010501@freescale.com>
	<20110623124802.7aeb6b66@schlenkerla.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <59f786bfaced051a14e2bb75d3d1ce77@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under the
	hypervisor
Date: Fri, 24 Jun 2011 04:36:00 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> But does that mean that a guest should never be allowed to modify a 
>> virtualized
>> timebase register, even if the hypervisor can support it?
>
> The book3e mtspr writeup doesn't appear to specify the behavior when
> writing to a read-only SPR, so perhaps you could argue that something 
> other
> than a no-op is implementation-specific behavior.

v2.06 III-E 9.2.1:
"Writing the Time Base is hypervisor privileged."

v2.06 III-E 2.1:
"If a hypervisor-privileged register is accessed in the guest supervisor
state (MSR[GS PR] = 0b10), an Embedded Hypervisor Privilege exception 
occurs."

(v2.06 III-E 5.4.1, the big SPR table, also shows the TB regs (for 
writing,
i.e. 284 and 285) to be hypervisor privileged.  Consistency, hurray :-) 
)


Segher
