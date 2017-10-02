Return-Path: <keescook@google.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5XL53vTzzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 06:29:48 +1100 (AEDT)
Received: by mail-io0-x22b.google.com with SMTP id l15so5683785iol.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Oct 2017 12:29:48 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20170925194130.GV8421@gate.crashing.org>
References: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAGXu5jJ54+bCcXaPK1ExsxtTDPHNn1+1gywb3TDbe-SEtt1zuQ@mail.gmail.com>
 <20170925073721.GM8421@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F58B@AcuExch.aculab.com>
 <20170925194130.GV8421@gate.crashing.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 2 Oct 2017 12:29:45 -0700
Message-ID: <CAGXu5j+bj1NHmrrEmcwPavKubavLh1b01AyyJEFRvycg9FkLpg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix RODATA_TEST failure "rodata_test: test data was
 not read only"
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: David Laight <David.Laight@aculab.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, Jinbum Park <jinb.park7@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 25, 2017 at 12:41 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Mon, Sep 25, 2017 at 04:01:55PM +0000, David Laight wrote:
>> From: Segher Boessenkool
>> > The compiler puts this item in .sdata, for 32-bit.  There is no .srodata,
>> > so if it wants to use a small data section, it must use .sdata .
>> >
>> > Non-external, non-referenced symbols are not put in .sdata, that is the
>> > difference you see with the "static".
>> >
>> > I don't think there is a bug here.  If you think there is, please open
>> > a GCC bug.
>>
>> The .sxxx sections are for 'small' data that can be accessed (typically)
>> using small offsets from a global register.
>> This means that all sections must be adjacent in the image.
>> So you can't really have readonly small data.
>>
>> My guess is that the linker script is putting .srodata in with .sdata.
>
> .srodata does not *exist* (in the ABI).

So, I still think this is a bug. The variable is marked const: this is
not a _suggestion_. :) If the compiler produces output where the
variable is writable, that's a bug.

I can't tell if this bug is related:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=9571

-Kees

-- 
Kees Cook
Pixel Security
