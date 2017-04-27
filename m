Return-Path: <keescook@google.com>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDVgK6gqPzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 07:38:21 +1000 (AEST)
Received: by mail-it0-x232.google.com with SMTP id f187so25906836ite.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:38:21 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1493292794-13166-1-git-send-email-ankit@linux.vnet.ibm.com>
References: <1493292794-13166-1-git-send-email-ankit@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 27 Apr 2017 14:38:17 -0700
Message-ID: <CAGXu5jLG66piVw-L08X6wL00f4mXi0BT=EtcbO0ochCMBCASXQ@mail.gmail.com>
Subject: Re: [PATCH] Enabled pstore write for powerpc
To: Ankit Kumar <ankit@linux.vnet.ibm.com>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Geliang Tang <geliangtang@163.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 27, 2017 at 4:33 AM, Ankit Kumar <ankit@linux.vnet.ibm.com> wrote:
> After commit c950fd6f201a kernel registers pstore write based on flag set.
> Pstore write for powerpc is broken as flags(PSTORE_FLAGS_DMESG) is not set for
> powerpc architecture. On panic, kernel doesn't write message to
> /fs/pstore/dmesg*(Entry doesn't gets created at all).
>
> This patch enables pstore write for powerpc architecture by setting
> PSTORE_FLAGS_DMESG flag.
>
> Fixes:c950fd6f201a pstore: Split pstore fragile flags
> Signed-off-by: Ankit Kumar <ankit@linux.vnet.ibm.com>

Argh, thanks! I thought I'd caught all of these. I'll include this for -stable.

-Kees

> ---
>
>  arch/powerpc/kernel/nvram_64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index d5e2b83..021db31 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -561,6 +561,7 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>  static struct pstore_info nvram_pstore_info = {
>         .owner = THIS_MODULE,
>         .name = "nvram",
> +       .flags = PSTORE_FLAGS_DMESG,
>         .open = nvram_pstore_open,
>         .read = nvram_pstore_read,
>         .write = nvram_pstore_write,
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
