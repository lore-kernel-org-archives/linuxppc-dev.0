Date: Wed, 28 Jan 2004 10:16:23 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Matteo Bortolin <matteo.bortolin@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org, llandre@wawnet.biz
Subject: Re: Problem with i2c-algo-ibm_ocp driver on ppc405 board
Message-ID: <20040128181623.GA13472@gate.ebshome.net>
References: <6.0.1.1.1.20040128085052.01b12d40@192.168.2.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6.0.1.1.1.20040128085052.01b12d40@192.168.2.1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 28, 2004 at 09:25:40AM +0100, Matteo Bortolin wrote:
> I've developed an RTC driver that uses i2c core and for a PPC405-based
> board (PPChameleonEVB).
> The i2c-Algorithm driver is the i2c-algo-ibm_ocp.c and the i2c-adapter is
> the i2c-adap-ibm_ocp.c
> The problem is in timer_interrupt() function (/arch/ppc/kernel/time.c) with
> CONFIG_RTC_11_MINUTE_MODE enabled.
> Into this function there is a call to a ppc_md.set_rtc_time  that is a
> pointer to a my set_rtc_device function that in turn
> calls the i2c_master_send().
> The problem is that kernel crashes (kenrel panic) when ppc_md.set_rtc_time
> is called.
> Debugging the coed,  I've seen that kernel crashes into iic_sendbytes()
> function (i2c-algo-ibm_opc.c) .
>
> After debugging inside of  iic_sendbytes() function I asked to me:
>
> As in the time_interrupt() function, interrupt are disabled,
> i2c-algo-ibm_ocp.c cannot work properly.
>
> This would mean that a kernel that use  i2c-algo-ibm_ocp.c and a i2c
> RTC-driver cannot work properly
> with CONFIG_RTC_11_MINUTE_MODE!!!
>
> Is this correct?

Yes, i2c layer must be called from process context only,
timer_interrupt is IRQ context.

> If yes, how can I solve my problem?

Please, search mail list archives, there was _lengthly_ discussion
about this problem before, even some patches were posted.

Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
