Date: Tue, 13 Apr 2004 10:45:43 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: Xilinx ML300 u-boot question
In-reply-to: <407C0738.2030904@lucent.com>
To: Mike Wellington <wellington@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <407C2747.1030709@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <407C0738.2030904@lucent.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike,

for TFTP boot normally the HW MAC address of the target device is used
for identification. On the ML300 the HW MAC address is stored inside the
IIC EEPROM. Since accessing this EEPROM is not yet supported in the
pusblished U-Boot port for ML300 the MAC address is hardcoded in
board/xilinx/xilinx_enet/emac_adapter.c.

So, to get a machine specific u-boot for every board change the MAC
address and recompile. I'm not sure that you would need the secondary
u-boot then as you could then directly load the Linux kernel in the
second step.

- Peter


Mike Wellington wrote:

>
> Does anybody know what parameters I should use to
> load u-boot, using u-boot.    That's right, I want to
> build a generic u-boot that goes on the Microdrive of
> a Xilinx ML300 development board.  I have several of them
> to manage.  I want the generic u-boot to go and download
> a machine-specific u-boot that I can change on my workstation
> without having to write it to the microdrive.
>
> Or can I just have u-boot start the kernel with no parameters
> and have all the initial args for the kernel built into the
> kernel?
>
> -mike wellington
>  wellington@lucent.com
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
