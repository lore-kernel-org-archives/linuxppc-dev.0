Message-ID: <3E73759D.4070904@embeddededge.com>
Date: Sat, 15 Mar 2003 13:49:01 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "en_ch@libero.it" <en_ch@libero.it>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re:  interrupt handler registering in mpc850sar  : i need help !
References: <HBSPPX$08BE7D73572C17E3728C4EA4A367D3E2@libero.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


en_ch@libero.it wrote:

> i have to realize a char driver to set ATM Utopia for a linux
> embedded system using motorola mpc850sar.

What devices interrupt the CPM and which ones interrupt the SIU?
I don't recall any ATM interrupts that use the SIU, I thought they
all were CPM interrupts through the device that holds the BDs,
like SCC4 for example.

> i need help with registering the interrupt handler function: i tried
> to use request_8xxirq() for the SIU and cpm_install_handler() for CPM
> but interrupt handler seems not run when i trasmit and receive.

That's correct.  Ensure the interrupt vector numbers you prgrammed into
the devices match the ones you are passing to the handler installer,
then ensure you have the transmit/receive interrupts enabled on the
device.  Of course, there is lots more setup of the device, especially
for ATM, than simply enabling interrupts.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
