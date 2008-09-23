Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id A7D02DE074
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 02:31:58 +1000 (EST)
Received: by gxk14 with SMTP id 14so4428686gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 09:31:56 -0700 (PDT)
Message-ID: <ed82fe3e0809230931h10101b3csdc0187c19bac1529@mail.gmail.com>
Date: Tue, 23 Sep 2008 11:31:55 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Matthias Fuchs" <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH V2] powerpc: Fix Book-E watchdog timer interval setting
In-Reply-To: <200809231704.56449.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<200809192328.36159.matthias.fuchs@esd-electronics.com>
	<7CA29A12-6DC4-4939-9541-6270FE5D910A@kernel.crashing.org>
	<200809231704.56449.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 10:04 AM, Matthias Fuchs
<matthias.fuchs@esd-electronics.com> wrote:
>  #ifdef CONFIG_FSL_BOOKE
>  #define WDTP(x)                ((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
> +#define WDTP_MASK      (WDTP(63))

WDTP(63) is "((((63-63)&0x3)<<30)|(((63-63)&0x3c)<<15))", which is
equal to 0.  Shouldn't WDTP_MASK be equal to "(3 << 30) | (15 << 15)"?

-- 
Timur Tabi
Linux kernel developer at Freescale
