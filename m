Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x231.google.com (mail-vc0-x231.google.com
 [IPv6:2607:f8b0:400c:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F02551A0C12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 07:17:19 +1100 (AEDT)
Received: by mail-vc0-f177.google.com with SMTP id id10so15412892vcb.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:17:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55088AF1.5040305@hurleysoftware.com>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
 <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
 <55079859.1020205@hurleysoftware.com>
 <CAJhHMCBzFfKxubMLkrSwCwqs5q494-kD2=a_n+tGHXAp6qgXDg@mail.gmail.com>
 <55079D05.8020302@hurleysoftware.com>
 <CAJhHMCDNRCUY-H_DzrDf+9LYZOiiEVLW_f7ygp6mRKx-ho7OeA@mail.gmail.com>
 <5508887B.8080008@hurleysoftware.com>
 <CAJhHMCDWJZR0rgfMzNKX=btMPCmFfBH-WU0fY3oo0G8TtpdSBA@mail.gmail.com>
 <55088AF1.5040305@hurleysoftware.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 17 Mar 2015 16:16:47 -0400
Message-ID: <CAJhHMCDXQSAiSSpv2=O9V+ezo6a5QPvEjaPLVaymiart_fOTaQ@mail.gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
To: Peter Hurley <peter@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2015 at 4:13 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/17/2015 04:07 PM, Pranith Kumar wrote:
>> On Tue, Mar 17, 2015 at 4:03 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>
>>> Can you send me a complete dmesg capture from a boot with
>>> this commit reverted?
>>>
>>
>> Here it is. Let me know if you want any boot options enabled. I
>> removed both debug and verbose boot options.
>
> Ok, thanks.
>
> This is just like Andreas' problem: with my patch, there is _no_ console.
>
> Note those console command line options in your config aren't actually
> in your kernel command line. That really threw me; I couldn't figure out
> how you didn't have a tty0 console.
>
>> [    0.000000] Kernel command line:
>> root=UUID=7252209a-6106-41c2-90a3-45b85ac47837 ro video=radeonfb:off
>> video=offb:off radeon.modeset=1 radeon.agpmode=-1
>

Hmm, interesting. These arguments are passed from the yaboot.conf
which has a line as follows:

append="video=radeonfb:off video=offb:off radeon.modeset=1 radeon.agpmode=-1"

I thought this would append these arguments to the default kernel
command line argument in the config. Apparently it is not. So, the
resolution for this is to add the console argument to yaboot.conf I
guess, right?

-- 
Pranith
