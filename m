Return-Path: <pku.leo@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 91F08DE1B3
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 20:43:26 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so516522yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 03:43:24 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090512150552.a98dca64.akpm@linux-foundation.org>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
	<20090512150552.a98dca64.akpm@linux-foundation.org>
Date: Thu, 21 May 2009 18:43:23 +0800
Message-ID: <2a27d3730905210343k1e44225eh5555de768abdbb03@mail.gmail.com>
Subject: Re: [PATCH 3/6] powerpc: add memory map support to Freescale RapidIO
	block
From: Li Yang <leoli@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: zw@zh-kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 6:05 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 12 May 2009 16:36:00 +0800
> Li Yang <leoli@freescale.com> wrote:
>
>> + =C2=A0 =C2=A0 align =3D (size < 0x1000) ? 0x1000 : 1 << (__ilog2(size =
- 1) + 1);
>> +
>> + =C2=A0 =C2=A0 /* Align the size */
>> + =C2=A0 =C2=A0 if ((lstart + size) > (_ALIGN_DOWN(lstart, align) + alig=
n)) {
>
> __ilog2() and _ALIGN_DOWN() are powerpc-specific functions. =C2=A0It woul=
d
> be preferable to use more general helpers if possible. =C2=A0ALIGN() and =
ilog2()
> might suit here.

Will change to use ilog2().

_ALIGN_DOWN() gets a lower aligned address while ALIGN() gets a higher
address.  It seems that we don't have a general helper to do the same.

- Leo
