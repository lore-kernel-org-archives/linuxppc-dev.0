Message-ID: <3EE9F34F.5060200@imc-berlin.de>
Date: Fri, 13 Jun 2003 17:52:47 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Magnus Damm <damm@opensource.se>, mlocke@mvista.com,
	Wolfgang Denk <wd@denx.de>,
	PCMCIA <pcmcia-cs-devel@lists.sourceforge.net>
Subject: Question about MPC8xx PCMCIA
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I do have some problems with PCMCIA cards on my MPC855T based board.
In fact there are two:

1. I do get some "cs: socket 0 timed out during reset". But they
become rare now. (So this shouldn't be the issue right now.)
2. Some cards (96MB Flash Card from SimpleTech and SiliconTech" are
"sometimes" not recognized correctly. I get

cardmgr[367]: socket 0: Anonymous Memory
cardmgr[367]: executing: 'modprobe memory_cs'

instead of

cardmgr[62]: socket 0: ATA/IDE Fixed Disk
cardmgr[62]:   product info: "STI", "Flash 5.0"
cardmgr[62]:   manfid: 0x0007, 0x0000  function: 4 (fixed disk)

The reason for that is that the CIS is not read correctly.
I do expierence the same problems with an TQM860L (STK), linux-2.4.20
(from DENX) and pcmcia-cs-3.2.4 (with m8xx patches from DENX ELDK).

I know this "sometimes" does not help much. But I am here to ask some
general questions:

1. Why do we power up the card as early as in hardware_enable()?
    IMHO this is the task of cardmgr!

2. In hardware_enable() we're wait quiet a while for the card to come
    up. But a) cs.c is responsible for a vcc_settle delay and b) later
    insertions are _not_ effected by this anyway. So it's only for one
    time while system startup... !?
    Should we do that everytime voltage_set() gets called? But then
    again cs.c is responsible for vcc_settle...

3. Most implementaions of voltage_set() in m8xx_pcmcia.c first switch
    the power off and then switch it back on. Fair enough. BUT every-
    time m8xx_set_socket() gets called, the power is switched off and
    on again. Even if the vcc state didn't changed! So it's switched
    off and on without good reason _and_ without time to settle! I
    can't imagine that this is feature...
    So I think voltage_set() should only switch powers if something
    changed.

4. Someone wrote in m8xx_set_socket() :
         /* The CxOE signal is connected to a 74541 on the ADS.
            I guess most other boards used the ADS as a reference.
            I tried to control the CxOE signal with SS_OUTPUT_ENA,
            but the reset signal seems connected via the 541.
            If the CxOE is left high are some signals tristated and
            no pullups are present -> the cards act wierd.
            So right now the buffers are enabled if the power is on. */

    Well. "The PCMCIA Developer's Guide" states on page 55
	"After the socket controller enables power to the socket,
	there is at least a 300mS delay until output signals are
	enabled ... All socket controller output signals, including
	RESET, are in a tristate mode until the end of the 300mS
	delay."
   So if I change

         if(state->Vcc || state->Vpp)
                 M8XX_PGCRX(_slot_) &= ~M8XX_PGCRX_CXOE;
   to
         if(state->flags & SS_OUTPUT_ENA)
                 M8XX_PGCRX(_slot_) &= ~M8XX_PGCRX_CXOE; /* active low
   (as it would be correct) then the above mentioned FLASH CARDS indeed
   act wiered... .-(

I hope that someone out there finds time and wants to share his
thoughts with me.

Thanks a million and have a nice weekend!

Cheers,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
