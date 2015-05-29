Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A0E71A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:54:25 +1000 (AEST)
Received: by pabru16 with SMTP id ru16so42062599pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 21:54:23 -0700 (PDT)
Message-ID: <5567F0F9.6050609@ozlabs.ru>
Date: Fri, 29 May 2015 14:54:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
CC: Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/3] fbuffer: performance improvement + code cleanup
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/28/2015 11:13 PM, Greg Kurz wrote:
> If booted in frame buffer mode, board-qemu currently calls hv-logical-load
> and hv-logical-store for every pixel when enabling or disabling the cursor.
> This is suboptimal when writing one char at a time to the console since
> terminal-write always toggles the cursor. And this is precisely what grub
> is doing when the user wants to edit a menu entry... the result is an
> incredibly slow and barely usable interface.
>
> This series introduces per-board helpers to be used by the frame buffer
> code, so that board-qemu may have its own accelarated implementation:
>
> - the first patch is preliminary cleanup, before moving code out to helpers.
>
> - the second patch introduces a helper to invert a memory region byte-per-byte:
>    this fixes the unbearable slowliness of grub editing mode.
>
> - the third patch introduces a similar helper with a a quad-word pace: it
>    doesn't bring any speed improvement since board-qemu already uses
>    hv-logical-memop, but it allows to "unify hcall-invert-screen and
>    fb8-invert-screen again".
>
> Please comment.

Thanks, I'll remove that extra line in 3/3 and push these today.


>
> ---
>
> Greg Kurz (3):
>        fbuffer: simplify address computations in fb8-toggle-cursor
>        fbuffer: introduce the invert-region helper
>        fbuffer: introduce the invert-region-x helper
>
>
>   board-js2x/slof/helper.fs               |    9 +++++++++
>   board-qemu/slof/helper.fs               |    7 +++++++
>   board-qemu/slof/pci-device_1234_1111.fs |   10 +---------
>   slof/fs/fbuffer.fs                      |    8 +++-----
>   4 files changed, 20 insertions(+), 14 deletions(-)
>
> --
> Greg
>


-- 
Alexey
