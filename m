Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zt7ZM67t4zF1k2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 23:16:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: dts: replace 'linux,
 stdout-path' with 'stdout-path'
In-Reply-To: <CAL_JsqKn3hXaaYYef47afK+E=WUfZyfF6ejGD0vX7C8sNjhdFw@mail.gmail.com>
References: <20180228224406.7049-1-robh@kernel.org>
 <87606ga8bv.fsf@concordia.ellerman.id.au>
 <CAL_JsqKn3hXaaYYef47afK+E=WUfZyfF6ejGD0vX7C8sNjhdFw@mail.gmail.com>
Date: Fri, 02 Mar 2018 23:16:24 +1100
Message-ID: <87k1uuwu3r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Herring <robh@kernel.org> writes:

> On Wed, Feb 28, 2018 at 7:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Rob Herring <robh@kernel.org> writes:
>>
>>> 'linux,stdout-path' has been deprecated for some time in favor of
>>> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
>>> Search and replace all the of occurrences with 'stdout-path'.
>>
>> This patch looks OK.
>>
>> But please remember that not all device trees are generated with dtc, we
>> still have machines in the wild that have firmware which use
>> "linux,stdout-path" and may never be updated.
>
> Absolutely. The core code still supports both.

Phew ;)

It has prompted us to look at various firmware pieces and some we can
update to start using the new property or both. It's still going to be
many years before we can actually remove support for linux,stdout-path
though.

> The only scenario I could come up with is someone has an old
> bootloader that only understands linux,stdout-path and modifies it and
> they update the dtb. We may end up with both properties with
> stdout-path taking preference.

Yeah I think this is fairly safe, and in the unlikely case it does cause
a problem we can always back the change out for an individual file.

cheers
