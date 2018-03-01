Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsYSp51HdzF19q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 00:39:33 +1100 (AEDT)
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9201E217A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 13:39:31 +0000 (UTC)
Received: by mail-qk0-f174.google.com with SMTP id y137so7523354qka.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2018 05:39:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87606ga8bv.fsf@concordia.ellerman.id.au>
References: <20180228224406.7049-1-robh@kernel.org>
 <87606ga8bv.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Mar 2018 07:39:06 -0600
Message-ID: <CAL_JsqKn3hXaaYYef47afK+E=WUfZyfF6ejGD0vX7C8sNjhdFw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: dts: replace 'linux,
 stdout-path' with 'stdout-path'
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 7:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> 'linux,stdout-path' has been deprecated for some time in favor of
>> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
>> Search and replace all the of occurrences with 'stdout-path'.
>
> This patch looks OK.
>
> But please remember that not all device trees are generated with dtc, we
> still have machines in the wild that have firmware which use
> "linux,stdout-path" and may never be updated.

Absolutely. The core code still supports both.

The only scenario I could come up with is someone has an old
bootloader that only understands linux,stdout-path and modifies it and
they update the dtb. We may end up with both properties with
stdout-path taking preference.

Rob
