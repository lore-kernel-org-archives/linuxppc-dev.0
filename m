Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN0qY371czDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:41:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 xinhui.pan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
In-Reply-To: <559244cc-dcc0-a477-b51b-7417a61158ed@linux.vnet.ibm.com>
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20170214123540.38b995cb@roar.ozlabs.ibm.com>
 <559244cc-dcc0-a477-b51b-7417a61158ed@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 22:41:12 +1100
Message-ID: <87shnhknjb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pan Xinhui <xinhui@linux.vnet.ibm.com> writes:
> =E5=9C=A8 2017/2/14 10:35, Nicholas Piggin =E5=86=99=E9=81=93:
>> On Mon, 13 Feb 2017 19:00:42 -0200
>> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> wrote:
>>> * I had this patch partially done for some time, and after a discussion
>>> at the kernel slack channel latest week, I decided to rebase and fix
>>> some remaining bugs. I'd change 'x' option to always disable the debugg=
er,
>>> since with this patch we can always re-enable xmon, but today I noticed
>>> Pan's patch on the mailing list, so perhaps his approach of adding a fl=
ag
>>> to 'x' option is preferable. I can change this in a V2, if requested.
>>> Thanks in advance!
>>
>> xmon state changing after the first sysrq+x violates principle of least
>> astonishment, so I think that should be fixed.
>
> Hi, Guilherme
> So in the end, my thought is that:
> 1) cmd x|X will exit xmon and keep xmon in the original state

Agreed.

> 2) Then add options to turn some features on/off. And debugfs maybe
> not fit for this. But I am also wondering at same time, are people
> needing this?

I think it's useful. Especially seeing as Guilherme has already written
the code.

And yeah I think debugfs is the right place to do it. It means you can
query and/or set the xmon state without crashing the box - which is what
entering xmon essentially does, even if you later recover.

cheers
