Return-Path: <linus.walleij@linaro.org>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WCzh2s95zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 18:29:32 +1000 (AEST)
Received: by mail-it0-x232.google.com with SMTP id 144-v6so4298351iti.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 01:29:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524494812-60150-2-git-send-email-bryantly@linux.vnet.ibm.com>
References: <1524494812-60150-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <1524494812-60150-2-git-send-email-bryantly@linux.vnet.ibm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 25 Apr 2018 10:29:29 +0200
Message-ID: <CACRpkdZH4kheSf_G=i-r=0yZN04W_4bJ1Q7ZXPw=62NrV+LCnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] misc: IBM Virtual Management Channel Driver
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, christoffer.dall@arm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, seroyer@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com,
 adreznec@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, mikey@neuling.org,
 Philippe Ombredanne <pombredanne@nexb.com>, tlfalcon@linux.vnet.ibm.com,
 msuchanek@suse.de, linux-doc@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I don't know why I'm included in review of this driver, but why
not :) it is good to include people.

Thanks for your patch! It looks exciting and complicated,
I like that kind of stuff.

On Mon, Apr 23, 2018 at 4:46 PM, Bryant G. Ly
<bryantly@linux.vnet.ibm.com> wrote:

> This driver is a logical device which provides an
> interface between the hypervisor and a management
> partition.

Please indicate what this management partition is to
be used for, i.e. the intended use case.

> This driver is to be used for the POWER Virtual
> Management Channel Virtual Adapter on the PowerVM
> platform.

Is that virtualization on the PowerPC platform?

> It provides both request/response and
> async message support through the /dev/ibmvmc node.

Is that a character or block device?
I guess block, but it's nice to have some specifics
in the commit message.

> diff --git a/Documentation/misc-devices/ibmvmc.txt b/Documentation/misc-d=
evices/ibmvmc.txt

The document suffers a bit from internal lingo, so it's be great
if you improve it a bit with a style that will be welcoming for newcomers
who have no idea what you are talking about.

I will point out some items below.

> +Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Virtual Management Channel (VMC) is a logical device which provides =
an
> +interface between the hypervisor and a management partition.

What kind of interface? A bitstream? Message passing interface?
Marshalling of structs? Some specifics would be great.

> This
> +management partition is intended to provide an alternative to HMC-based
> +system management.

Please expand the acronym HMC for the newcomer so we do not need
to look it up, or it looks like the document is only for people who already
know everything about virtualization specifics.

> In the management partition, a Novalink application
> +exists

Is Novalink some kind of product name? In that case, can it be
instead described with some neutral technology name and state
Novalink as an examplf of this type of technology?

> which enables a system administrator to configure the system=E2=80=99s
> +partitioning characteristics

Exemplify "partitioning characteristics", with a sentence in this
vein: "partitioning characteristics such as FOO, BAR and BAZ".

> via a command line interface (CLI) or
> +Representational State Transfer Application (REST).

I understand what CLI is but what is a representational state
transfer application? Is that a fancy name for a GUI application
doing the same thing as a CLI program would do?

> You can also manage the
> +server by using PowerVC

There was PowerVM now there is PowerVC. What are those things
really? PowerVM I guess is virtual machine on PowerPC? What is
PowerVC? Virtual client (guest) in the PowerVM?

This kind of lingo makes the document a hard read for me.

> or other OpenStack solution.

I heard about OpenStack. I have a vague idea about what it is,
do you mean "other virtualization concepts"?

> Support for
> +conventional HMC management of the system may still be provided on a
> +system; however, when an HMC is attached to the system, the VMC
> +interface is disabled by the hypervisor.

The VMC acronym is expanded below, instead expand it at first
instance. The same for HMC (hypervisor management channel I guess?
it is never really explained.)

> +NovaLink runs on a Linux logical partition on a POWER8 or newer processo=
r-
> +based server that is virtualized by PowerVM.

So this information needs to be in the top of the document.

> System configuration,
> +maintenance, and control functions which traditionally require an HMC ca=
n
> +be implemented in the Novalink using a combination of HMC to hypervisor
> +interfaces and existing operating system methods. This tool provides

What tool? It is unclear what tool we are referring to here.
A command line tool? A technology? etc.

> a
> +subset of the functions implemented by the HMC and enables basic partiti=
on
> +configuration. The set of HMC to hypervisor messages

This makes me think that probably the "h" in HMC stands for "hypervisor"
so now I start to puzzle things together. But it's nicer if you just expand
the acronym the first time you use it.

> supported by the
> +Novalink component

I still haven't figured out what that is, in practice.

> are passed to the hypervisor over a VMC interface, which
> +is defined below.

Maybe some illustration of how HMC, Novalink and VMC work
together would be appropriate?

> +Virtual Management Channel (VMC)
> +A logical device, called the virtual management channel (VMC), is define=
d
> +for communicating between the Novalink application and the hypervisor.


So is "Novalink" some specific application, as in a proprietary
piece of software or something?

I'm still confused.

> +This device, similar to a VSCSI server device,

What is that acronym now, I get completely confused.

> is presented to a designated
> +management partition as a virtual device and is only presented when the
> +system is not HMC managed.
> +This communication device borrows aspects from both VSCSI and ILLAN devi=
ces

Now there is ILLAN too.

> +and is implemented using the CRQ and the RDMA interfaces.

CRQ and RDMA. The RDMA I heard about, I wonder what CRQ is.

At this point the document is referring to so much external a priori
knowledge that I don't have that I don't understand anything at all.

So if this document is meant as an introduction to the technology
for newcomers, it's not working at all, unfortunately.

If some specific domain knowledge is needed to read and
understand the document, you need to state these prerequisites
at the beginning of the document.

Something like: "if you don't know a lot about virtualization already,
then don't even bother trying to read this document".

Yours,
Linus Walleij
