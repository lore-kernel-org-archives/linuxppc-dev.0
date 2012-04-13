Return-Path: <tqnguyen@apm.com>
Received: from exprod5og116.obsmtp.com (exprod5og116.obsmtp.com [64.18.0.147])
 by ozlabs.org (Postfix) with SMTP id 998F4B7013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 17:18:33 +1000 (EST)
Received: by pbcuo1 with SMTP id uo1so3985068pbc.40
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 00:18:30 -0700 (PDT)
From: Thang Nguyen <tqnguyen@apm.com>
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F7AE584.3050805@mvista.com> <4F873573.10406@pobox.com>
In-Reply-To: <4F873573.10406@pobox.com>
MIME-Version: 1.0
Date: Fri, 13 Apr 2012 14:18:29 +0700
Message-ID: <3445364d6d28c2b6ae19817fe6851452@mail.gmail.com>
Subject: RE: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
To: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phong Vo <pvo@apm.com>, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Jeff and Sergei,

As your suggestion, I will separate the patch into smaller patches and
support more features on the SATA DWC driver. The patches I intend to do
on the SATA DWC are as below:
 - Support hardreset: currently the hardreset is not supported. This
causes sometime the SATA driver does cause kernel crash because of
not-determined state.
 - Let device tree specified DMA channel: currently only channel 0 is
supported (number of channel is set to 1). If device tree not specified
DMA channel, channel 0 will be used as default.
 - Support ATAPI.
 - Remove dma_interrupt_count. for each DMA transfer, we need 2 interrupts
for QC completion: transfer completion and DMA transfer completion
interrupt. The current code wait for both 2 interrupts occur before
calling qc_complete. This will make out-of-sync state when an interrupt
lost or when errors occur. The change will process DMA register when DMA
transfer complete interrupt occur and call qc_issue when command
completion interrupt occur.
 - Fix NCQ issue and set .can_queue back to ATA_MAX_QUEUE.
 - Support Port Multiplier.
 - Support 2 SATA ports on Maui.

Regards,
Thang Nguyen-

-----Original Message-----
From: Jeff Garzik [mailto:jgpobox@gmail.com] On Behalf Of Jeff Garzik
Sent: Friday, April 13, 2012 3:05 AM
To: Sergei Shtylyov
Cc: Thang Q. Nguyen; Benjamin Herrenschmidt; Paul Mackerras; Grant Likely;
Rob Herring; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
linux-ide@vger.kernel.org; devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change
filename from sata_dwc_460ex.c to sata_dwc_4xx.c

On 04/03/2012 07:56 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 03-04-2012 14:12, Thang Q. Nguyen wrote:
>
>> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
>> ---
>> Changes for v2:
>> - Use git rename feature to change the driver to the newname and for
>> easier review.
>
>> arch/powerpc/boot/dts/bluestone.dts | 21 +
>> drivers/ata/Makefile | 2 +-
>> drivers/ata/{sata_dwc_460ex.c => sata_dwc_4xx.c} | 1371
>> ++++++++++++++--------
>> 3 files changed, 904 insertions(+), 490 deletions(-)
>> rename drivers/ata/{sata_dwc_460ex.c => sata_dwc_4xx.c} (56%)
>
> You submitted a magapatch doing several things at once (some even
> needlessly) and even in two areas of the kernel. This needs proper
> splitting/description.

Agreed...
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information 
that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
