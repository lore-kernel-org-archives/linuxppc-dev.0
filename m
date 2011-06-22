Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCC72B7025
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 00:56:06 +1000 (EST)
Message-ID: <4E020268.2020809@freescale.com>
Date: Wed, 22 Jun 2011 09:55:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop> <4DF814A3.7070209@freescale.com>
	<1308105196.2635.16.camel@pasglop>
	<083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
In-Reply-To: <083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
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

Kumar Gala wrote:
>> > 
>> > Well, not exactly. Paul wants to break that up since we're adding some
>> > primitive support for 201 HV mode too (for 970's). Last we discussed,
>> > the plan was to go for a generic HV mode bit and a separate bit for the
>> > version.
>> > 
>> > Cheers,
>> > Ben.

> Any ETA on Paul's intro of the FTR bit?  If not I'll pull this into my 'next' tree and we can clean up later.

Just FYI, this particular patch is because of a limitation in the Freescale
hypervisor.  It's not because we're running in guest mode.  If the hypervisor
provided full emulation of the timebase register, then we wouldn't need this
patch.  The same can be said of KVM or any other hypervisor.

So a generic HV mode bit is not going to help me, unless there's also a bit
that's specific to our hypervisor.  And even then, we would need some way to
differentiate among different versions of our hypervisor, in case some future
version adds timebase support.  We currently use the device tree for all this,
so I'm not sure what a FTR bit will gain us.

-- 
Timur Tabi
Linux kernel developer at Freescale
