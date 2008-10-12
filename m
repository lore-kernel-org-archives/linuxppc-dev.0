Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EB80DDDEA
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 13:19:47 +1100 (EST)
Message-ID: <48F15EBD.4040807@linux.net.cn>
Date: Sun, 12 Oct 2008 10:19:41 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
References: <20081011180014.GA4908@debian> <1223763687.8157.178.camel@pasglop>
In-Reply-To: <1223763687.8157.178.camel@pasglop>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@ozlabs.org, Tejun Heo <htejun@gmail.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt Ð´µÀ:
> On Sun, 2008-10-12 at 02:00 +0800, Wang Jian wrote:
>> To avoid adding another rare used ata_port member, new bit is added to
>> ata_port->flags.
>>
>> Originally, I hacked pata_platform to make it 8bit only to support 8bit
>> data wired CF card. This patch is more generic.
>>
>> With this patch, __pata_platform_probe() interface is changed, and
>> pata_of_platform is broken, so a small patch is needed.
>>
>> Signed-off-by: Wang Jian <lark@linux.net.cn>
>> ---
> 
> A couple of things. First I would personally prefer (but I'm not the
> libata maintainer so it's up to Jeff ...) if you had a separate patch
> that adds the 8-bit support to libata core first, and then a patch that
> modifies pata_platform.

I will do that if my 8-bit mode patch is done right technically.

> 
> Then, in order to avoid breaking bisection, I would like you to fixup
> pata_of_platform in the same patch that modifies __pata_platform_probe
> so there is no breakage in between patches.

Yes.

> 
> Now, regarding the patch itself, if the core grows a 8-bit flag, then
> I strongly suspect the core should also grow the 8-bit xfer function
> rather than having it hidden in pata_platform.

This is the main reason I send a single RFC patch. Where to add 8-bit
mode should be decided first.

Because 8-bit mode is mostly used for embedded devices, my opinion is
8-bit mode in pata_platform is enough.

However, look at pata_platform_data_xfer() I added, the code can be
merged into ata_sff_data_xfer() of libata-sff.c easily. Moving the
code there is trivial if necessary.

Another problem should be addressed: using flags v.s. using data_width
member. I add a bit to indicate 8 bit mode, but this seems to be a problem
for future 32 bit I/O support in libata.
