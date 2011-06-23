Return-Path: <mikebwilliams@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36BE0B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jun 2011 00:27:18 +1000 (EST)
Received: by fxm5 with SMTP id 5so1507372fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 07:27:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTikKNqEoQxGA642h14eOUjZ3hGZaQw@mail.gmail.com>
References: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
	<14e6cd940efae1704f5908757f81f627@kernel.crashing.org>
	<BANLkTikKNqEoQxGA642h14eOUjZ3hGZaQw@mail.gmail.com>
Date: Thu, 23 Jun 2011 10:21:44 -0400
Message-ID: <BANLkTinisHPrEN8Xc_KoqFwxknMooE=H4w@mail.gmail.com>
Subject: Fwd: [PATCH] powerpc, 460gt: Add 460gt as compatible in the check for
	460ex-compatible crypto
From: Mike Williams <mikebwilliams@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 7:24 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> - =A0 =A0 =A0 if (of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-cry=
pto")) {
>> + =A0 =A0 =A0 if (of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-cry=
pto") ||
>> + =A0 =A0 =A0 =A0 =A0 of_find_compatible_node(NULL, NULL, "amcc,ppc460gt=
-crypto")) {
>
> If the device is actually compatible, the device tree node should claim
> it is, and you do not need this code change.

That was actually my first instinct, however I tried to follow the
current convention in the glacier and canyonlands DTS files, which is
to set every device compatible to 460gt or 460ex, depending on the
processor. Many of the devices are identical between the two, since
they are variations of the same SoC, so which is the preferred method?
Follow the device tree convention and add the compatibility check in
the driver, or alter the device trees? I'll send another patch if it's
the latter.

Thanks,
Mike

>
>
> Segher
>
>
