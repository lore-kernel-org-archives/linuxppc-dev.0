Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id BF902DDEF4
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 07:04:44 +1000 (EST)
Message-ID: <486404C3.10301@seznam.cz>
Date: Thu, 26 Jun 2008 23:06:11 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [PATCH 08/60] microblaze_v4: exception handling
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>	
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>	
	<2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>	
	<4863EBD9.1010601@seznam.cz>
	<2c0942db0806261243g52edd45eo11ded19bb1f24004@mail.gmail.com>
In-Reply-To: <2c0942db0806261243g52edd45eo11ded19bb1f24004@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ray Lee napsal(a):
> On Thu, Jun 26, 2008 at 12:19 PM, Michal Simek <monstr@seznam.cz> wrote:
>>> On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
>>>> +ex_sw:
>>>> +       /* Get the destination register number into r5 */
>>>> +       lbui    r5, r0, ex_reg_op;
>>>> +       /* Form store_word jump table offset (sw_table + (8 * regnum)) */
>>>> +       la      r6, r0, sw_table;
>>>> +       add     r5, r5, r5;
>>>> +       add     r5, r5, r5;
>>>> +       add     r5, r5, r5;
>>>> +       add     r5, r5, r6;
>>>> +       bra     r5;
>>> Possibly stupid question: This is part of the unaligned store word
>>> exception handler, yes? Shouldn't the above add's be addk's to
>>> preserve the state of the carry register pre/post store?
>> I don't think that addk is important. I have some tests for exception, I want to
>> cover full exception handling.
> 
> Okay. It doesn't match your other exception handlers, though, which is
> why I noticed it in the first place (they use addk).

thanks for notice. I'll keep in my mind when I test it.

M
