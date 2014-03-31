Return-Path: <luto@amacapital.net>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29A6F14009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 10:50:09 +1100 (EST)
Received: by mail-qg0-f53.google.com with SMTP id e89so1530207qgf.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 16:50:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALCETrWuUcinbJ5v2LzaFWEg1vkBAB2H8rD9x0jccawwRwb4pQ@mail.gmail.com>
References: <CALCETrWuUcinbJ5v2LzaFWEg1vkBAB2H8rD9x0jccawwRwb4pQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 31 Mar 2014 16:49:45 -0700
Message-ID: <CALCETrVG=49tVCFDfgQ=2EMJrV582JxGzfadGM+JxfL59JxG0A@mail.gmail.com>
Subject: Re: OOPS in hvc / virtconsole
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2014 at 3:31 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> I'm running a Fedora distro kernel (3.13.7-200.fc20.x86_64) in kvm
> with these options:
>
> -chardev null,id=hvc0,signal=off
> -device virtio-serial-pci
> -device virtconsole,chardev=hvc0,name=virtme_console
> -append console=hvc0 console=ttyS0
> -nographic
>
> (There are more, but these are the interesting ones, I think.)

You can reproduce it by downloading this:

https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git/commit/?h=crash-virtconsole&id=c55df415154e6331a1dc96a5e2ffcf5c684fc2f9

and running:

./virtme-run --installed-kernel 3.13.7-200.fc20.x86_64 --console
--qemu-opts -m 2048 -smp 2

Adjust the requested kernel version as appropriate.

--Andy
