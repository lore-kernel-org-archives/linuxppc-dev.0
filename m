Return-Path: <vneethv@gmail.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FC9B2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 13:29:39 +1100 (EST)
Received: by mail-wi0-f177.google.com with SMTP id hm14so1083841wib.16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 18:29:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFbQSaCxSVDRW=kcjkrbrm=8Sy4N0q29ALfqb4o3UdB3crY64g@mail.gmail.com>
References: <CAFbQSaBm-0ROHX80JQN6ef4Hgy1PgH8PmYRSRpyJ1+mNo+HnbQ@mail.gmail.com>
 <CAFbQSaCxSVDRW=kcjkrbrm=8Sy4N0q29ALfqb4o3UdB3crY64g@mail.gmail.com>
From: Vineeth <vneethv@gmail.com>
Date: Wed, 30 Jan 2013 07:59:14 +0530
Message-ID: <CAFbQSaB=gw3+P0-yDhjOFnP2z_sYzUHbw+MuFp8QLdF7xyuGUA@mail.gmail.com>
Subject: Re: PREMPT_RT
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=f46d04428f12f2532904d4784747
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04428f12f2532904d4784747
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've added a VDSO patch on my 2.6.32 kernel. When i enabled PREMPT_RT i am
getting the below oops messages.
What is the reason for this ? When googled, it was mentioned in many places
that it is caused by the get_cpu()/put_cpu() preempt disabled region.
Can someone help me to understand this ?

BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
pcnt: 10002 0 in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper
Call Trace:
[c0771d40] [c000750c] show_stack+0x44/0x160 (unreliable)
[c0771d70] [c0021114] __might_sleep+0xe4/0x108
[c0771d80] [c05700bc] rt_spin_lock+0x38/0xb4
[c0771d90] [c005a3b0] ntp_tick_length+0x20/0x54
[c0771db0] [c00594e8] update_wall_time+0xb0/0xa3c
[c0771e20] [c0040bc0] do_timer+0x38/0x4c
[c0771e30] [c005f2c4] tick_do_update_jiffies64+0x1cc/0x2a8
[c0771e70] [c005f494] tick_check_idle+0xf4/0x120
[c0771ea0] [c0039a50] irq_enter+0x68/0x7c
[c0771eb0] [c000ae78] timer_interrupt+0xb0/0x168
[c0771ed0] [c000e84c] ret_from_except+0x0/0x18
[c0771f90] [c000874c] cpu_idle+0x58/0xf4
[c0771fb0] [c0002330] rest_init+0xa0/0xb0
[c0771fc0] [c06fc9d4] start_kernel+0x320/0x334
[c0771ff0] [c00003f0] skpinv+0x308/0x344


Thanks

--f46d04428f12f2532904d4784747
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><span style=3D"font-family:trebuchet ms,sans-ser=
if">Hi,<br><br>I&#39;ve added a VDSO patch on my 2.6.32 kernel. When i enab=
led PREMPT_RT i am getting the below oops messages.<br>What
 is the reason for this ? When googled, it was mentioned in many places=20
that it is caused by the get_cpu()/put_cpu() preempt disabled region.<br>

Can someone help me to understand this ?<br><br>BUG: sleeping function call=
ed from invalid context at kernel/rtmutex.c:684<br>pcnt: 10002 0 in_atomic(=
): 1, irqs_disabled(): 1, pid: 0, name: swapper<br>Call Trace:<br>[c0771d40=
] [c000750c] show_stack+0x44/0x160 (unreliable)<br>

[c0771d70] [c0021114] __might_sleep+0xe4/0x108<br>[c0771d80] [c05700bc] rt_=
spin_lock+0x38/0xb4<br>[c0771d90] [c005a3b0] ntp_tick_length+0x20/0x54<br>[=
c0771db0] [c00594e8] update_wall_time+0xb0/0xa3c<br>[c0771e20] [c0040bc0] d=
o_timer+0x38/0x4c<br>

[c0771e30] [c005f2c4] tick_do_update_jiffies64+0x1cc/0x2a8<br>[c0771e70] [c=
005f494] tick_check_idle+0xf4/0x120<br>[c0771ea0] [c0039a50] irq_enter+0x68=
/0x7c<br>[c0771eb0] [c000ae78] timer_interrupt+0xb0/0x168<br>[c0771ed0] [c0=
00e84c] ret_from_except+0x0/0x18<br>

[c0771f90] [c000874c] cpu_idle+0x58/0xf4<br>[c0771fb0] [c0002330] rest_init=
+0xa0/0xb0<br>[c0771fc0] [c06fc9d4] start_kernel+0x320/0x334<br>[c0771ff0] =
[c00003f0] skpinv+0x308/0x344<br><br><br>Thanks</span></div><br>

--f46d04428f12f2532904d4784747--
