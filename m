Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 8F2CA1A0101
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 09:34:59 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 308112034C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 22:34:57 +0000 (UTC)
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C105D20306
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 22:34:54 +0000 (UTC)
Received: by mail-yk0-f172.google.com with SMTP id x67so165959070ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 14:34:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
References: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 30 Dec 2015 16:34:34 -0600
Message-ID: <CAL_JsqJW+D0AEOfYxObMoDYY3kobvwh93kcLrsW65u2Jr3ctLQ@mail.gmail.com>
Subject: Re: [RFC 1/1] powerpc: legacy serial port use device tree cell-index
 property
To: Curt Brune <curt@cumulusnetworks.com>
Cc: Kumar Gala <galak@codeaurora.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2015 at 12:46 PM, Curt Brune <curt@cumulusnetworks.com> wrote:
> Currently for PowerPC systems using device tree, the legacy serial
> ports are allocated in the order by which they are found in the device
> tree structure.
>
> This can cause problems in cases where the device tree nodes are
> sysnthesized by an external program (kexec for example), which may not
> preserve the original order of the device tree nodes.  This in turn
> can result in the serial console changing from ttyS0 to ttyS1
> unexpectedly.
>
> This patch uses the 'cell-index' property (if present) to map UART
> device tree nodes to legacy serial port number.  The cell-index
> property is widely used in all the Freescale .dts files for PowerPC.

If cell-index is already present in the dtbs, then this is okay.
Otherwise use aliases. cell-index is pretty much deprecated.

Rob
