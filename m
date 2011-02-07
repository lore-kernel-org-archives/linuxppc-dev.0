Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31469B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 02:01:00 +1100 (EST)
Received: by fxm5 with SMTP id 5so4944296fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Feb 2011 07:00:55 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20110207145031.GL10564@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208011324.d5371c4c.sfr@canb.auug.org.au>
	<20110207141829.GK10564@opensource.wolfsonmicro.com>
	<20110208014432.2c9288e4.sfr@canb.auug.org.au>
	<20110207145031.GL10564@opensource.wolfsonmicro.com>
Date: Mon, 7 Feb 2011 16:00:55 +0100
Message-ID: <AANLkTikw7j5Q7CGZK=Xbcgubt9LYBGiXf01wQ4nbg8NR@mail.gmail.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-embedded@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@lists.linux-foundation.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 7, 2011 at 15:50, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Feb 08, 2011 at 01:44:32AM +1100, Stephen Rothwell wrote:
>> On Mon, 7 Feb 2011 14:18:29 +0000 Mark Brown <broonie@opensource.wolfson=
micro.com> wrote:
>
>> > Do you mean that these systems require CONFIG_PM be turned off, or jus=
t
>> > that people tend not to turn it on? =C2=A0If the latter would you expe=
ct any
>> > ill effects from doing so?
>
>> I don't know the answer to either question without testing. =C2=A0All I =
am
>> saying is that currently the default for CONFIG_PM is "off" and you are
>> changing it to be "on" and there may not have been any testing done of
>> that in some situations. =C2=A0 We don't know where it was explicitly
>> turned off any more since we shrank our defconfig files (which was done
>> automatically) ... since it is off by default, it doesn't need to be
>> mentioned in a defconfig unless it needs to be turned on.
>
> My suspicion would be that it'll have been turned off by someone hitting
> return through a config upgrade rather than through deliberate effort.
> On the other hand if it is essential for some machines to have it
> disabled they probably want to have somethnig in Kconfig.

$ git grep "CONFIG_PM is not set"
7cf3d73b4360e91b14326632ab1aeda4cb26308d^ -- arch/ | wc -l
256
$

7cf3d73b4360e91b14326632ab1aeda4cb26308d is the commit that introduced
savedefconfig, so that's a safe revision with untrimmed defconfigs.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
