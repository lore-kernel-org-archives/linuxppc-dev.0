Return-Path: <henk.stegeman@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 30EA3DE034
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 20:32:21 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so627882ywb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 02:32:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200903071109.49726.jbe@pengutronix.de>
References: <ae4f76fd0902200151m461f9336x1e2bbec61f815fde@mail.gmail.com>
	<200903071109.49726.jbe@pengutronix.de>
Date: Mon, 9 Mar 2009 10:32:19 +0100
Message-ID: <ae4f76fd0903090232n21152b02of5ebcac86c60e53a@mail.gmail.com>
Subject: Re: Davicom DM9000A on MPC5200B (powerpc) works using a dirty
	offsetting and byte trick
From: Henk Stegeman <henk.stegeman@gmail.com>
To: Juergen Beisert <jbe@pengutronix.de>
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

Juergen,


I don't understand how this would work,

Now I do one byte-swap, which works.
 -I byteswap in software, for 16-bit cycles by byte swapping and for 8
bit cycles by adding an offset of 1.
 (The byte swapping on the chipselect is off)

Your advice includes two byteswaps, one by re-routing the data bus and
one by enabling the byte swap on the chip-select.
Or does one of them not really swap bytes?


Henk

On Sat, Mar 7, 2009 at 11:09 AM, Juergen Beisert <jbe@pengutronix.de> wrote=
:
> Henk,
>
> On Freitag, 20. Februar 2009, Henk Stegeman wrote:
>> - Any suggestions to what could be wrong here? Or does the MPC5200 in
>> this case only byte swap u16 reads, but a u8 read is unchanged?
>
> You should not follow the Freescale bus signal names when you connect you=
r
> external little endian device. Otherwise the offsets are always wrong.
>
> Do it in this way instead:
>
> =A0 =A0MPC =A0 =A0 =A0 =A0 =A0LE Device
> =A0D[0..7] =A0 <-> =A0D[24..31]
> =A0D[8..15] =A0<-> =A0D[16..23]
> =A0D[16..23] <-> =A0D[8..15]
> =A0D[24..31] <-> =A0D[0..7]
>
> If you connect your device in such a way, just enable CS's byte swap feat=
ure
> depending on your bus size and you are done (no additional software
> manipulation required). Now you can write bytes, words or longs and you w=
ill
> always write the correct data into the corresponding device register.
>
> Hope it helps
> Juergen
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
> Linux Solutions for Science and Industry =A0 =A0 =A0| Phone: +49-8766-939=
 228 =A0 =A0 |
> Vertretung Sued/Muenchen, Germany =A0 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-=
5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://www.=
pengutronix.de/ =A0|
>
