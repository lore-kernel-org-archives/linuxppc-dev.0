Date: 7 Aug 2002 10:44:33 -0000
Message-ID: <20020807104433.21385.qmail@webmail5.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: "Michael Habermann" <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: CS_BAD_VCC Error during Card Configaration.
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 06 Aug 2002 Michael Habermann wrote :
>Narendra wrote:
>>occured when i try to write to WLAN card register. In this
>>case
>>Baseaddress returned
>>is 0 and i have done the modifications to add _IO_BASE to the
>>base
>>address. (As mentioned
>>in mail archives).
>
>Have you checked which is really the value used for _IO_BASE? It
>is configured several times in the kernel. The value in
>include/asm/<board>.h has to be correct.
>
>It maybe helps if you post the error and tell us which kernel and
>board you use.
>

Hi,
I have checked the value of _IO_BASE, it is the value defined in
rpxlite.h.

I am using Embedded Planet RPX Lite board(MPC850)and the kernel is
Montavista`s Hard Hat Linux 2.4.2 and pcmcia-cs-3.2.0.

I have one more problem,
Do i need to compile my kernel with Enabling PCMCIA support and
then download to target? or Is it sufficient if all pcmcia driver
modules are loaded to kernel??
My kernel config
file(/opt/hardhat/devkit/lsp/embeddedplanet-rpxlite/linux-2.4.2_hhl20/.config)
shows CONFIG_PCMCIA is not SET.

i am once again trapped here..

Thanks,
Naren

This is the output in /var/log/messages:
(some debug messages are added by me for testing)

Jan  1 00:01:47 10 kernel: unloading PCMCIA Card Services
Jan  1 00:01:48 10 kernel: Linux PCMCIA Card Services 3.2.0
Jan  1 00:01:48 10 kernel:   kernel build: 2.4.2_hhl20 #1 Fri Aug
2 14:08:40 IST 2002
Jan  1 00:01:48 10 kernel:   options:  none
Jan  1 00:01:49 10 kernel: m8xx_pcmcia: Version 0.03, 14-Feb-2000,
Magnus Damm
Jan  1 00:01:49 10 kernel: m8xx_pcmcia: RPX CLASSIC or RPX LITE
using SLOT_B with IRQ 13.
Jan  1 00:02:07 10 kernel: WLAN: Card Service ReqSer 15 : Return
Value 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 21 : Return
Value 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 30 : Return
Value 0
Jan  1 00:02:08 10 kernel: Updating Base Address Success
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 10 : Return
Value 0
Jan  1 00:02:08 10 kernel: Updating Vcc Success
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 15 : Return
Value 0
Jan  1 00:02:08 10 kernel: Retriving Tuple from CF Table.
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 21 : Return
Value 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 30 : Return
Value 0
Jan  1 00:02:08 10 kernel: CF Table With Default Settings
Jan  1 00:02:08 10 kernel:  Configured Vcc = 50 and 33
Jan  1 00:02:08 10 kernel:  Vcc NOT equal
Jan  1 00:02:08 10 kernel: Enter IO window configuration
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 45 : Return
Value 30
Jan  1 00:02:08 10 kernel: RequestIO: Resource in use (Why
RequestIO is failing?)

Jan  1 00:02:08 10 kernel: Configuration from CF Table SUCCESS
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 46 : Return
Value 0
Jan  1 00:02:08 10 kernel: ISR Installed. Success
Jan  1 00:02:08 10 kernel: IOBASE = 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 43 : Return
Value 0
Jan  1 00:02:08 10 kernel: Enabling Configuration Success
Jan  1 00:02:08 10 kernel: Net Device Regsiter Success:dev
namewlan0
Jan  1 00:02:08 10 kernel: _IO_BASE = 0x80000000
Jan  1 00:02:08 10 kernel: Machine check in kernel mode.
Jan  1 00:02:08 10 kernel: Caused by (from SRR1=1032): Unknown
values in msr
Jan  1 00:02:08 10 kernel: Oops: machine check, sig: 7
Jan  1 00:02:08 10 kernel: NIP: C5646E08 XER: 20000042 LR:
C5646E04 SP: C392F800 REGS: c392f750 TRAP: 0200
Jan  1 00:02:08 10 kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1
IR/DR: 11
Jan  1 00:02:08 10 kernel: TASK = c392e000[162] 'cardmgr' Last
syscall: 54
Jan  1 00:02:08 10 kernel: last math 00000000 last altivec
00000000
Jan  1 00:02:08 10 kernel: GPR00: 00001000 C392F800 C392E000
00000047 00001032 00000001 00000001 C02E7060
Jan  1 00:02:08 10 kernel: GPR08: C0144B2A C0130000 00000047
C392F740 24024028 1002205C 00000000 100B7950
Jan  1 00:02:08 10 kernel: GPR16: 100B6F10 00000000 00000000
00000000 00009032 0392FE80 00000000 C0002818
Jan  1 00:02:08 10 kernel: GPR24: 00000034 C392F80A 80000034
C5650000 C5650000 00000002 C392F808 AAAAAAAB
Jan  1 00:02:08 10 kernel: Call backtrace:
Jan  1 00:02:08 10 kernel: C5646E04 C5646EDC C56479DC C5646B9C
C5646204 C5644434 C5641CEC
Jan  1 00:02:08 10 kernel: C56420F8 C560355C C5604E14 C564241C
C5640EA4 C5610918 C56117FC
Jan  1 00:02:08 10 kernel: C0045640 C000259C 10002BAC 100032C0
10004764 0FED9DBC 00000000


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
