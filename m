Return-Path: <runaway@candw.ms>
Received: from smtp754.redcondor.net (smtp754.redcondor.net [208.80.206.54])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2nXs0MZxzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 00:13:00 +1000 (AEST)
Subject: Re: Canyonlands oops at Shutdown
To: Michael Ellerman <mpe@ellerman.id.au>
References: <572C9109.80804@candw.ms>
Cc: linuxppc-dev@lists.ozlabs.org
From: Julian Margetson <runaway@candw.ms>
Message-ID: <dabf6045-7fc5-b28e-6dd0-b8fa9ddf04b3@candw.ms>
Date: Sun, 8 May 2016 10:12:40 -0400
MIME-Version: 1.0
In-Reply-To: <572C9109.80804@candw.ms>
Content-Type: multipart/alternative;
 boundary="------------988382C5E841DC2AA8BFDBDB"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------988382C5E841DC2AA8BFDBDB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/2016 8:41 AM, Julian Margetson wrote:
> Getting the following at shutdown with Kernel 4.6-rc's on Sam460ex 
> Canyonlands board .
>
> Regards
> Julian
>
>
> [ 1533.722779] Unable to handle kernel paging request for data at 
> address 0x01000028
> [ 1533.744309] Faulting instruction address: 0xc026d3c8
> [ 1535.763583] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 1535.782886] PREEMPT Canyonlands
> [ 1535.799805] Modules linked in:
> [ 1535.816546] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 
> 4.6.0-rc6-sam460ex-jm #4
> [ 1535.838341] task: ea850000 ti: ea846000 task.ti: ea846000
> [ 1535.857783] NIP: c026d3c8 LR: c0466984 CTR: c001a8ac
> [ 1535.876847] REGS: ea847d10 TRAP: 0300   Not tainted 
> (4.6.0-rc6-sam460ex-jm)
> [ 1535.898224] MSR: 00029000 <CE,EE,ME>  CR: 44422284  XER: 00000000
> [ 1535.918868] DEAR: 01000028 ESR: 00000000
> GPR00: c0466984 ea847dc0 ea850000 01000008 0000000f fffffff0 00000000 
> 00000007
> GPR08: 00000001 c0b5a19c 00000000 ea847de0 28428468 205cfe94 205a946e 
> bfff8a7c
> GPR16: 2097d008 2097d018 2097d090 bfff8980 bfff897c 00000000 00000000 
> 4321fedc
> GPR24: 2097d578 c0b3f17c c0b80000 00000000 c0a95e68 eaa35000 c0b8545c 
> 01000008
> [ 1536.024665] NIP [c026d3c8] kobject_get+0x18/0x80
> [ 1536.044003] LR [c0466984] get_device+0x1c/0x38
> [ 1536.063198] Call Trace:
> [ 1536.080424] [ea847dc0] [eaa3fa10] 0xeaa3fa10 (unreliable)
> [ 1536.100896] [ea847dd0] [c0466984] get_device+0x1c/0x38
> [ 1536.121059] [ea847de0] [c04689f4] device_shutdown+0x58/0x178
> [ 1536.141727] [ea847e10] [c003c280] kernel_halt+0x38/0x64
> [ 1536.161875] [ea847e20] [c003c4cc] SyS_reboot+0x140/0x1b0
> [ 1536.182057] [ea847f40] [c000ad80] ret_from_syscall+0x0/0x3c
> [ 1536.202568] --- interrupt: c01 at 0x203d1fbc
> [ 1536.202568]     LR = 0x2058f878
> [ 1536.239761] Instruction dump:
> [ 1536.257358] 4bffff9c 7fa3eb78 484cad91 39610020 7fe3fb78 4bda3d74 
> 9421fff0 7c0802a6
> [ 1536.280308] 93e1000c 7c7f1b79 90010014 41820060 <813f0020> 2f890000 
> 41bc001c 809f0000
> [ 1536.303611] ---[ end trace f5a63492b41c62f2 ]---
> [ 1536.323546]
> [ 1537.340293] note: systemd-shutdow[1] exited with preempt_count 1
> [ 1537.363602] Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b
> [ 1537.363602]
> [ 1537.404665] Rebooting in 180 seconds..
>
Adjusted my .config and it is working now .

Regards

Julian


CONFIG_PPC44x_SIMPLE=y

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_SYSFS is not set
#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_BOOKE_WDT is not set
# CONFIG_MEN_A21_WDT is not set
#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set


--------------988382C5E841DC2AA8BFDBDB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 5/6/2016 8:41 AM, Julian Margetson
      wrote:<br>
    </div>
    <blockquote cite="mid:572C9109.80804@candw.ms" type="cite">Getting
      the following at shutdown with Kernel 4.6-rc's on Sam460ex
      Canyonlands board .
      <br>
      <br>
      Regards
      <br>
      Julian
      <br>
      <br>
      <br>
      [ 1533.722779] Unable to handle kernel paging request for data at
      address 0x01000028
      <br>
      [ 1533.744309] Faulting instruction address: 0xc026d3c8
      <br>
      [ 1535.763583] Oops: Kernel access of bad area, sig: 11 [#1]
      <br>
      [ 1535.782886] PREEMPT Canyonlands
      <br>
      [ 1535.799805] Modules linked in:
      <br>
      [ 1535.816546] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted
      4.6.0-rc6-sam460ex-jm #4
      <br>
      [ 1535.838341] task: ea850000 ti: ea846000 task.ti: ea846000
      <br>
      [ 1535.857783] NIP: c026d3c8 LR: c0466984 CTR: c001a8ac
      <br>
      [ 1535.876847] REGS: ea847d10 TRAP: 0300   Not tainted
      (4.6.0-rc6-sam460ex-jm)
      <br>
      [ 1535.898224] MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 44422284  XER:
      00000000
      <br>
      [ 1535.918868] DEAR: 01000028 ESR: 00000000
      <br>
      GPR00: c0466984 ea847dc0 ea850000 01000008 0000000f fffffff0
      00000000 00000007
      <br>
      GPR08: 00000001 c0b5a19c 00000000 ea847de0 28428468 205cfe94
      205a946e bfff8a7c
      <br>
      GPR16: 2097d008 2097d018 2097d090 bfff8980 bfff897c 00000000
      00000000 4321fedc
      <br>
      GPR24: 2097d578 c0b3f17c c0b80000 00000000 c0a95e68 eaa35000
      c0b8545c 01000008
      <br>
      [ 1536.024665] NIP [c026d3c8] kobject_get+0x18/0x80
      <br>
      [ 1536.044003] LR [c0466984] get_device+0x1c/0x38
      <br>
      [ 1536.063198] Call Trace:
      <br>
      [ 1536.080424] [ea847dc0] [eaa3fa10] 0xeaa3fa10 (unreliable)
      <br>
      [ 1536.100896] [ea847dd0] [c0466984] get_device+0x1c/0x38
      <br>
      [ 1536.121059] [ea847de0] [c04689f4] device_shutdown+0x58/0x178
      <br>
      [ 1536.141727] [ea847e10] [c003c280] kernel_halt+0x38/0x64
      <br>
      [ 1536.161875] [ea847e20] [c003c4cc] SyS_reboot+0x140/0x1b0
      <br>
      [ 1536.182057] [ea847f40] [c000ad80] ret_from_syscall+0x0/0x3c
      <br>
      [ 1536.202568] --- interrupt: c01 at 0x203d1fbc
      <br>
      [ 1536.202568]     LR = 0x2058f878
      <br>
      [ 1536.239761] Instruction dump:
      <br>
      [ 1536.257358] 4bffff9c 7fa3eb78 484cad91 39610020 7fe3fb78
      4bda3d74 9421fff0 7c0802a6
      <br>
      [ 1536.280308] 93e1000c 7c7f1b79 90010014 41820060
      &lt;813f0020&gt; 2f890000 41bc001c 809f0000
      <br>
      [ 1536.303611] ---[ end trace f5a63492b41c62f2 ]---
      <br>
      [ 1536.323546]
      <br>
      [ 1537.340293] note: systemd-shutdow[1] exited with preempt_count
      1
      <br>
      [ 1537.363602] Kernel panic - not syncing: Attempted to kill init!
      exitcode=0x0000000b
      <br>
      [ 1537.363602]
      <br>
      [ 1537.404665] Rebooting in 180 seconds..
      <br>
      <br>
    </blockquote>
    <p>Adjusted my .config and it is working now .</p>
    <p>Regards</p>
    <p>Julian</p>
    <p><br>
    </p>
    <p>
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
    </p>
    <p>
      <title></title>
      <meta name="generator" content="LibreOffice 4.4.0.3 (Windows)">
      <meta name="created" content="00:00:00">
      <meta name="changed" content="00:00:00">
      <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style>
      <pre class="western">CONFIG_PPC44x_SIMPLE=y

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_SYSFS is not set
#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_BOOKE_WDT is not set
# CONFIG_MEN_A21_WDT is not set
#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

</pre>
    </p>
  </body>
</html>

--------------988382C5E841DC2AA8BFDBDB--
