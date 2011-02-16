Return-Path: <linus.ml.walleij@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E3C8B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Feb 2011 08:54:15 +1100 (EST)
Received: by pwj4 with SMTP id 4so378404pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 13:54:13 -0800 (PST)
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <DD7A9A95166BF4418C4C1EB2033B6EE2038FAADB@na3-mail.mgc.mentorg.com>
References: <4D55A7F7.5090700@mentor.com>
	<AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
	<DD7A9A95166BF4418C4C1EB2033B6EE2038FAADB@na3-mail.mgc.mentorg.com>
Date: Wed, 16 Feb 2011 22:54:12 +0100
Message-ID: <AANLkTimieGeZjL6=tXqkaKbsEvfu3E0YkSO+XGoBKRC_@mail.gmail.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Linus Walleij <linus.walleij@linaro.org>
To: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Inge, Meador" <meador_inge@mentor.com>, openmcapi-dev@googlegroups.com,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/2/15 Blanchard, Hollis <Hollis_Blanchard@mentor.com>:

> OpenMCAPI (http://openmcapi.org) implements the MCAPI specification,
> which is a simple application-level communication API that uses shared
> memory. The API could be layered over any protocol, but was more or less
> designed for simple shared-memory systems, e.g. fixed topology, no
> retransmission, etc.

Cool...

> Currently, we implement almost all of this as a shared library, plus a
> very small kernel driver. The only requirements on the kernel are to
> allow userspace to map the shared memory area, and provide an IPI
> mechanism (and allow the process to sleep while waiting). Applications
> sync with each other using normal atomic memory operations.

Can't this real small kernel driver take care of the mailbox
business as well?

It seems a bit backward if you have say /dev/mcapi0, /dev/mcapi1
etc (or however you expose this to userspace) and /dev/mailbox0
/dev/mailbox1 etc on top of that. One device node per communication
channel instead of this would certainly be nicer? Then you would
have some ioctl() on the /dev/mcapi0 etc node to trigger the
transport and need not worry that it's a mailbox doing the sync.

What I'm after is that whatever datapath you have should include
the control mechanism, now it's like you're opening two interfaces
into the kernel, one for mapping in data pages, one for synchronizing
the transfers, or am I getting things wrong?

I think nominally all mailbox users would be in-kernel like the
MCAPI driver, so they don't need a userspace interface, to me
it feels like say /dev/mutex0, /dev/mutex1 for some other
shared memory opening into the kernel (such as the framebuffer),
and that would look a bit funny.

> I'll add that we haven't done serious optimization yet, but the numbers
> we do have seem reasonable. What are the "efficiency" issues you're
> worried about?

For huge data flows I think you may get into trouble, needing things
like queueing, descriptor pools etc. But if you're convinced this will
work, do go ahead.

Linus Walleij
