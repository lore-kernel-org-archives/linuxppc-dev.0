Return-Path: <jgpobox@gmail.com>
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4F883640.60103@pobox.com>
Date: Fri, 13 Apr 2012 10:20:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Thang Nguyen <tqnguyen@apm.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F7AE584.3050805@mvista.com> <4F873573.10406@pobox.com>
 <3445364d6d28c2b6ae19817fe6851452@mail.gmail.com>
In-Reply-To: <3445364d6d28c2b6ae19817fe6851452@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Phong Vo <pvo@apm.com>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2012 03:18 AM, Thang Nguyen wrote:
> Thanks Jeff and Sergei,
>
> As your suggestion, I will separate the patch into smaller patches and
> support more features on the SATA DWC driver. The patches I intend to do
> on the SATA DWC are as below:
>   - Support hardreset: currently the hardreset is not supported. This
> causes sometime the SATA driver does cause kernel crash because of
> not-determined state.
>   - Let device tree specified DMA channel: currently only channel 0 is
> supported (number of channel is set to 1). If device tree not specified
> DMA channel, channel 0 will be used as default.
>   - Support ATAPI.
>   - Remove dma_interrupt_count. for each DMA transfer, we need 2 interrupts
> for QC completion: transfer completion and DMA transfer completion
> interrupt. The current code wait for both 2 interrupts occur before
> calling qc_complete. This will make out-of-sync state when an interrupt
> lost or when errors occur. The change will process DMA register when DMA
> transfer complete interrupt occur and call qc_issue when command
> completion interrupt occur.
>   - Fix NCQ issue and set .can_queue back to ATA_MAX_QUEUE.
>   - Support Port Multiplier.
>   - Support 2 SATA ports on Maui.

Sounds good, thanks for splitting up the patch into smaller pieces.  The 
main goal is that separate logical changes should go into separate patches.

	Jeff
