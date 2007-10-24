Return-Path: <vbarshak@ru.mvista.com>
Message-ID: <471F2A32.8030202@ru.mvista.com>
Date: Wed, 24 Oct 2007 15:19:14 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
References: <20071008142658.GA15197@ru.mvista.com>
	<e1b19c12c7006e763a56627fa9a05ec9@kernel.crashing.org>
	<20071023214000.424.qmail@farnsworth.org>
In-Reply-To: <20071023214000.424.qmail@farnsworth.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:
> Valentine wrote:
>> Actually I also don't see much reason for the 
>> USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE stuff.
>> Is this really needed?
> 
> I think so.  The SOC host controllers are BE and the PCI
> host controllers are LE.  Or, do you have an alternative
> method of handling both types?
> 
> -Dale

Yes, PCI controllers are LE, but do we really need user-selectable 
USB_OHCI_HCD_PPC_OF_LE option, since USB_OHCI_LITTLE_ENDIAN is selected
by default for USB_OHCI_HCD_PCI?
The USB_OHCI_HCD_PPC_OF_LE/BE stuff is related to PPC OF glue only.
I think it's useless. We should always enable
USB_OHCI_BIG_ENDIAN_DESC and USB_OHCI_BIG_ENDIAN_MMIO for PPC OF
and the real LE/BE implementation should be selected by the 
corresponding properties in the device tree.
Thanks,
Valentine.
