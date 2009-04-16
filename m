Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id CE266DE12A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:21:45 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so529740qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 12:21:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c8485d470904160203y66d456f7xd73692b177587822@mail.gmail.com>
References: <OF2E7A8F65.EA7B7D26-ONC1257599.004624DB-C1257599.0046F2EB@transmode.se>
	<20090415130844.GB3301@pengutronix.de>
	<8BE09C31-40E4-41C2-A6D8-EE9C7DA0B625@kernel.crashing.org>
	<OF08A8F393.64CD0E94-ONC125759A.00276611-C125759A.002C76B2@transmode.se>
	<c8485d470904160203y66d456f7xd73692b177587822@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 13:21:29 -0600
Message-ID: <fa686aa40904161221t131fcdb6u665be2504df5353c@mail.gmail.com>
Subject: Re: OF PCI howto?
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 3:03 AM, Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
> On Thu, Apr 16, 2009 at 10:05 AM, Joakim Tjernlund
> <Joakim.Tjernlund@transmode.se> wrote:
>> Kumar Gala <galak@kernel.crashing.org> wrote on 15/04/2009 17:20:21:
>>> On Apr 15, 2009, at 8:08 AM, Wolfram Sang wrote:
>>>
>>> > On Wed, Apr 15, 2009 at 02:54:57PM +0200, Joakim Tjernlund wrote:
>>> >
>>> >> dts fragment correct for my setup? If not, is there a better
>>> >> example I can
>>> >> look at?
>>> >
>>> > Maybe this message/thread can help you:
>>> >
>>> > http://ozlabs.org/pipermail/devicetree-discuss/2009-March/000597.html
>>>
>>> You may also want to take a look at ePAPR on the power.org site
>>
>> Thanks guys
>>
>> Looking in ePAPR I see I should read the IDSEL like this:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x11 AD17 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x1 &ipic 20 0x8 /* INTA *=
/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x2 &ipic 21 0x8 /* INTB *=
/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x3 &ipic 22 0x8 /* INTC *=
/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8800 0x0 0x0 0x4 &ipic 23 0x8 /* INTD *=
/
>>
>> grouping the first line into:
>> "0x8800 0x0 0x0" "0x1" "&ipic" "20 0x8" /* INTA */
>>
>> "0x8800 0x0 0x0" =3D child unit address
>> "0x1" =3D child interrupt specifier =3D INTA
>> "&ipic" =3D interrupt parent
>> "20 0x8" =3D parent interrupt specifier
>>
>> Questions:
>> =A0MPC832x appears to only have INTA so why are the INTB,INTC
>> =A0and INTD lines there?
>>
>> =A0I don't understand how IDSEL values are decided. Are IDSEL 0x11-0x18
>> randomly
>> =A0selected or are they fixed for MPC832x?
>
> The idsel values depend on how the pci slots are wired on your board.
> The 0x8800 value is
> in general a function of bus, device and function number. ( bus << 16
> | devfn << 8)
>
> Further I would also watch out with the parent interrupt specifier
> e.g. '20 0x8'. The openfirmware spec
> normally suggests to use a value of '2' for interrupts which are
> active low. During parsing of the interrupt-map
> this value is normally translated using 'xlate' to linux kernel values
> (active low is defined as IRQ_TYPE_LEVEL_LOW =A0 =A0 =A00x00000008 in the
> kernel).
> The ipic driver code and various dts files are evil and store the
> linux kernel value inside the DTS file, so they don't do any
> conversion whis is EVIL
> in my opinion. Watch out for that.

They're just numbers and they are intended to by interrupt controller
specific values.  Some IRQ controllers don't even have a 'flags' field
for instance.  The binding author is free to choose values he or she
deems suitable for the purpose as long as it is documented and
reviewed.

> (The corresponding DTS files and
> drivers should be updated).

No.  The binding is set.  We've made a commitment to not change
bindings after they are defined and deployed.  In some cases it is not
easy to update the device tree blob in deployed systems.


>
> Regards,
> Roderick Colenbrander
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
