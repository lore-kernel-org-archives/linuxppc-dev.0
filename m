Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wytbH4x91zDr46
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:47:55 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id w12so10448141qta.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 01:47:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170629034122.GI23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 29 Jun 2017 18:47:50 +1000
Message-ID: <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
Subject: Re: [v4.12-rc1 regression] mount ext4 fs results in kernel crash on
 PPC64le host
To: Eryu Guan <eguan@redhat.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, liwan@redhat.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 1:41 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, Jun 29, 2017 at 03:16:10AM +1000, Balbir Singh wrote:
>> On Wed, Jun 28, 2017 at 6:32 PM, Eryu Guan <eguan@redhat.com> wrote:
<snip>
>> Thanks for the excellent bug report, I am a little lost on the stack
>> trace, it shows a bad page access that we think is triggered by the
>> mmap changes? The patch changed the return type to integrate the call
>> into trace-cmd. Could you point me to the tests that can help
>> reproduce the crash. Could you also suggest how long to try the test
>> cases for?
>
> Sorry, I should have provided it in the first place. It's as simple as
> mounting an ext4 filesystem on my test ppc64le host, i.e.
>
> mkdir -p /mnt/ext4
> mkfs -t ext4 -F /dev/sda5
> mount /dev/sda5 /mnt/ext4
>

I tried this test a few times with the kernel and could not reproduce it.
Could you please share the config and compiler details, I'll retry with -rc7.

In the meanwhile, does enabling kmemleak, DEBUG_PAGE_ALLOC,
slub/slab debug, list corruption, etc catch anything at the time of the
corruption?

Thanks,
Balbir Singh.
