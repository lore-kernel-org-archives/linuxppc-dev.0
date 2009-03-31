Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 825F1DDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 21:58:35 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2802267wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 03:58:33 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <OFEAA9D1E3.4B2F3270-ONC125758A.00307236-C125758A.00322239@transmode.se>
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
	<49CCD3E8.9040007@freescale.com>
	<OFEFCEAFB5.CC21FFBB-ONC1257589.005AEF16-C1257589.005B64EB@transmode.se>
	<49D0FFBB.7000009@freescale.com>
	<OF3127420C.081D4097-ONC1257589.00603E3D-C1257589.006093B3@transmode.se>
	<49D1052D.2050609@freescale.com>
	<OF70832E04.3DC53F05-ONC1257589.00663AFF-C1257589.0066C397@transmode.se>
	<49D11E47.8080106@freescale.com>
	<OFEAA9D1E3.4B2F3270-ONC125758A.00307236-C125758A.00322239@transmode.se>
Date: Tue, 31 Mar 2009 18:58:33 +0800
Message-ID: <2a27d3730903310358t56caaba9uba6e1835b716bc25@mail.gmail.com>
Subject: Re: [PATCH] ucc_geth: Rework the TX logic.
From: Li Yang <leoli@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 5:07 PM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> Scott Wood <scottwood@freescale.com> wrote on 30/03/2009 21:32:23:
>>
>> Joakim Tjernlund wrote:
>> >> different since descriptors are in MURAM which is ioremap()ed --
> though
>> >> switching to a cacheable mapping with barriers should be a
> performance
>> >> improvement.
>> >
>> > I always thought that MURAM was very fast. The whole reason to have
> BDs in
>> > MURAM is that it is faster than normal RAM, at least that is what I
>> > thought.
>>
>> Yeah, on second thought it probably wouldn't be worth it. =C2=A0There's =
also
>> the question of under what circumstances the QE's MURAM accesses will be
>
>> cache-coherent.
>
> I am a bit confused, what isn't worth it? Currently MURAM isn't used by
> ucc_geth, but
> it is easy to change. Swap MEM_PART_SYSTEM to MEM_PART_MURAM, however,
> just
> tried that and the driver stopped working. I known this worked earlier
> because
> I tried it and I even think I sent a patch to Leo.
>
> What choices do we have, I see three:
>
> 1) MEM_PART_SYSTEM, as today.
> 2) MEM_PART_MURAM. I guess this should be uncacheable memory?
> 3) as gianfar, dma_alloc_coherent(). I presume this is uncacheable memory=
?
>

1 and 3 are the same.  All of them use cacheable memory as we have a
hardware coherency module to take care of the cache coherency problem.
 However it might be better to use dma_alloc_coherent() for the code
to be more readible.  Thanks.

- Leo
