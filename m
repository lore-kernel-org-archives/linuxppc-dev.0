Message-ID: <3AA42F91.D3C9402E@ncal.verio.com>
Date: Mon, 05 Mar 2001 16:30:09 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo Aty128fb problem in 2.4.3-pre*?
References: <3AA41B77.73470672@ncal.verio.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've dug through the /var/log/messages, and the system
did continue booting in the video=aty128fb cases. In all cases
I'm seeing the following messages:

2.4.3-pre[12]

  kernel: PCI: Enabling device 00:10.0 (0086 -> 0087)
  kernel: aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR SGRAM (1:1)
  kernel: Console: switching to colour frame buffer device 80x30
  kernel: Registered "ati" backlight controller, level: 10/15
  kernel: fb0: ATY Rage128 frame buffer device on PCI
  kernel: no framebuffer address found for
              /pci@f0000000/ATY,RageM3pParent@10/ATY,RageM3pB


With video=ofonly

  kernel: Using unsupported 1024x768 ATY,RageM3pA at a4008000, depth=8, pitch=1024
  kernel: Console: switching to colour frame buffer device 128x48
  kernel: fb0: Open Firmware frame buffer device
             on /pci@f0000000/ATY,RageM3pParent@10/ATY,RageM3pA
  kernel: no framebuffer address found for
             /pci@f0000000/ATY,RageM3pParent@10/ATY,RageM3pB


2.2.19pre13


  kernel: aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR SGRAM (1:1)
  kernel: Console: switching to colour frame buffer device 128x48
  kernel: Registered "ati" backlight controller, level: 10/15
  kernel: fb0: ATY Rage128 frame buffer device on /pci@f0000000/ATY,RageM3pParent@10

The earlier PCI probe messages in all 2.4.* cases are:

  kernel: PCI: Probing PCI hardware
  kernel: Fixup IO res, dev: 0.10, res_start: 400->802400
  kernel: Can't get bus-range for /pci@f2000000/cardbus@1a
  kernel: PCI->OF bus map:
  kernel: 0 -> 0
  kernel: 1 -> 0
  kernel: 6 -> 0
  kernel: PCI:0:10:0: Resource a4000000-a7ffffff (f=1208)
  kernel: PCI:0:10:0: Resource a0000000-a0003fff (f=200)
  kernel: PCI:1:17:0: Resource 80000000-8007ffff (f=200)
  kernel: PCI:1:1a:0: Resource 80080000-80080fff (f=200)
  kernel: PCI:0:10:0: Resource 00802400-008024ff (f=101)
  kernel: PCI:1:18:0: Resource 80082000-80082fff (f=200)
  kernel: PCI:1:19:0: Resource 80081000-80081fff (f=200)
  kernel: PCI:6:e:0: Resource f5000000-f5000fff (f=200)


Is the current fb driver getting confused by the dual
framebuffers in the OF tree?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
