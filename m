Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 03B2CDDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 02:08:28 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2059509ywb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 07:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20e286be3bc61f03018fc94366e6fd01@localhost>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
	<9d38520266f15d80352d1554e63c1ce6@localhost>
	<a57485706bfc7aae2295acd743445312@localhost>
	<fa686aa40903030723p7d82edbfg5928adf9fe108b01@mail.gmail.com>
	<7AC161D8-83A8-4330-A2CF-3120F15D9038@it-loops.com>
	<fa686aa40903031310o4e0c0b2bnba0544012b0fb8bc@mail.gmail.com>
	<68DDAAA9-42AF-4E9C-907C-7D3269816184@it-loops.com>
	<fa686aa40903040757n3992fec4jb6f3b75396af2958@mail.gmail.com>
	<20e286be3bc61f03018fc94366e6fd01@localhost>
Date: Thu, 5 Mar 2009 08:08:25 -0700
Message-ID: <fa686aa40903050708j3fa4f25ey2c5e940c70df094f@mail.gmail.com>
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Guntsche <mike@it-loops.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 5, 2009 at 12:41 AM, Michael Guntsche <mike@it-loops.com> wrote=
:
> On Wed, 4 Mar 2009 08:57:59 -0700, Grant Likely <grant.likely@secretlab.c=
a>
> wrote:
>> You might be able to use of_attach_node() & prom_add_property() to
>> modify the tree, but I've never done it myself. =A0Give it a try and
>> tell me if it works. =A0:-)
>>
>
> Hello Grant,
>
> I made some progress in this area, but I have now hit a problem I do not
> know how to solve.
> Taking code from the iseries/vio.c files I am able to add properties with
> add_string_property and add_raw_property.
> The problem I have is adding properties like
>
> =A0 =A0reg =3D <0x2520 0x20>
>
> I know how to add a property
>
> =A0 reg =3D <0x2520>
>
> but I do not know what data structure to pass to add_raw_property to add
> two numbers there.

Device tree properties are just "bags of bytes".  'cells' in device
tree nomenclature are big endian u32 values.  So, for specifying a
property with one cell (ie: reg =3D <0x2520>;), the data length is 4
bytes and the data is an array of 4 bytes: 0x00 0x00 0x25 0x20.  To
add a property with two cells (ie: reg =3D <0x2520 0x20>;), the data
length is 8 bytes and the data is and array of 8 bytes: 0x00 0x00 0x25
0x20 0x00 0x00 0x00 0x20.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
