Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bFxq6GgmzDrHN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 23:12:14 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id m13-v6so7526135qth.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 06:12:14 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180724175531.75276cf4e539124aa9e27177@linux-foundation.org>
References: <20180724111600.4158975-1-arnd@arndb.de>
 <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
 <aa39b6d15f44555cb79d5ebdef74aeab19003d6a.camel@perches.com>
 <20180724175531.75276cf4e539124aa9e27177@linux-foundation.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Jul 2018 15:12:11 +0200
Message-ID: <CAK8P3a3tOuP1FVS7oD1UhO5s4C+fLkL8VT3eCpRnSxBZxKzf6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Samuel Ortiz <sameo@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Cameron <jic23@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-iio@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>,
 lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tools/perf/tests/.gitignore:
                            LLVM byte-codes, uncompressed
On Wed, Jul 25, 2018 at 2:55 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 24 Jul 2018 17:13:20 -0700 Joe Perches <joe@perches.com> wrote:
>
>> On Tue, 2018-07-24 at 14:00 -0700, Andrew Morton wrote:
>> > On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>> > > Almost all files in the kernel are either plain text or UTF-8
>> > > encoded. A couple however are ISO_8859-1, usually just a few
>> > > characters in a C comments, for historic reasons.
>> > > This converts them all to UTF-8 for consistency.
>> []
>> > Will we be getting a checkpatch rule to keep things this way?
>>
>> How would that be done?
>
> I'm using this, seems to work.
>
>         if ! file $p | grep -q -P ", ASCII text|, UTF-8 Unicode text"
>         then
>                 echo $p: weird charset
>         fi

There are a couple of files that my version of 'find' incorrectly identified as
something completely different, like:

Documentation/devicetree/bindings/pinctrl/pinctrl-sx150x.txt:
            SemOne archive data
Documentation/devicetree/bindings/rtc/epson,rtc7301.txt:
            Microsoft Document Imaging Format
Documentation/filesystems/nfs/pnfs-block-server.txt:
            PPMN archive data
arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi:
        Sendmail frozen configuration  - version = "host";
Documentation/networking/segmentation-offloads.txt:
        StuffIt Deluxe Segment (data) : gmentation Offloads in the
Linux Networking Stack
arch/sparc/include/asm/visasm.h:                              SAS 7+
arch/xtensa/kernel/setup.c:                                         ,
init=0x454c, stat=0x090a, dev=0x2009, bas=0x2020
drivers/cpufreq/powernow-k8.c:
TI-XX Graphing Calculator (FLASH)
tools/testing/selftests/net/forwarding/tc_shblocks.sh:
                            Minix filesystem, V2 (big endian)
tools/perf/tests/.gitignore:
                            LLVM byte-codes, uncompressed

All of the above seem to be valid ASCII or UTF-8 files, so the check
above will lead
to false-positives, but it may be good enough as they are the
exception, and may be
bugs in 'file'.

Not sure if we need to worry about 'file' not being installed.

       Arnd
