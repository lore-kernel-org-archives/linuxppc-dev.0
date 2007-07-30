Return-Path: <girish.sk@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 0186DDDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 03:07:50 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so265343anc
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 10:07:49 -0700 (PDT)
Message-ID: <34ac6d890707301007j128e4656tf8319c7b19e362a1@mail.gmail.com>
Date: Mon, 30 Jul 2007 22:37:49 +0530
From: "Girish kathalagiri" <girish.sk@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: BUG: scheduling while atomic
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_34589_1666409.1185815269568"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_34589_1666409.1185815269568
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I am running linux-2.6.22.1-rt8 on mpc5200 and on running stress

./stress --cpu 8 --io 4 --vm 2 --vm-bytes 2M --timeout 300s

I get the following stack.But this does not happen with non rt kernel.

   LR = 0xff51fcc
BUG: scheduling while atomic: stress/0x00000002/739, CPU#0
Call Trace:
[c04fbb80] [c0008650] show_stack+0x50/0x190 (unreliable)
[c04fbbb0] [c0016fc0] __schedule_bug+0x38/0x48
[c04fbbc0] [c01d4f7c] __schedule+0x3dc/0x450
[c04fbbf0] [c01d56c8] schedule+0x54/0xf0
[c04fbc00] [c01d6390] rt_spin_lock_slowlock+0x100/0x224
[c04fbc60] [c0052198] get_zone_pcp+0x30/0x58
[c04fbc80] [c0053078] free_hot_cold_page+0x114/0x1fc
[c04fbcb0] [c0056424] put_page+0x50/0x15c
[c04fbcd0] [c0069854] free_page_and_swap_cache+0x44/0x80
[c04fbce0] [c005d760] unmap_vmas+0x2e0/0x788
[c04fbd70] [c006292c] exit_mmap+0x74/0x108
[c04fbda0] [c001adc0] mmput+0x54/0xf0
[c04fbdc0] [c001ecfc] exit_mm+0xc0/0x124
[c04fbde0] [c001ffd0] do_exit+0x164/0x8bc
[c04fbe20] [c0020760] do_group_exit+0x38/0x90
[c04fbe40] [c002ba48] get_signal_to_deliver+0x2ac/0x3c0
[c04fbe70] [c000739c] do_signal+0x50/0x60c
[c04fbf40] [c000fec0] do_user_signal+0x74/0xc4
--- Exception: c00 at 0xfeab1dc
   LR = 0xff51fcc

Thanks in advance
-- 
Regards,
Giri

------=_Part_34589_1666409.1185815269568
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I am running linux-2.6.22.1-rt8 on mpc5200 and on running stress<br><br>./stress --cpu 8 --io 4 --vm 2 --vm-bytes 2M --timeout 300s<br><br>I get the following stack.But this does not happen with non rt kernel.<br><br>
 &nbsp; &nbsp;LR = 0xff51fcc<br>BUG: scheduling while atomic: stress/0x00000002/739, CPU#0<br>Call Trace:<br>[c04fbb80] [c0008650] show_stack+0x50/0x190 (unreliable)<br>[c04fbbb0] [c0016fc0] __schedule_bug+0x38/0x48<br>[c04fbbc0] [c01d4f7c] __schedule+0x3dc/0x450
<br>[c04fbbf0] [c01d56c8] schedule+0x54/0xf0<br>[c04fbc00] [c01d6390] rt_spin_lock_slowlock+0x100<div style="direction: ltr;">/0x224<br>[c04fbc60] [c0052198] get_zone_pcp+0x30/0x58<br>[c04fbc80] [c0053078] free_hot_cold_page+0x114/0x1fc
<br>[c04fbcb0] [c0056424] put_page+0x50/0x15c<br>[c04fbcd0] [c0069854] free_page_and_swap_cache+0x44/0x80<br>[c04fbce0] [c005d760] unmap_vmas+0x2e0/0x788<br>[c04fbd70] [c006292c] exit_mmap+0x74/0x108<br>[c04fbda0] [c001adc0] mmput+0x54/0xf0
<br>[c04fbdc0] [c001ecfc] exit_mm+0xc0/0x124<br>[c04fbde0] [c001ffd0] do_exit+0x164/0x8bc<br>[c04fbe20] [c0020760] do_group_exit+0x38/0x90<br>[c04fbe40] [c002ba48] get_signal_to_deliver+0x2ac/0x3c0<br>[c04fbe70] [c000739c] do_signal+0x50/0x60c
<br>[c04fbf40] [c000fec0] do_user_signal+0x74/0xc4<br>--- Exception: c00 at 0xfeab1dc<br> &nbsp; &nbsp;LR = 0xff51fcc</div><br clear="all">Thanks in advance<br>-- <br>Regards,<br>Giri

------=_Part_34589_1666409.1185815269568--
