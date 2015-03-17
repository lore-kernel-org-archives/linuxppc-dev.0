Return-Path: <peter@hurleysoftware.com>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1459A1A0A02
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 07:03:11 +1100 (AEDT)
Received: by qgf3 with SMTP id 3so18885771qgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:03:09 -0700 (PDT)
Message-ID: <5508887B.8080008@hurleysoftware.com>
Date: Tue, 17 Mar 2015 16:03:07 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
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
In-Reply-To: <CAJhHMCDNRCUY-H_DzrDf+9LYZOiiEVLW_f7ygp6mRKx-ho7OeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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

On 03/17/2015 02:33 AM, Pranith Kumar wrote:
> On Mon, Mar 16, 2015 at 11:18 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 03/16/2015 11:12 PM, Pranith Kumar wrote:
>>> On Mon, Mar 16, 2015 at 10:58 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>>> What is your init?
>>>>>
>>>>> I am using systemd from debian unstable.
>>>>
>>>> Do you have a stdout-path property defined in your dts to a serial
>>>> console you're not actually using?
>>>>
>>>
>>> I am using tty0 as my console. From the config which I posted, it has:
>>>
>>> CONFIG_CMDLINE="console=ttyS0,9600 console=tty0"
>>>
>>> I am not using any device tree file.
>>
>> Ok; there was some reported breakage on PowerMac wrt to 'stdout-path'
>> changes I made, so I thought I'd check if that might have affected
>> your setup as well.
>>
> 
> And the painful slow bisecting did lead to that commit:
> 
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [2fa645cb2703d9b3786d850db815414dfeefa51d] of: Fix premature
> bootconsole disable with 'stdout-path'
> 
> $ git show 2fa645cb2703d9b3786d850db815414dfeefa51d
> commit 2fa645cb2703d9b3786d850db815414dfeefa51d
> Author: Peter Hurley <peter@hurleysoftware.com>
> Date:   Sun Mar 1 12:21:22 2015 -0500
> 
>     of: Fix premature bootconsole disable with 'stdout-path'

Can you send me a complete dmesg capture from a boot with
this commit reverted?
