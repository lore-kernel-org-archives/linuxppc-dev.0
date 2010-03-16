Return-Path: <albert_herranz@yahoo.es>
Received: from smtp124.mail.ukl.yahoo.com (smtp124.mail.ukl.yahoo.com
	[77.238.184.55]) by ozlabs.org (Postfix) with SMTP id 33B5EB7DAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Mar 2010 17:09:46 +1100 (EST)
Message-ID: <4B9F20A7.4040708@yahoo.es>
Date: Tue, 16 Mar 2010 07:09:43 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v4 04/11] swiotlb: support NOT_COHERENT_CACHE PowerPC
	platforms
References: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>	<1268421166-4791-5-git-send-email-albert_herranz@yahoo.es>
	<20100316105423B.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100316105423B.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: x86@kernel.org, linux-ia64@vger.kernel.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FUJITA Tomonori wrote:
> On Fri, 12 Mar 2010 20:12:39 +0100
> Albert Herranz <albert_herranz@yahoo.es> wrote:
> 
>> The current SWIOTLB code does not support NOT_COHERENT_CACHE platforms.
>> This patch adds support for NOT_COHERENT_CACHE platforms to SWIOTLB by
>> adding two platform specific functions swiotlb_dma_sync_page() and
>> swiotlb_dma_sync() which can be used to explicitly manage cache coherency.
>>
>> On PowerPC these functions are mapped to their corresponding
>> __dma_sync_page() and __dma_sync() functions.
>> On other architectures using SWIOTLB these functions are optimized out.
>>
>> This will be used later to support SWIOTLB on the Nintendo Wii video game
>> console.
>>
>> CC: linuxppc-dev@lists.ozlabs.org
>> CC: linux-kernel@vger.kernel.org
>> CC: x86@kernel.org
>> CC: linux-ia64@vger.kernel.org
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>> ---
>>  arch/ia64/include/asm/swiotlb.h    |   10 ++++++++++
>>  arch/powerpc/include/asm/swiotlb.h |    3 +++
>>  arch/x86/include/asm/swiotlb.h     |   10 ++++++++++
>>  lib/swiotlb.c                      |   30 ++++++++++++++++++++++++------
>>  4 files changed, 47 insertions(+), 6 deletions(-)
> 
> Why can't you use dma_sync_single_* instead of inventing new
> swiotlb sync functions?
> 

At least on PowerPC, the DMA ops are per-device hooks. We attach the swiotlb DMA ops functions to those hooks when we are using swiotlb.
So calling dma_sync_single_*() would end up calling swiotlb_sync_single_*() which is not what we want.

Thanks,
Albert
