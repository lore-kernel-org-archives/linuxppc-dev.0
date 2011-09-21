Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9F9FBB6F8A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 18:30:13 +1000 (EST)
Date: Wed, 21 Sep 2011 10:29:54 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-ID: <20110921102954.151d7cde@wker>
In-Reply-To: <CAOZdJXUZsByLorWZNtDRMzsezF_qVX62+8zfiMKJqMMhCD2i3g@mail.gmail.com>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker> <4E012586.7050808@freescale.com>
	<20110622221143.503add74@wker>
	<CAOZdJXUZsByLorWZNtDRMzsezF_qVX62+8zfiMKJqMMhCD2i3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 21 Sep 2011 02:10:42 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:
...
> The definitions of MFB_SET_PIXFMT and MFB_GET_PIXFMT are wrong:
> 
> #define MFB_SET_PIXFMT          0x80014d08
> #define MFB_GET_PIXFMT          0x40014d08
> 
> The "01" is the size.  However, these ioctls take a __u32 as a parameter.
> 
> This means that I have to fix the definitions to this:
> 
> #define MFB_SET_PIXFMT          _IOW('M', 8, __u32)
> #define MFB_GET_PIXFMT          _IOR('M', 8, __u32)
> 
> This will change the values and break binary compatibility with your
> applications.  Are you okay with that?

yes. the app will be fixed for updated kernel.

> > Other ioctls can be removed. I'm not sure if someone
> > uses FBIOGET_GWINFO. If there are no objections from
> > other people, it can also be dropped.
> 
> I'm going to remove FBIOGET_GWINFO because no one is using it, and the
> ioctl value is malformed (it doesn't define a direction or size).

okay. 

Thanks,
Anatolij
