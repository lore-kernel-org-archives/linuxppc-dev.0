Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <6.0.1.1.1.20040128085052.01b12d40@192.168.2.1>
Date: Wed, 28 Jan 2004 09:25:40 +0100
To: linuxppc-embedded@lists.linuxppc.org
From: Matteo Bortolin <matteo.bortolin@wawnet.biz>
Subject: Problem with i2c-algo-ibm_ocp driver on ppc405 board
Cc: llandre@wawnet.biz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've developed an RTC driver that uses i2c core and for a PPC405-based
board (PPChameleonEVB).
The i2c-Algorithm driver is the i2c-algo-ibm_ocp.c and the i2c-adapter is
the i2c-adap-ibm_ocp.c
The problem is in timer_interrupt() function (/arch/ppc/kernel/time.c) with
CONFIG_RTC_11_MINUTE_MODE enabled.
Into this function there is a call to a ppc_md.set_rtc_time  that is a
pointer to a my set_rtc_device function that in turn
calls the i2c_master_send().
The problem is that kernel crashes (kenrel panic) when ppc_md.set_rtc_time
is called.
Debugging the coed,  I've seen that kernel crashes into iic_sendbytes()
function (i2c-algo-ibm_opc.c) .

After debugging inside of  iic_sendbytes() function I asked to me:

As in the time_interrupt() function, interrupt are disabled,
i2c-algo-ibm_ocp.c cannot work properly.

This would mean that a kernel that use  i2c-algo-ibm_ocp.c and a i2c
RTC-driver cannot work properly
with CONFIG_RTC_11_MINUTE_MODE!!!

Is this correct?

If yes, how can I solve my problem?




Matteo Bortolin

DAVE Srl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
