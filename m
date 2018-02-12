Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg30c5zswzF0hh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 22:12:16 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id g5so9204723uac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 03:12:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 12 Feb 2018 22:12:13 +1100
Message-ID: <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param
 xmon=off
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2018 at 7:59 PM, Vaibhav Jain
<vaibhav@linux.vnet.ibm.com> wrote:
> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line.
>
> This minor patch updates setup_xmon_sysrq() to register
> 'sysrq_xmon_op' only when variable 'xmon_on' is set.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Any specific issue you've run into without this patch? I presume
running xmon=off indicates we don't want xmon to take over in case of
panic/die/oops, why are we tying this to sysrq?

Balbir Singh.
