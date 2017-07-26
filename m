Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHcTr6YPdzDqnv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 00:11:12 +1000 (AEST)
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF7A520C51
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:11:10 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id u207so26824347ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:11:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2x35w9v.fsf@concordia.ellerman.id.au>
References: <20170725214427.25768-1-robh@kernel.org>
 <20170725214427.25768-5-robh@kernel.org>
 <87r2x35w9v.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jul 2017 09:10:49 -0500
Message-ID: <CAL_JsqL1+YqH-rGCHvYFANJBaZL9t1bcwOnPUntGAbaJWfmVrg@mail.gmail.com>
Subject: Re: [PATCH 4/4] of/fdt: only store the device node basename in
 full_name
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 26, 2017 at 5:26 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> With dependencies on a statically allocated full path name converted to
>> use %pOF format specifier, we can store just the basename of node, and
>> the unflattening of the FDT can be simplified.
>>
>> This commit will affect the remaining users of full_name. After
>> analyzing these users, the remaining cases should only change some print
>> messages. The main users of full_name are providing a name for struct
>> resource. The resource names shouldn't be important other than providing
>> /proc/iomem names.
>>
>> We no longer distinguish between pre and post 0x10 dtb formats as either
>> a full path or basename will work. However, less than 0x10 formats have
>> been broken since the conversion to use libfdt (and no one has cared).
>
> For the record - yes we did care. It broke booting with old versions of
> kexec, and it was a royal P.I.T.# to debug :D

Sorry, I forgot about that one. I'll drop the statement. I had gone
back and looked and only found the issue on mpc8323 booting[1] which
was an issue with libfdt having more checks on the fdt. I proposed
some fixes, but never heard back on that.

Rob

[1] https://lkml.org/lkml/2015/6/10/820
