In-Reply-To: <20000201225122.B7845@suse.de>
Date: Tue, 1 Feb 2000 23:55:57 +0100
To: linuxppc-dev@lists.linuxppc.org, olh@suse.de
From: BenH <bh40@calva.net>
Subject: Re: find the OF boot-device
Message-Id: <20000201235557.015906@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 1, 2000, Olaf Hering <olh@suse.de> wrote:

>The kernel is a 2.2.14.
>Is there a bug in the OF or in the kernel?

It's a "feature" of MacOS when using BootX. MacOS discards the
"@xxxxxxxx" portion of the OF path, so the device tree built by BootX is
missing those. They can be rebuilt using the OF "reg" property, I have to
figure out the proper algorithm but this could (should) be done in the
kernel or in BootX itself before passing the tree to the kernel.

How do you plan to match the device to the OF node ? I've looked into
this issue for some time now, but I don't really see a valid way to know
that a given Linux device (/dev/xxx) corresponds to a given OF node.
Especially when using PCI SCSI cards. Is there a way from userland to
retreive PCI infos of a controller from it's /dev/sdXX node ?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
