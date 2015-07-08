Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 526DA1A1061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 11:56:34 +1000 (AEST)
Date: Wed, 8 Jul 2015 11:56:32 +1000
From: Anton Blanchard <anton@samba.org>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [kexec-lite PATCH] trampoline: Reset primary cpu endian to
 big-endian
Message-ID: <20150708115632.725120f1@kryten>
In-Reply-To: <1436318742-13490-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436318742-13490-1-git-send-email-sam.mj@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sam,

> Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> meaning if we kexec from a little-endian kernel the target kernel will
> fail to boot.
> Returning to big-endian before we enter the target kernel ensures that
> the target kernel can boot whether or not it includes FIXUP_ENDIAN.

Thanks!

I wonder if we can do something simpler, and always enter via rfid.
Avoids the need for the endian trampoline. Something like:

  	mtsrr0	r4

	mfmsr	r5
	clrrdi	r5,r5,1 	/* Clear MSR_LE */
	mtsrr1	r5

	li	r5,0

	rfid

Anton
