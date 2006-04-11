Return-Path: <kevinmorizur@hotmail.fr>
Received: from hotmail.com (bay109-f21.bay109.hotmail.com [64.4.19.31])
	by ozlabs.org (Postfix) with ESMTP id AC276679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 18:20:21 +1000 (EST)
Message-ID: <BAY109-F2190BC0CB3006D05D94A08A1CD0@phx.gbl>
From: "kevin morizur" <kevinmorizur@hotmail.fr>
To: linuxppc-embedded@ozlabs.org
Subject: RTC/I2C problems
Date: Tue, 11 Apr 2006 10:20:14 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody.

I have a problem with my RTC, i work on a MEN A12 board with MPC8245 and 
when my kernel start it takes 8 min to run. I have find the problem but i 
don't know how to solve it. In time.c the function time_init execute the 
following lines :

if (__USE_RTC()) {
    /* 601 processor: dec counts down by 128 every 128ns */
    tb_ticks_per_jiffy = DECREMENTER_COUNT_601;
    /* mulhwu_scale_factor(1000000000, 1000000) is 0x418937 */
    tb_to_us = 0x0x418937;
}  else {
    ppc_md.calibrate_decr();
    tb_to_ns_scale = mulhwu(tb_to_us, 1000 << 10);
}

this is the ppc_md.calibrate_decr() function that takes a lot of time and i 
don't know how to solve the problem. USE_RTC is fixed at 0 for 6xx config 
maybe it must be at 1 ? My RTC run with SMBus (I2C). I work with ELDK 4.0 
and linux 2.6.15.

Thanks in advance.

Regards.

_________________________________________________________________
Tout savoir sur la sécurité de vos enfants sur Internet ! 
http://go.msn.fr/10-channel/80-security/protection/default.asp
