Return-Path: <per.forlin@stericsson.com>
Received: from eu1sys200aog110.obsmtp.com (eu1sys200aog110.obsmtp.com
	[207.126.144.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D754B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 17:40:02 +1000 (EST)
Message-ID: <4CA438B4.4040106@stericsson.com>
Date: Thu, 30 Sep 2010 09:13:56 +0200
From: Per Friden <per.friden@stericsson.com>
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/4] ste_dma40: implement support for scatterlist to
	scatterlist copy
References: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>	<1285628277-26894-5-git-send-email-iws@ovro.caltech.edu>
	<AANLkTinYG4LqtEXxM5pdA0vavahtqbt6=yV341pnFmZw@mail.gmail.com>
In-Reply-To: <AANLkTinYG4LqtEXxM5pdA0vavahtqbt6=yV341pnFmZw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Per FORLIN <per.forlin@stericsson.com>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/29/2010 11:19 PM, Dan Williams wrote:
> On Mon, Sep 27, 2010 at 3:57 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
>> Now that the DMAEngine API has support for scatterlist to scatterlist
>> copy, implement support for the STE DMA40 DMA controller.
>>
>> Cc: Linus Walleij <linus.ml.walleij@gmail.com>
>> Cc: Per Fridén <per.friden@stericsson.com>
>> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
>> ---
>>  drivers/dma/ste_dma40.c |   17 +++++++++++++++++
>>  1 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
>> index 17e2600..cd48859 100644
>> --- a/drivers/dma/ste_dma40.c
>> +++ b/drivers/dma/ste_dma40.c
>> @@ -1857,6 +1857,18 @@ err:
>>        return NULL;
>>  }
>>
>> +static struct dma_async_tx_descriptor *
>> +d40_prep_sg(struct dma_chan *chan,
>> +           struct scatterlist *dst_sg, unsigned int dst_nents,
>> +           struct scatterlist *src_sg, unsigned int src_nents,
>> +           unsigned long dma_flags)
>> +{
>> +       if (dst_nents != src_nents)
>> +               return -EINVAL;
> 
> I suspect you wanted "return NULL;" here.  I can fix that up.
> 
> Linus, Per ack?
> 
> --
> Dan
Thanks Dan. Acked by Per.

/Per
