Return-Path: <albert_herranz@yahoo.es>
Received: from smtp137.mail.ukl.yahoo.com (smtp137.mail.ukl.yahoo.com
	[77.238.184.68]) by ozlabs.org (Postfix) with SMTP id C2987B7D9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Mar 2010 16:58:47 +1100 (EST)
Message-ID: <4B9F1E11.80201@yahoo.es>
Date: Tue, 16 Mar 2010 06:58:41 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 05/11] swiotlb: add swiotlb_set_default_size()
References: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>	<1268421166-4791-6-git-send-email-albert_herranz@yahoo.es>
	<20100316104440Y.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100316104440Y.fujita.tomonori@lab.ntt.co.jp>
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
> On Fri, 12 Mar 2010 20:12:40 +0100
> Albert Herranz <albert_herranz@yahoo.es> wrote:
> 
>> The current SWIOTLB code uses a default of 64MB for the IO TLB area.
>> This size can be influenced using a kernel command line parameter "swiotlb".
>> Unfortunately, the parsing of the kernel command line is done _after_ the
>> swiotlb is initialized on some architectures.
>>
>> This patch adds a new function swiotlb_set_default_size() which can be used
>> before swiotlb_init() to indicate the desired IO TLB area size in bytes.
>>
>> This will be used later to implement a smaller IO TLB on the Nintendo Wii
>> video game console which just comes with 24MB + 64MB of RAM.
>>
>> CC: linuxppc-dev@lists.ozlabs.org
>> CC: linux-kernel@vger.kernel.org
>> CC: x86@kernel.org
>> CC: linux-ia64@vger.kernel.org
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>> ---
>>  include/linux/swiotlb.h |    2 ++
>>  lib/swiotlb.c           |   20 ++++++++++++++++++++
>>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> Please fix the powerpc swiotlb initialization instead.
> 
> Calling swiotlb_init() before parsing kernel parameters sounds
> wrong. Any reasons why you can't fix it?
> 

I think that this would be better asked by a PowerPC maintainer. Ben?

If this is really a problem the swiotlb late init may be a solution too in this particular case.

Thanks,
Albert
