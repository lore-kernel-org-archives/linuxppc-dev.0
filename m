Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 6077BDDE33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 01:17:43 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so38200anc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 08:17:41 -0700 (PDT)
Message-ID: <fa686aa40708290817k897f8c2y5fdf12e5a48cc0ac@mail.gmail.com>
Date: Wed, 29 Aug 2007 09:17:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708290947560.2407-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708280828h408ce7damf04b31a2048d40c4@mail.gmail.com>
	<Pine.LNX.4.44.0708290947560.2407-100000@slslc02.psi.ch>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/29/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> Hi Grant,
>
>         My zImage.elf has 1.1 MB and uImage 968 KB.
> Could you tell me please how to hook up GDB to debug u-boot?

Ah-HA!  You're using the wrong type of kernel image.  When booting
from u-boot, you should be using a 'uImage', not a 'zImage.elf'.
(generated with 'make uImage' in the kernel tree).  An you should use
the 'bootm' command to boot the kernel.

With bootm, u-boot can pass parameters to the kernel and it is u-boot
that does the uncompression (instead of the zImage wrapper).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
