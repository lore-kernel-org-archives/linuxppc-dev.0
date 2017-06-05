Return-Path: <danielmicay@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whDVL5wdZzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 22:22:50 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id d68so21751681ita.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 05:22:50 -0700 (PDT)
Message-ID: <1496665366.343.1.camel@gmail.com>
Subject: Re: [kernel-hardening] [PATCH] powerpc: Increase ELF_ET_DYN_BASE to
 1TB for 64-bit applications
From: Daniel Micay <danielmicay@gmail.com>
To: Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc: bhupesh.linux@gmail.com, Anton Blanchard <anton@samba.org>, Daniel
 Cashman <dcashman@android.com>, Kees Cook <keescook@chromium.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Mon, 05 Jun 2017 08:22:46 -0400
In-Reply-To: <1496642591-1373-1-git-send-email-bhsharma@redhat.com>
References: <1496642591-1373-1-git-send-email-bhsharma@redhat.com>
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

Rather than doing this, the base should just be split for an ELF
interpreter like PaX. It makes sense for a standalone executable to be
as low in the address space as possible. Doing that ASAP fixes issues
like this and opens up the possibility of fixing stack mapping ASLR
entropy on various architectures. It should be a pretty small change.
