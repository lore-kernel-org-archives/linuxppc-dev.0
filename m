Return-Path: <david.c.hubbard@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id A1891DE86F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 01:31:33 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1422655yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 08:31:31 -0700 (PDT)
Message-ID: <4dfa50520807150831i519a3a43n635ab7e58d35ba5e@mail.gmail.com>
Date: Tue, 15 Jul 2008 09:31:29 -0600
From: "David Hubbard" <david.c.hubbard@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [RFC] (almost) booting allyesconfig -- please don't poke super-io
	without request_region
In-Reply-To: <20080715103613.4fbbf01f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <for-27-patch1-0@bga.com> <4879A144.8060203@hhs.nl>
	<4dfa50520807131411ied883cgcb20eb6bd94f761@mail.gmail.com>
	<487A7211.7030309@hhs.nl>
	<4dfa50520807131426t4013142cp1fcd49e078a79c1f@mail.gmail.com>
	<20080714095914.0644ac5d@hyperion.delvare>
	<88f5162604470179b3c6ebfe729a46f5@bga.com> <487B8D2C.1090208@hhs.nl>
	<4dfa50520807141055l532caaaai700255936600e5ae@mail.gmail.com>
	<20080715103613.4fbbf01f@hyperion.delvare>
Cc: Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, Hans de Goede <j.w.r.degoede@hhs.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

On Tue, Jul 15, 2008 at 2:36 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> Is there any way to use lspci and start at the LPC bridge, then find
>> the SuperIO chip's IO address? What about ACPI tables? Perhaps probing
>> logic could look for an LPC bridge before probing certain IO addresses
>> even if the addresses are not in the LPC bridge config.
>
> I always assumed that there was no way to know in advance if a
> Super-I/O (LPC) chip was present or not, let alone the exact model of
> the chip. The I/O addresses are decoded by the Super-I/O chip itself,
> and in general it has no relation to PCI. And I've never seen ports
> 0x2e/0x2f nor 0x4e/0x4f listed in /proc/ioports.
>
> But of course if there is a way to know, we should use it. Avoiding
> random access to I/O ports, even if they are relatively standard in
> this case, is always good.

I looked at my lspci output and did a little researching, and I think
the only thing we can deduce is that there is an LPC bridge, so
looking for a SuperIO is a good idea. If there is no LPC bridge
listed, I can't say whether probing the ports is a good idea or not.

David
