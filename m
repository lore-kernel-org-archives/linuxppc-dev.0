Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id E25E4DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 19:17:00 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2736312wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:16:59 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <49D0FFBB.7000009@freescale.com>
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2a27d3730903270245k6e8633eehfb5cd3fcebd36240@mail.gmail.com>
	<OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
	<49CCD3E8.9040007@freescale.com>
	<OFEFCEAFB5.CC21FFBB-ONC1257589.005AEF16-C1257589.005B64EB@transmode.se>
	<49D0FFBB.7000009@freescale.com>
Date: Tue, 31 Mar 2009 16:16:58 +0800
Message-ID: <2a27d3730903310116r4d8602b8y41e466801bbb8d3e@mail.gmail.com>
Subject: Re: [PATCH] ucc_geth: Rework the TX logic.
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 1:22 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> Joakim Tjernlund wrote:
>>
>> gianfar does not seem to use in_/out_ functions for the BDs. Works just
>> fine that too it seems.
>
> It does now that it has explicit barriers in a few places. =C2=A0Before t=
hey were
> added, it would sometimes fail under load. =C2=A0That was due to a compil=
er
> reordering, but CPU reordering was possible as well.

I noticed that in gianfar these memory access is not protected by
"volatile".  Can this be the reason why the compiler did some unwanted
optimization?

- Leo
