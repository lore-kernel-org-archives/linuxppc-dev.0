Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 9E93BDDF13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 04:35:46 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so377487ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 11:35:44 -0700 (PDT)
Message-ID: <528646bc0704251135v20c682ald996c0948a402277@mail.gmail.com>
Date: Wed, 25 Apr 2007 12:35:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver
In-Reply-To: <462F9B1A.3090906@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <462E0D5C.1090105@ru.mvista.com> <200704250035.18673.arnd@arndb.de>
	<462F98B4.2000108@ru.mvista.com> <462F9B1A.3090906@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/25/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Grant,
>
> > static struct xilinxfb_platform_data xilinxfb_pdata = {
> > #if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
> >     .use_dcr = 1;
> > #else
> >     .use_dcr = 0;
> > #endif
>
> IOW I am trying to avoid conditional compilation like:

I agree 100%.  All the device options should be specified dynamically.
 Heck, it should be possible to build a single kernel and boot it on
just about any design.

>
> #if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
> #define xilinxfb_out_be32(addr, mask)     mtdcr((addr), (mask))
> #else
> #define xilinxfb_out_be32(addr, mask)     out_be32((addr), (mask))
> #endif
>
> - as this would make the driver to include xparameters.h which would
> be an issue when moving to the OF device tree.

Which is a bad thing.  I believe that the Xilinx folks would like to
use the device tree for the microblaze target also; but there is a
fair bit of work that need to be done before that is feasable.

>
> Or "use DCR" could be a Kconfig option for the driver.

My preference would be for it to be a runtime thing.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
