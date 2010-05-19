Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id EA84FB7D30
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 02:00:25 +1000 (EST)
Received: by gwb1 with SMTP id 1so2844517gwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 09:00:23 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BED2859.3050204@ge.com>
References: <20100514102905.7807.27638.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<4BED2859.3050204@ge.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 May 2010 10:00:01 -0600
Message-ID: <AANLkTilV7xaAaUpt9oCraVL2jG2gP8N5DfYbr5XW6duV@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add i8042 keyboard and mouse irq parsing
To: Martyn Welch <martyn.welch@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 14, 2010 at 4:39 AM, Martyn Welch <martyn.welch@ge.com> wrote:
> Martyn Welch wrote:
>> Currently the irqs for the i8042, which historically provides keyboard a=
nd
>> mouse (aux) support, is hardwired in the driver rather than parsing the
>> dts.
>>
>> In addition the interrupts are provided in the dts, but in a way that is
>> not easily parsable using irq_of_parse_and_map().
>>
>> This patch modifies the powerpc legacy IO code to attempt to parse the
>> device tree for this information, failing back to the hardcoded values i=
f
>> it fails. For this to succeed the interrupts for the keyboard and mouse
>> ports need to be moved from the parent i8042 node to the individual port
>> nodes.
>>
>> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
>> ---
>>
>> To get irq_of_parse_and_map() to successfully parse the interrupts, I ha=
d
>> to do this to my device tree:
>>
>> @@ -120,16 +120,17 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address=
-cells =3D <1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
<1 0x60 0x1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A01 0x64 0x1>;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts=
 =3D <1 1 12 1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D <&lpc_pic>;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keyboard=
@0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D <0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 interrupts =3D <1 1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 compatible =3D "pnpPNP,303";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mouse@1 =
{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D <0x1>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 interrupts =3D <12 1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 compatible =3D "pnpPNP,f03";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> I'm not sure how to parse for the correct interrupt if I don't do this. =
I
>> this is incorrect and someone could advise me on how the existing device
>> tree layout can be properly parsed, I'll happily modify this patch.

Call of_irq_parse_and_map() on the parent node, using the second
parameter to specify if you want the first or second irq.  You get the
parent node with of_get_parent().

Although looking at this fragment, I don't understand why the i8042
node doesn't have its own compatible property.  Maybe there is
something historical that I'm missing here.

g.
