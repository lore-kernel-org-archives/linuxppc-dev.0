Message-ID: <3F8B7B3B.60302@vinesystech.com>
Date: Mon, 13 Oct 2003 21:27:39 -0700
From: Xiaoshan Zuo <xzuo@vinesystech.com>
MIME-Version: 1.0
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut PCI bridge can't be detected
References: <001d01c39133$20f088a0$2803050a@JackyLam>
In-Reply-To: <001d01c39133$20f088a0$2803050a@JackyLam>
Content-Type: text/plain; charset=Big5
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was puzzled by this for a while. Then I saw this code while debugging
PCI on my custom board:
In ppc405_pci.c, there is ppc4xx_exclude_device function:

static int
ppc4xx_exclude_device(unsigned char bus, unsigned char devfn)
{
/* We prevent us from seeing ourselves to avoid having
* the kernel try to remap our BAR #1 and fuck up bus
* master from external PCI devices
*/
return (bus == 0 && devfn == 0);
}

With this function there, there is no way you are going to see the
bridge, even your driver does the scan itself. I had to write my own
pci_read_config_<size> function to just to be able to read the bridge
configration.

Cheers,

Xiaoshan

Jacky Lam wrote:

>Dear all,
>
>    Concerning my pervious posts about the problem on receiving interrupt
>from PCI cards. I guess it is the problem of PCI bridge..(at least I think
>it is related). Watching the old post in this list, someone post the boot
>log of Walnut board here long time ago. The boot log contians a line to
>detect PCI bridge just after the line"PCI: Probing PCI hardware". However,
>the current devel tree running on Walnut doesn't have this.
>
>    Also, under /proc/bus/pci and /proc/pci, I can't see any information
>about the brdige.
>
>    Moreover, I find that there is a minor different on a bit in my ES1371
>card on Walnut from that on PC. On PC, ES1371 seems will capture an "Slave
>interrupt controller" event just after bootup. But on Walnut, the event will
>become "Slave DMA controller".
>
>    I think these all differents are rooted from some miss configuration
>about PCI in u-boot or kernel early  initialization. I am not familiar with
>PCI. Hope someone here knows what is happening and gives me some idea on how
>to fix that.
>
>    Thanks so much.
>
>Best regards,
>Jacky
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
