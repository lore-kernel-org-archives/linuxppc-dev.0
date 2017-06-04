Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wgtJ36Kl5zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 08:42:43 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id w1so12181386qtg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Jun 2017 15:42:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170604142205.4c66c31b@roar.ozlabs.ibm.com>
References: <20170603071843.11966-1-bsingharora@gmail.com>
 <20170603071843.11966-6-bsingharora@gmail.com>
 <20170604142205.4c66c31b@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 5 Jun 2017 08:42:40 +1000
Message-ID: <CAKTCnz=CNqcCVP7pL++dy-i2CRHs4heo9fYBFWX0X884DfkrgA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] powerpc/vmlinux.lds: Align __init_begin to 16M
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Laura Abbott <labbott@redhat.com>, Rashmica Gupta <rashmica.g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 4, 2017 at 2:22 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Sat,  3 Jun 2017 17:18:39 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> For CONFIG_STRICT_KERNEL_RWX align __init_begin to 16M.
>> We use 16M since its the larger of 2M on radix and 16M
>> on hash for our linear mapping. The plan is to have
>> .text, .rodata and everything upto __init_begin marked
>> as RX. Note we still have executable read only data.
>> We could further align read only data to another 16M
>> boundary, but then the linker starts using stubs and
>> that breaks our assembler code in head_64.S
>
> Is this still the case with powerpc next?
>

Sorry, no, I was on linux-next for testing, but I think your linker
stub patches went in very recently. I'll rebase on top and test,
but I am not sure if I want two 16M alignments and bloat the size
of vmlinux. But I'll double check what happens

Balbir Singh.
