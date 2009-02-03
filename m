Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id EB49FDDEF1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 02:10:58 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so697215ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Feb 2009 07:10:57 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 3 Feb 2009 10:10:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/44x: Fix address decoding setup of PCI 2.x cells
Message-ID: <20090203151050.GA10541@yoda.jdub.homelinux.org>
References: <20090202002429.ADA74DDF43@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090202002429.ADA74DDF43@ozlabs.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 02, 2009 at 11:24:18AM +1100, Benjamin Herrenschmidt wrote:
>The PCI 2.x cells used on some 44x SoCs only let us configure the decode
>for the low 32-bit of the incoming PLB addresses. The top 4 bits (this
>is a 36-bit bus) are hard wired to different values depending on the
>specific SoC in use. Our code used to work "by accident" until I added
>support for the ISA memory holes and while at it added more validity
>checking of the addresses.
>
>This patch should bring it back to working condition. It still relies
>on the device-tree being correct but that's somewhat a pre-requisite
>for anything to work anyway.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>---
>
>This is untested. Geert, can you give it a go on Sequoia and let me
>know if it fixes your problem ?

Since Geert tested it somewhat successfully, perhaps we should get
this one into 2.6.29.  I have no other fixes outstanding, so feel
free to pull it in yourself.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
