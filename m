Return-Path: <gary@mlbassoc.com>
Message-ID: <49391C93.1070303@mlbassoc.com>
Date: Fri, 05 Dec 2008 05:20:35 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: s104259@yahoo.it
Subject: Re: Installation on a MPC5200 based custom board
References: <688884.68610.qm@web23105.mail.ird.yahoo.com>
In-Reply-To: <688884.68610.qm@web23105.mail.ird.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Angelo wrote:
> Hi all.
> 
> I saw that someones trying to work on a custom board based on mpc5200.
> I have:
> * u-boot 1.2.0
> * kernel 2.6.21
> * arch=powerpc
> * custom dts based on lite5200b.dts
> * USB port (USB2) configured on the Ethernet port
> 
> Is it necessary to combine Ethernet and usb nodes?
> However this is the log when a usb-storage is plugged:
> 
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
> ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] = 0x00010101
> CSC PPS CCS
> hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
> hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
> ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] = 0x00100103
> PRSC PPS PES CCS
> usb 1-2: new full speed USB device using ppc-of-ohci and address 2
> BUG: soft lockup detected on CPU#0!
> Call Trace:
> [C7E05A50] [C0007FD8] show_stack+0x3c/0x194 (unreliable)
> [C7E05A80] [C004A380] softlockup_tick+0xa4/0xd4
> [C7E05AA0] [C002B998] run_local_timers+0x18/0x28
> [C7E05AB0] [C002B9D8] update_process_times+0x30/0x7c
> [C7E05AC0] [C003FF3C] tick_sched_timer+0xb0/0x280
> [C7E05B20] [C003C538] hrtimer_interrupt+0x214/0x26c
> [C7E05B80] [C000E744] timer_interrupt+0x88/0x354
> [C7E05BF0] [C0011C04] ret_from_except+0x0/0x14
> --- Exception: 901 at handle_IRQ_event+0x7c/0x1e8
>     LR = handle_level_irq+0x90/0x13c
> [C7E05CB0] [C7F15C00] 0xc7f15c00 (unreliable)
> [C7E05CD0] [C004C2E0] handle_level_irq+0x90/0x13c
> [C7E05CE0] [C0006304] do_IRQ+0x98/0xbc
> [C7E05CF0] [C0011C04] ret_from_except+0x0/0x14
> --- Exception: 501 at schedule+0x38/0x64c
>     LR = schedule_timeout+0x68/0xe4
> [C7E05DB0] [C01A1650] usb_hcd_submit_urb+0x190/0x8a0 (unreliable)
> [C7E05E00] [C02389A4] schedule_timeout+0x68/0xe4
> [C7E05E40] [C0238378] wait_for_completion_timeout+0x8c/0x138
> [C7E05E80] [C01A2B60] usb_start_wait_urb+0x64/0x124
> [C7E05EB0] [C01A2E1C] usb_control_msg+0xc4/0xf0
> [C7E05EF0] [C019D0D0] hub_port_init+0x424/0x614
> [C7E05F40] [C019F42C] hub_thread+0x434/0xe64
> [C7E05FC0] [C0037E60] kthread+0xc0/0xfc
> [C7E05FF0] [C00123F8] original_kernel_thread+0x44/0x60
> ppc-of-ohci f0001000.usb: OHCI Unrecoverable Error, disabled
> ppc-of-ohci f0001000.usb: OHCI controller state
> ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers
> ppc-of-ohci f0001000.usb: control 0x093 HCFS=operational CLE CBSR=3
> ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=0
> ppc-of-ohci f0001000.usb: intrstatus 0x00000074 RHSC FNO UE SF
> ppc-of-ohci f0001000.usb: intrenable 0x8000001a MIE UE RD WDH
> ppc-of-ohci f0001000.usb: ed_controlhead 07fcc000
> ppc-of-ohci f0001000.usb: ed_controlcurrent fffffff0
> ppc-of-ohci f0001000.usb: hcca frame #ddb6
> ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=2 NOCP NPS NDP=2(2)
> ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=0000 DR=0000
> ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE
> ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS
> ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00030100 PESC CSC PPS
> ppc-of-ohci f0001000.usb: HC died; cleaning up
> irq 134: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [C046FDF0] [C0007FD8] show_stack+0x3c/0x194 (unreliable)
> [C046FE20] [C004B358] __report_bad_irq+0x34/0xac
> [C046FE40] [C004B4AC] note_interrupt+0xdc/0x288
> [C046FE70] [C004C344] handle_level_irq+0xf4/0x13c
> [C046FE80] [C0006304] do_IRQ+0x98/0xbc
> [C046FE90] [C0011C04] ret_from_except+0x0/0x14
> --- Exception: 501 at schedule+0x304/0x64c
>     LR = schedule+0x2d8/0x64c
> [C046FFA0] [C004A2B4] watchdog+0x4c/0x74
> [C046FFC0] [C0037E60] kthread+0xc0/0xfc
> [C046FFF0] [C00123F8] original_kernel_thread+0x44/0x60
> handlers:
> [<c01a1008>] (usb_hcd_irq+0x0/0x9c)
> Disabling IRQ #134
> usb 1-2: khubd timed out on ep0in len=0/64
> hub 1-0:1.0: cannot reset port 2 (err = -19)
> hub 1-0:1.0: cannot disable port 2 (err = -19)
> ppc-of-ohci f0001000.usb: leak ed c7fcc000 (#00) state 0 (has tds)
> hub 1-0:1.0: cannot reset port 2 (err = -19)
> hub 1-0:1.0: cannot disable port 2 (err = -19)
> hub 1-0:1.0: cannot reset port 2 (err = -19)
> hub 1-0:1.0: cannot disable port 2 (err = -19)
> hub 1-0:1.0: cannot reset port 2 (err = -19)
> hub 1-0:1.0: cannot disable port 2 (err = -19)
> hub 1-0:1.0: cannot disable port 2 (err = -19)
> hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004
> 
> Please mail me any idea...

Update to the latest kernel (2.6.27+) - there has been lots
of work on the MPC5200 in the past three years (that's how
old 2.6.21 is!)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
