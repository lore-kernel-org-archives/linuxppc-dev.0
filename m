Return-Path: <oohall@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sshmJ1hNHzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 12:06:56 +1100 (AEDT)
Received: from mail-qk0-x22c.google.com (mail-qk0-x22c.google.com
 [IPv6:2607:f8b0:400d:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sshmH4X7wz9ryk
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 12:06:55 +1100 (AEDT)
Received: by mail-qk0-x22c.google.com with SMTP id z190so74946695qkc.2
 for <linuxppc-dev@ozlabs.org>; Sun, 09 Oct 2016 18:06:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f9wbv6j.fsf@linux.vnet.ibm.com>
References: <0612c46e-7e1b-3729-d84f-cefa886abb6d@gmail.com>
 <877f9wbv6j.fsf@linux.vnet.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 10 Oct 2016 12:06:52 +1100
Message-ID: <CAOSf1CE2RJ2X_cB8nZz3UziFURqrqA7aLV+GVySY6k+8KPYTiA@mail.gmail.com>
Subject: Re: [PATCH] Fix "ibm,processor-radix-AP-encodings"
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@ozlabs.org, Chris Smart <chris@distroguy.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 12:43 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> The top 3 bits of the lower order byte should contain the
>> AP encoding, we assume the top 3 bits of the MSB.

Balbir, could you reword this so it says "Currently we wrongly assume
<blah>" or similar. The current commit message made me think you were
changing it to look at the top 3 bits of the MSB rather than changing
it look at the LSB.

> Are you sure, Power architecture documents always confuse about MSB vs
> lowe order bytes. ?

PAPR seems to be pretty consistent about "low order" meaning "least
significant." Additionally the PAPR that describes
ibm,processor-radix-AP-encodings says that it is formatted this way so
it can be used when constructing the register argument to tlbie. The
modes of tlbie that use the AP field place it in bits 56:59 so I think
Balbir's fix is correct.

Reviewed-By: Oliver O'Halloran <oohall@gmail.com>
