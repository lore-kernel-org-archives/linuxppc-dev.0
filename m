Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F5C8B6F91
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 03:49:51 +1000 (EST)
Date: Thu, 23 Jun 2011 12:48:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Message-ID: <20110623124802.7aeb6b66@schlenkerla.am.freescale.net>
In-Reply-To: <4E0378F4.5010501@freescale.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Thu, 23 Jun 2011 12:33:40 -0500
Timur Tabi <timur@freescale.com> wrote:

> Scott Wood wrote:
> > From Power ISA 2.06B, book III-E, section 9.2.1:
> > 
> > Virtualized Implementation Note:
> > 
> > In virtualized implementations, TBU and TBL are
> > read-only.
> 
> But does that mean that a guest should never be allowed to modify a virtualized
> timebase register, even if the hypervisor can support it?

The book3e mtspr writeup doesn't appear to specify the behavior when
writing to a read-only SPR, so perhaps you could argue that something other
than a no-op is implementation-specific behavior.

For a guest, the safe thing is to not write to those registers unless you
specifically know it's going to do what you want under a particular
implementation.  It's not specifically a Topaz limitation.

> >> > So a generic HV mode bit is not going to help me, unless there's also a bit
> >> > that's specific to our hypervisor.  And even then, we would need some way to
> >> > differentiate among different versions of our hypervisor, in case some future
> >> > version adds timebase support. 
> 
> > That's very unlikely to happen.
> 
> I know. I was just being architecturally pedantic.

It's not as if it would hurt anything to ignore such a capability.

> > Ideally we would avoid doing this sync even when not running under a
> > hypervisor, as long as firmware has done the sync, and kexec hasn't messed
> > it up.  Besides being a waste of boot time, the firmware's sync is
> > probably tighter since it can use a platform-specific mechanism to start all
> > the timebases at once.
> 
> I agree with that, but for now, I need to work around that kexec "limitation".

Is there any way we can detect whether we booted via kexec (as opposed to
just having kexec support enabled), and only do the sync in that case?

-Scott
