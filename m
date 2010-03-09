Return-Path: <albert_herranz@yahoo.es>
Received: from smtp149.mail.ukl.yahoo.com (smtp149.mail.ukl.yahoo.com
	[77.238.184.80]) by ozlabs.org (Postfix) with SMTP id B1996B7D0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Mar 2010 05:38:06 +1100 (EST)
Message-ID: <4B96958B.3010403@yahoo.es>
Date: Tue, 09 Mar 2010 19:38:03 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [LKML] [RFC PATCH v3 05/11] swiotlb:
	add	swiotlb_set_default_size()
References: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
	<1267963912-984-6-git-send-email-albert_herranz@yahoo.es>
	<20100308165940.GC4568@phenom.dumpdata.com>
In-Reply-To: <20100308165940.GC4568@phenom.dumpdata.com>
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

Konrad Rzeszutek Wilk wrote:
> On Sun, Mar 07, 2010 at 01:11:46PM +0100, Albert Herranz wrote:
>> The current SWIOTLB code uses a default of 64MB for the IO TLB area.
>> This size can be influenced using a kernel command line parameter "swiotlb".
>> Unfortunately, the parsing of the kernel command line is done _after_ the
>> swiotlb is initialized on some architectures.
> 
> Why can't it be moved up? I mean move the parsing of the kernel
> parameters before the PCI subsystem?

(In my case there's no PCI subsystem, this is an embedded platform without PCI support).

Currently, in the PowerPC tree a platform wanting to use the swiotlb just sets the global ppc_swiotlb_enable variable to true in its setup_arch() function.
The PowerPC setup code then calls swiotlb_init(1) just after setup_arch() when SWIOTLB and ppc_swiotlb_enable is true.
At this point the kernel command line is not yet parsed.

So, at least in PowerPC linux, the early swiotlb initialization is not influenced by the kernel command line.

Maybe switching swiotlb from __setup to early_param would help too.

>> This patch adds a new function swiotlb_set_default_size() which can be used
>> before swiotlb_init() to indicate the desired IO TLB area size in bytes.
>>
>> This will be used later to implement a smaller IO TLB on the Nintendo Wii
>> video game console which just comes with 24MB + 64MB of RAM.
> 
> Use the io_tlb_nslabs, which is what swiotlb_init_with_default_size uses
> (the passed in argument is only used if io_tlb_nslabs is not set).
> 

True, thanks.

Cheers,
Albert
