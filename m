Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymPZh63ChzDrM4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 00:26:36 +1100 (AEDT)
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com
 [209.85.216.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 70F5121934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 13:26:34 +0000 (UTC)
Received: by mail-qt0-f178.google.com with SMTP id j12so422126qtc.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 05:26:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU-qQWmDi=V-G=r=poQf-F9hqL2SmoKi+SZyUwEj5vBGw@mail.gmail.com>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
 <CAMuHMdU-qQWmDi=V-G=r=poQf-F9hqL2SmoKi+SZyUwEj5vBGw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Nov 2017 07:26:13 -0600
Message-ID: <CAL_Jsq+kCA8QvdfU97TDcprfR3XuGj2WWO_mwiUSNr3D+WbU7g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 28, 2017 at 7:13 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rob,
>
> On Mon, Aug 21, 2017 at 5:16 PM, Rob Herring <robh@kernel.org> wrote:
>> With dependencies on a statically allocated full path name converted to
>> use %pOF format specifier, we can store just the basename of node, and
>> the unflattening of the FDT can be simplified.
>>
>> This commit will affect the remaining users of full_name. After
>> analyzing these users, the remaining cases should only change some print
>> messages. The main users of full_name are providing a name for struct
>> resource. The resource names shouldn't be important other than providing
>> /proc/iomem names.
>
> I guess the plan is to get rid in a subsequent step of all calls to kbasename()
> on a full name, which is now futile?

No. Sparc (PDT) is still the full path and I don't plan to change that.

Rob
