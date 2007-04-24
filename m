Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 0AE1ADDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 08:17:40 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so236547ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 15:17:39 -0700 (PDT)
Message-ID: <528646bc0704241517g595bf7bfqe54e40b05f74e933@mail.gmail.com>
Date: Tue, 24 Apr 2007 16:17:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver
In-Reply-To: <462E0D5C.1090105@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <462E0D5C.1090105@ru.mvista.com>
Cc: Rick Moleres <rick.moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/24/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Add support for the video controller IP block included into Xilinx ML300 and
> ML403 reference designs.
>
> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
> ---
>
> This patch relies on the "Patchset to establish sanity in Xilinx Virtex support" by Gran Likely to have
> the frame buffer device registered on the platform bus. Without this patchset one needs to fill in
> the struct platform_device and make sure platform_device_register() is called elsewhere.
>
> Reviews and comments are welcome.
>
> Would be nice to get this driver into mainline for the 2.6.22.

Quick comment on first perusal:  The driver uses the out_be32 macro
directly for accessing registers, which doesn't work if the FB block
is configured for DCR access (like the ML403 reference design).  There
will need to be a property in the platform device binding to determine
how to access registers.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
