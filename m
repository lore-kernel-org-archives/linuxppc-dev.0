Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 3587BB70A2
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Sep 2010 04:27:41 +1000 (EST)
Received: by ewy2 with SMTP id 2so2452010ewy.15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 11:27:39 -0700 (PDT)
Date: Fri, 10 Sep 2010 22:27:35 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: =?utf-8?B?QW5kcsOp?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20100910182735.GA28479@oksana.dev.rtsoft.ru>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<1284106293.2267.42.camel@swa-m460>
	<20100910173706.GD11284@angua.secretlab.ca>
	<1284142484.2152.18.camel@swa-e6500>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1284142484.2152.18.camel@swa-e6500>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 10, 2010 at 08:14:44PM +0200, André Schwarz wrote:
[...]
> > Does the device actually generate edge interrupts?  Or is it a level
> > irq device?  If it is a level irq device, then the correct way to
> > handle this is to disable the irq line so that the event can be
> > handled at non-irq context, and then reenable it when finished.
> 
> The irq is level-low active.
> Will do it via disable/re-enable then.

FYI, In newer kernels you don't have to do it manually, there's
request_threaded_irq() for this.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
