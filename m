Message-ID: <3CF1CEC4.1020205@mvista.com>
Date: Sun, 26 May 2002 23:14:28 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> Armin, please consider the patch below.  It removes your recently
> added ocp-dma.h and instead makes the ocp enet driver uses the DMA
> direction constants from pci.h.

Go ahead and push it.  FYI - I will update the ocp ide driver since I am
making changes in it any ways.

>
> I realise that logically the OCP enet driver, and the
> consistent_sync() has nothing to do with PCI.  However using the pci.h
> constants seems a better approach than defining new constants with the
> same values, when the switch in consistent_sync() explicitly checks
> against the PCI constants.
>
> In the longer term consistent_sync() itself should be changed not to
> reference the PCI constants - in fact the PCI constants should
> probably be moved and renamed since they have no inherent connection
> with PCI at all.

I have already had to make that break with the ocp usb driver.  If a 4xx
core shows up with PCI and ocp ide or ocp USB then we will need to
address this issue.  thus those dma APIs I sent you are a result of my
concern.
>
> Oh, I also change the consistent_sync() in the Tx routine to be
> PCI_DMA_TODEVICE rather than BIDIRECTIONAL, since there is no need to
> invalidate the cache here, a writeback is all that's necessary.
>
>


Thanks

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
