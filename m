Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfVmh4WnVzF0QY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 01:00:03 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id m28so5883747pgc.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 06:00:03 -0800 (PST)
Date: Sun, 11 Feb 2018 23:59:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
Message-ID: <20180211235944.14c2be39@roar.ozlabs.ibm.com>
In-Reply-To: <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
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

On Sat, 10 Feb 2018 13:54:27 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> In preparation for the following patch which will fix an issue on
> the 8xx by re-using the 'slices', this patch enhances the
> 'slices' implementation to support 32 bits CPUs.
> 
> On PPC32, the address space is limited to 4Gbytes, hence only the low
> slices will be used.
> 
> This patch moves "slices" functions prototypes from page64.h to slice.h
> 
> The high slices use bitmaps. As bitmap functions are not prepared to
> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
> slice_bitmap_xxx() functions which will void on PPC32

On this last point, I think it would be better to put these with the
existing slice bitmap functions in slice.c and just have a few #ifdefs
for SLICE_NUM_HIGH == 0.

Thanks,
Nick
