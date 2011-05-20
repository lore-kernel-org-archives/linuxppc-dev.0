Return-Path: <ericvh@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4E4FB71A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 10:30:25 +1000 (EST)
Received: by fxm5 with SMTP id 5so2687869fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 17:30:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6241.1305847001@neuling.org>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-3-git-send-email-ericvh@gmail.com>
	<425.1305784718@neuling.org>
	<BANLkTimKhApFW8G1-pG0u_9Kv2YB0R1O0w@mail.gmail.com>
	<29601.1305840992@neuling.org>
	<BANLkTi=rc5vZm3xAXHpHSxSH1wBWKhv92A@mail.gmail.com>
	<6241.1305847001@neuling.org>
Date: Thu, 19 May 2011 19:30:20 -0500
Message-ID: <BANLkTindzEFRjEGkc9bLccrFUdVtvbA73A@mail.gmail.com>
Subject: Re: [PATCH 3/7] [RFC] add support for BlueGene/P FPU
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 6:16 PM, Michael Neuling <mikey@neuling.org> wrote:
> In message <BANLkTi=3Drc5vZm3xAXHpHSxSH1wBWKhv92A@mail.gmail.com> you wro=
te:
>> On Thu, May 19, 2011 at 4:36 PM, Michael Neuling <mikey@neuling.org> wro=
te:
>> > In message <BANLkTimKhApFW8G1-pG0u_9Kv2YB0R1O0w@mail.gmail.com> you wr=
ote=3D
>> :
>> >> On Thu, May 19, 2011 at 12:58 AM, Michael Neuling <mikey@neuling.org>=
 wr=3D
>> ote=3D3D
>> >> :
>> >> > Eric,
>> >> >
>> >> >> This patch adds save/restore register support for the BlueGene/P
>> >> >> double hummer FPU.
>> >> >
>> >> > What does this mean? =3D3DA0Needs more details here.
>> >> >
>>
>> okay, I've changed it a bit in [V2], if you want more I can do my best.
>
> If you can describe the whole primary and secondary registers that'd be
> cool. =A0ASCII art would be awesome! :-)
>

You sure you don't just want a bitfield.conf? :)  I'll do my best, but my
ASCII art isn't what it used to be.  I'll also include a reference to the P=
DF.

>> >
>> > Ok, sounds like there is 32*8*2 bytes of data, rather than the normal
>> > 32*8 bytes for FP only (ignoring VSX). =3DA0If this is the case, then =
you'l=3D
>> l
>> > need make 'fpr' in the thread struct bigger which you can do by settin=
g
>> > TS_FPRWIDTH =3D3D 2 like we do for VSX.
>> >

Okay - so basically what I have now and TS_FPRWIDTH=3D2 ?

>>
>> Since it isn't available on other chips, shoudl it just be PPC_BGP_FPU
>> or PPC_BGP_DOUBLE_FPU?
>
> I'd probably still prefer it disassociated with the CPU name, but we are
> really bike shedding here. =A0I'm not too fussed.
>

I'll leave it separate and switch it to PPC_FP2 (or would you prefer
PPC_FP2_FPU to make it clear) since the public PDF refers to it this way.

If that all sounds good, I'll spin [V3] tomorrow.

     -eric
