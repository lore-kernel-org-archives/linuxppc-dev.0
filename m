Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJXMj5pmfzDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:07:45 +1000 (AEST)
Message-ID: <1464649665.16938.2.camel@ellerman.id.au>
Subject: Re: powerpc cross compiler issue
From: Michael Ellerman <mpe@ellerman.id.au>
To: Safa Hamza <safahamza1@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 May 2016 09:07:45 +1000
In-Reply-To: <CAFwQ9hGFeC2700F3yy4vYVNdbO3vid=9hH_qO-5PbOuRDAHGdw@mail.gmail.com>
References: <CAFwQ9hGFeC2700F3yy4vYVNdbO3vid=9hH_qO-5PbOuRDAHGdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-05-26 at 11:05 +0200, Safa Hamza wrote:

> hello every one
> please can any one suggest to me a powerpc cross compiler package or from
> source, i have downloaded  cross compiler package such as powerpc64le and i
> got a little endian and big endian problem, i  have tried also to download
> eldk cross compiler but i didn't know how  any suggestion please

If you're on Ubuntu:

  $ sudo apt-get install gcc-powerpc-linux-gnu gcc-powerpc64le-linux-gnu libc-dev-powerpc-cross libc-dev-ppc64el-cross

On Fedora I think it's called gcc-powerpc64-linux-gnu.

Then to build a big endian kernel:

  $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- mrproper
  $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- ppc64_defconfig
  $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -j 4


To build a little endian kernel:

  $ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- mrproper
  $ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- ppc64le_defconfig
  $ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- -j 4


cheers
