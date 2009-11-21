Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 4645BB6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 18:51:46 +1100 (EST)
Received: by ywh17 with SMTP id 17so3628989ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 23:51:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <e846a32c-5f37-4531-b23d-17c60d8b6449@SG2EHSMHS010.ehs.local>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
	<c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
	<200911191833.08254.arnd@arndb.de>
	<a1cde516-ea22-4411-bae1-74878f6bee43@SG2EHSMHS002.ehs.local>
	<fa686aa40911201358n5e5eb871wbfa523bfc9adb59d@mail.gmail.com>
	<e846a32c-5f37-4531-b23d-17c60d8b6449@SG2EHSMHS010.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 21 Nov 2009 00:51:24 -0700
Message-ID: <fa686aa40911202351s4436a8a6r59abfe2cf130ca59@mail.gmail.com>
Subject: Re: Bug in drivers/serial/of_serial.c?
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Neuendorffer <stephenn@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2009 at 3:11 PM, John Linn <John.Linn@xilinx.com> wrote:
>
>> -----Original Message-----
>> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gr=
ant Likely
>> Sent: Friday, November 20, 2009 2:58 PM
>> To: Stephen Neuendorffer
>> Cc: Arnd Bergmann; John Linn; Alon Ziv; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: Bug in drivers/serial/of_serial.c?
>>
>> On Thu, Nov 19, 2009 at 10:42 AM, Stephen Neuendorffer
>> <stephen.neuendorffer@xilinx.com> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.o=
rg
>> > [mailto:linuxppc-dev-
>> >> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Ar=
nd
>> > Bergmann
>> >> Sent: Thursday, November 19, 2009 9:33 AM
>> >> To: Stephen Neuendorffer
>> >> Cc: John Linn; Alon Ziv; linuxppc-dev@lists.ozlabs.org
>> >> Subject: Re: Bug in drivers/serial/of_serial.c?
>> >>
>> >> On Thursday 19 November 2009, Stephen Neuendorffer wrote:
>> >> > If the problem is in the device trees that are being generated, we
>> >> > should fix the issue there.
>> >> > We've been trying to avoid putting the fully specified IP versions
>> > in
>> >> > the kernel like this, since
>> >> > the IP changes so often.
>> >>
>> >> No, the problem that Alon has is that the firmware currently has no
>> >> way whatsoever to give a correct device tree, because of-serial.c
>> >> does not even know about ns16550a.
>> >>
>> >> The patch adds both a special-case for the specific uart he
>> >> is using so that one is grandfathered in and a new compatible
>> >> value so future boards can specify both ns16550a and ns16550.
>> >
>> > That's true... =A0The 16550a line still needs to get added, but not th=
e
>> > xlnx-
>> > specific line.
>>
>> The xlnx- line should be added and is entirely appropriate for exactly
>> the reason Arnd stated.
>
> I'm just wanting to make sure I'm on the same page...
>
> It seems like you're saying that adding this line fixes the system before=
 any device tree generator fix, for existing systems, true?
>
> If that's true, how do you know that the 16550 in the xilinx system is no=
t a 16450 as that's the default?
>
> Right now we're not generating the ns16450 as we should be when there are=
 no FIFOs. =A0Since we've been using 16550 and not 16550A it probably hasn'=
t been a problem.

Hmmm, right.  I forgot that we talked about that on the phone.  Yes,
in that case it is not a good idea to add the
xlnx,xps-uart16550-2.00.b because we don't know if it is configured as
a 16450 or a 16550.  At least, if the xlnx,... match is added, then
the driver *also* needs to look for the value of the "xlnx,is-a-16550"
property.

BTW, while looking at that file... Arnd, does the .type =3D "serial"
stuff really need to be there?

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
