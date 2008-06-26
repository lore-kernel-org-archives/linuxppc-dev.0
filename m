Return-Path: <madrabbit@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 2410BDEC17
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 02:35:23 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so92130rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 09:35:22 -0700 (PDT)
Message-ID: <2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>
Date: Thu, 26 Jun 2008 09:35:22 -0700
From: "Ray Lee" <ray-lk@madrabbit.org>
Sender: madrabbit@gmail.com
To: monstr@seznam.cz
Subject: Re: [PATCH 08/60] microblaze_v4: exception handling
In-Reply-To: <1214483429-32360-9-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
> +ex_sw:
> +       /* Get the destination register number into r5 */
> +       lbui    r5, r0, ex_reg_op;
> +       /* Form store_word jump table offset (sw_table + (8 * regnum)) */
> +       la      r6, r0, sw_table;
> +       add     r5, r5, r5;
> +       add     r5, r5, r5;
> +       add     r5, r5, r5;
> +       add     r5, r5, r6;
> +       bra     r5;

Possibly stupid question: This is part of the unaligned store word
exception handler, yes? Shouldn't the above add's be addk's to
preserve the state of the carry register pre/post store?
