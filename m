Return-Path: <pku.leo@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64BA12C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2012 01:35:41 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fn1so1484251vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 07:35:37 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20121031132650.GP10998@arwen.pp.htv.fi>
References: <1351670761-26749-1-git-send-email-xtfeng@gmail.com>
 <1351670761-26749-2-git-send-email-xtfeng@gmail.com>
 <20121031132650.GP10998@arwen.pp.htv.fi>
Date: Wed, 31 Oct 2012 22:35:37 +0800
Message-ID: <CADRPPNSQzCrHRQMoFf280pqS7AUOAzOq-swT3Hwagphiire5-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: gadget: fsl_qe_udc: do not use tasklet_disable
 before tasklet_kill
From: Li Yang <leoli@freescale.com>
To: balbi@ti.com
Content-Type: text/plain; charset=UTF-8
Cc: Xiaotian Feng <dannyfeng@tencent.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaotian Feng <xtfeng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 31, 2012 at 9:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Oct 31, 2012 at 04:06:00PM +0800, Xiaotian Feng wrote:
>> If tasklet_disable() is called before related tasklet handled,
>> tasklet_kill will never be finished. tasklet_kill is enough.
>
> how did you test this ? Why changing FSL driver instead of switching
> over to chipidea which is supposed to be shared by every licensee of the
> chipidea core ?

The QE UDC is an private controller that is not compatible with the
Chipidea core.

- Leo
