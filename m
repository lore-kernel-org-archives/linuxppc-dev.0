Message-Id: <5.1.0.14.2.20031013223052.00b112d8@mail.ebshome.net>
Date: Mon, 13 Oct 2003 22:41:20 -0700
To: Xiaoshan Zuo <xzuo@vinesystech.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Walnut PCI bridge can't be detected
Cc: Jacky Lam <jackylam@astri.org>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3F8B7B3B.60302@vinesystech.com>
References: <001d01c39133$20f088a0$2803050a@JackyLam>
 <001d01c39133$20f088a0$2803050a@JackyLam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:27 PM 10/13/2003, Xiaoshan Zuo wrote:

>I was puzzled by this for a while. Then I saw this code while debugging
>PCI on my custom board:
>In ppc405_pci.c, there is ppc4xx_exclude_device function:
>
>static int
>ppc4xx_exclude_device(unsigned char bus, unsigned char devfn)
>{
>/* We prevent us from seeing ourselves to avoid having
>* the kernel try to remap our BAR #1 and fuck up bus
>* master from external PCI devices
>*/
>return (bus == 0 && devfn == 0);
>}

I think comment is quite clear, don't you think ?

>With this function there, there is no way you are going to see the
>bridge, even your driver does the scan itself. I had to write my own
>pci_read_config_<size> function to just to be able to read the bridge
>configration.

Well, all you had to do was to clear ppc_md.pci_exclude_device.

Frankly, I don't understand why do you want to mess with the bridge setup
from _device driver_ ?

The right place for bridge specific setup is bios_fixup. walnut.c has a
good example.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
