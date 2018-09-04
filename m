Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424fls2q5rzF35K
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 07:16:40 +1000 (AEST)
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so2283887pgo.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 14:16:40 -0700 (PDT)
Date: Wed, 5 Sep 2018 07:15:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
In-Reply-To: <20180904174808.GS335@mellanox.com>
References: <20180904174808.GS335@mellanox.com>
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

On Tue, 4 Sep 2018 11:48:08 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> Hi Nicholas,
> 
> I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> console..
> 
> Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> providing hvc0, using options like:
> 
>         -nographic
>         -chardev stdio,id=stdio,mux=on,signal=off
>         -mon chardev=stdio
> 	-device isa-serial,chardev=stdio
>         -device virtio-serial-pci
> 	-device virtconsole,chardev=stdio
> 
> I see the hvc0 console hang regularly, ie doing something like 'up
> arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> OK.
> 
> Any ideas? I'm not familiar with this code.. Thanks!

Yes I have had another report, I'm working on a fix. Sorry it has taken
a while and thank you for the report.

Thanks,
Nick
