Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 47D2DB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 Nov 2009 03:51:03 +1100 (EST)
Received: by ywh39 with SMTP id 39so2054158ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 08:51:01 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257590153.3960.3.camel@odin>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083345.18908.96473.stgit@angua>
	<1257590153.3960.3.camel@odin>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 7 Nov 2009 09:50:41 -0700
Message-ID: <fa686aa40911070850l31f4f290mfb384af92ae2ca1f@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/6] ASoC/mpc5200: Track DMA position by
	period number instead of bytes
To: Liam Girdwood <lrg@slimlogic.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 7, 2009 at 3:35 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Sat, 2009-11-07 at 01:33 -0700, Grant Likely wrote:
>> All DMA blocks are lined up to period boundaries, but the DMA
>> handling code tracks bytes instead. =A0This patch reworks the code
>> to track the period index into the DMA buffer instead of the
>> physical address pointer. =A0Doing so makes the code simpler and
>> easier to understand.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Very minor coding style thing below otherwise all get my Ack.
>
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Thanks Liam.

>> - =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt +=3D s->period_bytes;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (s->period_current_pt >=3D s->period_end)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s->pe=
riod_start;
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->period_current =3D (s->period_current+1) % =
s->runtime->periods;
>
> I prefer a space around operators.
>
> s->period_current =3D (s->period_current + 1) % s->runtime->periods;

So do I, but this kept the line length down below 80 chars.  Avoiding
the line spillage this way looks nicer than the alternatives.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
