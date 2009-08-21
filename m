Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 225A2B7BC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 15:40:54 +1000 (EST)
Message-ID: <4A8E3396.9030006@windriver.com>
Date: Fri, 21 Aug 2009 13:41:42 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/405ex: support cuImage via included dtb
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<1250562484-16415-3-git-send-email-tiejun.chen@windriver.com>
	<20090820133118.GF2530@zod.rchland.ibm.com>
In-Reply-To: <20090820133118.GF2530@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, Aug 18, 2009 at 10:28:04AM +0800, Tiejun Chen wrote:
>> To support cuImage, we need to initialize the required sections and 
>> ensure that it is built.
>>
>> -		cuboot-acadia.c cuboot-amigaone.c
>> +		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c
>> src-boot := $(src-wlib) $(src-plat) empty.c
>>
>> src-boot := $(addprefix $(obj)/, $(src-boot))
>> @@ -192,6 +192,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
>> image-$(CONFIG_EP405)			+= dtbImage.ep405
>> image-$(CONFIG_WALNUT)			+= treeImage.walnut
>> image-$(CONFIG_ACADIA)			+= cuImage.acadia
>> +image-$(CONFIG_KILAUEA)		+= cuImage.kilauea
> 
> I'm not thrilled with this part as cuImage is really the secondary
> solution if the U-Boot that comes with a board if FDT aware.  If you
> have a different board that needs this, perhaps you could add the
> target when that board support gets upstream?
> 

Agreed and I will remove this line as you expect. Right?

>> +static void kilauea_fixups(void)
>> +{
>> +	/*TODO: Please change this as the real. Note that should be 33MHZ~100MHZ.*/
> 
> What does that mean?
> 

It's difficult to check the sysclk value on all revision Kilauea board for me,
and we have to check this value only by the real target, not by reading one
register. So I hope it's safe to remind other guys here.

But I am sure that should be 33MHZ ~ 100MHZ as PPC405EX manual.

Best Regards
Tiejun

> josh
> 
