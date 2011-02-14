Return-Path: <Hollis_Blanchard@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D2CD5B7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 10:05:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
Date: Mon, 14 Feb 2011 15:05:00 -0800
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FAADB@na3-mail.mgc.mentorg.com>
In-Reply-To: <AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
References: <4D55A7F7.5090700@mentor.com>
	<AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
From: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
To: "Linus Walleij" <linus.walleij@linaro.org>
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

On 02/13/2011 01:24 PM, Linus Walleij wrote:
>> >      3. Userspace interfaces for accessing the mailboxes.  A
>> >         '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for =
example.
> What kind of business does userspace have with directly using
> mailboxes? Enlighten me so I get it... in our system these are
> used by protocols, such as net/caif/* thru drivers/net/caif/*, and
> we have similar kernelspace functionality for Phonet.
>
> CAIF and Phonet on the other hand, have custom openings
> down to the thing that exists on the other end of the mailbox.
> Most of these systems tend to talk some funny protocol that
> is often better handled by the kernel than by any userspace.
>
> So is this for the situation when you have no intermediate
> protocol between your userpace and the other CPU's
> subsystem? Or are you thinking about handling that
> protocol in userspace? That is generally not such a good idea
> for efficiency reasons.
OpenMCAPI (http://openmcapi.org) implements the MCAPI specification,=20
which is a simple application-level communication API that uses shared=20
memory. The API could be layered over any protocol, but was more or less =

designed for simple shared-memory systems, e.g. fixed topology, no=20
retransmission, etc.

Currently, we implement almost all of this as a shared library, plus a=20
very small kernel driver. The only requirements on the kernel are to=20
allow userspace to map the shared memory area, and provide an IPI=20
mechanism (and allow the process to sleep while waiting). Applications=20
sync with each other using normal atomic memory operations.

We're now trying to optimize the transfer of scalars on platforms that=20
provide mailboxes (beyond simple IPIs), which is why we're looking at=20
defining a user-facing API to such hardware.

I'll add that we haven't done serious optimization yet, but the numbers=20
we do have seem reasonable. What are the "efficiency" issues you're=20
worried about?

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
