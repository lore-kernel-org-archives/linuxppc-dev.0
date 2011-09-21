Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8138AB6F81
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 12:10:48 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Date: Wed, 21 Sep 2011 02:10:42 +0000
Message-ID: <CAOZdJXUZsByLorWZNtDRMzsezF_qVX62+8zfiMKJqMMhCD2i3g@mail.gmail.com>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker>	<4E012586.7050808@freescale.com>
	<20110622221143.503add74@wker>
In-Reply-To: <20110622221143.503add74@wker>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij,

I'm sorry to resurrect an old thread, but ...

On Wed, Jun 22, 2011 at 3:11 PM, Anatolij Gustschin <agust@denx.de> wrote:
> On Tue, 21 Jun 2011 23:13:11 +0000
> Tabi Timur-B04825 <B04825@freescale.com> wrote:
>
>> Anatolij Gustschin wrote:
>> > No! We are using ioctl interface of this driver in many video
>> > rendering applications on overlay planes on huge number of boards.
>> > So, please don't remove it.
>>
>> Ok, I had no idea anyone was using it.
>>
>> Can you email me details about how you use the ioctl interface? =A0If I =
can't
>> remove it, maybe I can clean it up.
>
> Following DIU specific ioctls are used:
>
> MFB_SET_CHROMA_KEY
> MFB_SET_PIXFMT
> MFB_GET_PIXFMT
> MFB_SET_AOID
> MFB_GET_AOID
> MFB_GET_ALPHA
> MFB_SET_ALPHA

The definitions of MFB_SET_PIXFMT and MFB_GET_PIXFMT are wrong:

#define MFB_SET_PIXFMT          0x80014d08
#define MFB_GET_PIXFMT          0x40014d08

The "01" is the size.  However, these ioctls take a __u32 as a parameter.

This means that I have to fix the definitions to this:

#define MFB_SET_PIXFMT          _IOW('M', 8, __u32)
#define MFB_GET_PIXFMT          _IOR('M', 8, __u32)

This will change the values and break binary compatibility with your
applications.  Are you okay with that?

> Other ioctls can be removed. I'm not sure if someone
> uses FBIOGET_GWINFO. If there are no objections from
> other people, it can also be dropped.

I'm going to remove FBIOGET_GWINFO because no one is using it, and the
ioctl value is malformed (it doesn't define a direction or size).

--=20
Timur Tabi
Linux kernel developer at Freescale=
