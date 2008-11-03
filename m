Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 1A147DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 20:00:09 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH V2] powerpc: Fix Book-E watchdog timer interval setting
Date: Mon, 3 Nov 2008 09:56:37 +0100
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<200809231704.56449.matthias.fuchs@esd-electronics.com>
	<ed82fe3e0809230931h10101b3csdc0187c19bac1529@mail.gmail.com>
In-Reply-To: <ed82fe3e0809230931h10101b3csdc0187c19bac1529@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811030956.37948.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur,

I missed you posting. But you are right. My patch is ok for 4xx CPUs and touching 
the CONFIG_FSL_BOOKE path was not my intention.

So for CONFIG_FSL_BOOKE WDTP_MASK should be WDTP(0). There is still a slightly difference
between WDTP(0)="(3 << 30) | (0x3c << 15)" and "(3 << 30) | (15 << 15)". 
Can you check that please and I will resend my patch.

Thanks for pointing that out.

Matthias

On Tuesday 23 September 2008 18:31, Timur Tabi wrote:
> On Tue, Sep 23, 2008 at 10:04 AM, Matthias Fuchs
> <matthias.fuchs@esd-electronics.com> wrote:
> >  #ifdef CONFIG_FSL_BOOKE
> >  #define WDTP(x)                ((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
> > +#define WDTP_MASK      (WDTP(63))
> 
> WDTP(63) is "((((63-63)&0x3)<<30)|(((63-63)&0x3c)<<15))", which is
> equal to 0.  Shouldn't WDTP_MASK be equal to "(3 << 30) | (15 << 15)"?
> 
