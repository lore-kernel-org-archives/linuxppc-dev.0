Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE004.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4CC81B6F6E
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 03:33:49 +1000 (EST)
Message-ID: <4E0378F4.5010501@freescale.com>
Date: Thu, 23 Jun 2011 12:33:40 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
References: <1308092673-13045-1-git-send-email-timur@freescale.com>	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>	<4DF7EB8E.8020308@freescale.com>	<20110614182517.776d7e77@schlenkerla.am.freescale.net>	<1308103091.2635.13.camel@pasglop>	<4DF814A3
In-Reply-To: <20110623122210.06ee9f55@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> From Power ISA 2.06B, book III-E, section 9.2.1:
> 
> Virtualized Implementation Note:
> 
> In virtualized implementations, TBU and TBL are
> read-only.

But does that mean that a guest should never be allowed to modify a virtualized
timebase register, even if the hypervisor can support it?

>> > So a generic HV mode bit is not going to help me, unless there's also a bit
>> > that's specific to our hypervisor.  And even then, we would need some way to
>> > differentiate among different versions of our hypervisor, in case some future
>> > version adds timebase support. 

> That's very unlikely to happen.

I know. I was just being architecturally pedantic.

> Ideally we would avoid doing this sync even when not running under a
> hypervisor, as long as firmware has done the sync, and kexec hasn't messed
> it up.  Besides being a waste of boot time, the firmware's sync is
> probably tighter since it can use a platform-specific mechanism to start all
> the timebases at once.

I agree with that, but for now, I need to work around that kexec "limitation".

-- 
Timur Tabi
Linux kernel developer at Freescale
