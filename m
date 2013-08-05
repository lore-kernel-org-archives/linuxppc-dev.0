Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 5DB612C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 06:36:34 +1000 (EST)
Message-ID: <52000ACA.1010606@ovro.caltech.edu>
Date: Mon, 05 Aug 2013 13:27:54 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
In-Reply-To: <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pete,

> On Mon, Aug 5, 2013 at 11:25 AM, Anatolij Gustschin <agust@denx.de> wrote:
>> Maybe this card needs bigger delay to respond after PCI reset. You can
>> try to re-build U-Boot with defined CONFIG_PCI_BOOTDELAY. Use 1000
>> for CONFIG_PCI_BOOTDELAY in the first step and if detection works,
>> try to decrease this value.
>
> That didn't work.  But perhaps the problem is because these are older
> PCI parts, and don't implement ECAM (only the older CAM)?   I don't
> think u-boot limits itself...

Since you're looking for suggestions (apologies if these are
"too obvious");

1. Have you checked the power supplies on the PCI board?

    PCI boards can be powered from 3.3V or 5V, or both. I've had
    old PCs that only supply one or the other rail, and various
    evaluation boards that only supply 3.3V.

    If you can put together a "working" x86 setup that detects the
    board, then you could poke around and see what voltages exist
    on some of the decoupling components, then plug it into your
    real system, and see what voltages you measure there.

2. Have you probed the PCI bus using a bus analyzer or scope?

    If you have a PCI bus analyzer (or can find someone with one),
    plug it in and see what happens at power-on (there should be
    configuration cycles).

    At a minimum, if you have a 'scope, see if the PCI configuration
    space access handshakes are active during power-on.

3. Is debugging this PCI card worth your time?

    Sometimes the "solution" involves tossing old hardware in
    the trash.

Cheers,
Dave
