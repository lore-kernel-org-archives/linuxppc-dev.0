Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sd53m2j6XzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:36:36 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id l132so13537454wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 05:36:36 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
 <1472122446.2246.93.camel@kernel.crashing.org> <57DF23C4.20508@gmail.com>
 <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 19 Sep 2016 14:36:12 +0200
Message-ID: <CA+7wUsyOSCJzymLe7vyub8dvyvsEDuVU0auO2rGi6ohkBKBEoQ@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
To: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mike <michael.heltne@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Sep 19, 2016 at 11:13 AM, Herminio Hernandez, Jr.
<herminio.hernandezjr@gmail.com> wrote:
> Apologies for the previous email.
>
> What I was trying to say was I just recently installed Debain on my PowerMac
> G5. I upgraded to sid and install the nonfree firmware. After reboot I
> noticed that GPU acclleration was broken and I recieved the following error
>
> [   10.428542] [drm] Loading R300 Microcode
> [   10.486631] radeon 0000:f0:10.0: firmware: direct-loading firmware
> radeon/R300_cp.bin
> [   10.486865] [drm] radeon: ring at 0x0000000000010000
> [   10.634417] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring test
> failed (scratch(0x15E4)=0xCAFEDEAD)
> [   10.634526] [drm:.r100_cp_init [radeon]] *ERROR* radeon: cp isn't working
[...]
> [   11.935061] [drm] Forcing AGP to PCI mode

Well that is really odd. I am trying hard to push my pci patch upstream:

https://patchwork.kernel.org/patch/9088181/

I do believe PCI mode always work, so I would be interested if you
could report the bug upstream to have PCI mode work on all Powermac
(AGP is know to be broken).

Pay attention to your /etc/modules file check whether or not it
contains a option for the loaded modules, eg:

radeon.agpmode=-1

Finally your dmesg looks odd since the line `[drm] Forcing AGP to PCI
mode` comes only after the first error.

-M
