Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0EDBAB6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 15:44:19 +1000 (EST)
Received: by iwc10 with SMTP id 10so6332713iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 May 2011 22:44:17 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4DBF922F.8040703@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<1300782452-528-4-git-send-email-hs@denx.de>
	<20110502222716.GB15187@ponder.secretlab.ca>
	<BANLkTik3L28mmL=LGZ_0nV7vSOX9Miw3ow@mail.gmail.com>
	<4DBF922F.8040703@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 May 2011 23:43:57 -0600
Message-ID: <BANLkTinH+dsW3MMxs_WfyxeE--HAQzhzLQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] video, sm501: add edid and commandline support
To: hs@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 2, 2011 at 11:27 PM, Heiko Schocher <hs@denx.de> wrote:
> Hello Grant,
>
> Grant Likely wrote:
>> On Mon, May 2, 2011 at 4:27 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>> On Tue, Mar 22, 2011 at 09:27:29AM +0100, Heiko Schocher wrote:
>>>> - add commandline options:
>>>> =A0 sm501fb.mode:
>>>> =A0 =A0 Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>>>> =A0 sm501fb.bpp:
>>>> =A0 =A0 Specify bit-per-pixel if not specified mode
>>>>
>>>> - Add support for encoding display mode information
>>>> =A0 in the device tree using verbatim EDID block.
>>>>
>>>> =A0 If the "edid" entry in the "smi,sm501" node is present,
>>>> =A0 the driver will build mode database using EDID data
>>>> =A0 and allow setting the display modes from this database.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>> Merged, thanks.
>>
>> This patch causes the following build warning:
>
> Hups ... when I posted the patch, it compiled clean ...
>
>> =A0 MODPOST vmlinux.o
>> WARNING: vmlinux.o(.text+0x1d5572): Section mismatch in reference from
>> the function sm501fb_init_fb() to the variable
>> .devinit.data:sm501_default_mode
>> The function sm501fb_init_fb() references
>> the variable __devinitdata sm501_default_mode.
>> This is often because sm501fb_init_fb lacks a __devinitdata
>> annotation or the annotation of sm501_default_mode is wrong.
>>
>> WARNING: vmlinux.o(.text+0x1d557a): Section mismatch in reference from
>> the function sm501fb_init_fb() to the variable
>> .devinit.data:sm501_default_mode
>> The function sm501fb_init_fb() references
>> the variable __devinitdata sm501_default_mode.
>> This is often because sm501fb_init_fb lacks a __devinitdata
>> annotation or the annotation of sm501_default_mode is wrong.
>>
>> I've dropped the __devinitdata declaration in what I committed; can
>> you investigate and post a fixup patch?
>
> Of course, I look ASAP at it, thanks!
> (Dummy question: where can I find your tree?)

git://git.secretlab.ca/git/linux-2.6 powerpc/next

g.

>
> bye,
> Heiko
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
