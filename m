Return-Path: <thunderbird2k@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id 10942DDF55
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 19:11:18 +1000 (EST)
Received: by bwz19 with SMTP id 19so170837bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:11:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF08A8F393.64CD0E94-ONC125759A.00276611-C125759A.002C76B2@transmode.se>
References: <OF2E7A8F65.EA7B7D26-ONC1257599.004624DB-C1257599.0046F2EB@transmode.se>
	<20090415130844.GB3301@pengutronix.de>
	<8BE09C31-40E4-41C2-A6D8-EE9C7DA0B625@kernel.crashing.org>
	<OF08A8F393.64CD0E94-ONC125759A.00276611-C125759A.002C76B2@transmode.se>
Date: Thu, 16 Apr 2009 11:03:56 +0200
Message-ID: <c8485d470904160203y66d456f7xd73692b177587822@mail.gmail.com>
Subject: Re: OF PCI howto?
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 10:05 AM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> Kumar Gala <galak@kernel.crashing.org> wrote on 15/04/2009 17:20:21:
>> On Apr 15, 2009, at 8:08 AM, Wolfram Sang wrote:
>>
>> > On Wed, Apr 15, 2009 at 02:54:57PM +0200, Joakim Tjernlund wrote:
>> >
>> >> dts fragment correct for my setup? If not, is there a better
>> >> example I can
>> >> look at?
>> >
>> > Maybe this message/thread can help you:
>> >
>> > http://ozlabs.org/pipermail/devicetree-discuss/2009-March/000597.html
>>
>> You may also want to take a look at ePAPR on the power.org site
>
> Thanks guys
>
> Looking in ePAPR I see I should read the IDSEL like this:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x11 AD17 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x1 &ipic 20 0x8 /* INTA */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x2 &ipic 21 0x8 /* INTB */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x3 &ipic 22 0x8 /* INTC */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x4 &ipic 23 0x8 /* INTD */
>
> grouping the first line into:
> "0x8800 0x0 0x0" "0x1" "&ipic" "20 0x8" /* INTA */
>
> "0x8800 0x0 0x0" =3D child unit address
> "0x1" =3D child interrupt specifier =3D INTA
> "&ipic" =3D interrupt parent
> "20 0x8" =3D parent interrupt specifier
>
> Questions:
> =A0MPC832x appears to only have INTA so why are the INTB,INTC
> =A0and INTD lines there?
>
> =A0I don't understand how IDSEL values are decided. Are IDSEL 0x11-0x18
> randomly
> =A0selected or are they fixed for MPC832x?

The idsel values depend on how the pci slots are wired on your board.
The 0x8800 value is
in general a function of bus, device and function number. ( bus << 16
| devfn << 8)

Further I would also watch out with the parent interrupt specifier
e.g. '20 0x8'. The openfirmware spec
normally suggests to use a value of '2' for interrupts which are
active low. During parsing of the interrupt-map
this value is normally translated using 'xlate' to linux kernel values
(active low is defined as IRQ_TYPE_LEVEL_LOW      0x00000008 in the
kernel).
The ipic driver code and various dts files are evil and store the
linux kernel value inside the DTS file, so they don't do any
conversion whis is EVIL
in my opinion. Watch out for that. (The corresponding DTS files and
drivers should be updated).

Regards,
Roderick Colenbrander
