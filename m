Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x234.google.com (mail-ot0-x234.google.com
 [IPv6:2607:f8b0:4003:c0f::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLgyb1QRKzF0VN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 06:58:46 +1100 (AEDT)
Received: by mail-ot0-x234.google.com with SMTP id t35so8057364otd.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:58:46 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1dc0e4ce-2190-eb83-166f-b8ba7cdacede@ozlabs.org>
References: <20180116170053.2557047-1-arnd@arndb.de>
 <1dc0e4ce-2190-eb83-166f-b8ba7cdacede@ozlabs.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Jan 2018 20:58:44 +0100
Message-ID: <CAK8P3a1kLQdaYog9oqFGVs6GoLp0D+4nnAf2M-nzr-7U12_cjw@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] spufs: use timespec64 for timestamps
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 16, 2018 at 8:07 PM, Jeremy Kerr <jk@ozlabs.org> wrote:
> Hi Arnd,
>
>> The switch log prints the tv_sec portion of timespec as a 32-bit
>> number, while overflows in 2106. It also uses the timespec type,
>> which is safe on 64-bit architectures, but deprecated because
>> it causes overflows in 2038 elsewhere.
>>
>> This changes it to timespec64 and printing a 64-bit number for
>> consistency.
>
> If we still have spufs in the tree in 2038 I'd be worried :)

Agreed. My hope is to get rid of 'timespec' in 2018 though, this is just
one of many parts of the puzzle.

         Arnd
