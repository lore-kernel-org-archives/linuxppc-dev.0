Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 905C4B722F
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 09:09:24 +1100 (EST)
Message-ID: <4EC5860D.5000606@freescale.com>
Date: Thu, 17 Nov 2011 16:09:17 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111118082929.5ee8d4f07d84f2bf65e18006@canb.auug.org.au>
In-Reply-To: <20111118082929.5ee8d4f07d84f2bf65e18006@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:

>>  static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
>>  {
>> -	struct device_node *np;
>> -	void __iomem *pixis;
>> -	u8 __iomem *brdcfg1;
>> +	struct device_node *guts_node = NULL;
> 
> There is no point in initialising this as it is assigned before being
> used.

Ok.

>> +	struct device_node *indirect_node = NULL;
>> +	struct ccsr_guts_85xx __iomem *guts = NULL;
>> +	u8 __iomem *lbc_lcs0_ba = NULL;
>> +	u8 __iomem *lbc_lcs1_ba = NULL;
> 
> And if you had multiple error path labels, you could avoid these others
> as well (and the NULL checks on the error path).

But I don't want multiple error path labels.  The error path could only happen if someone passed in a broken device tree (i.e. pretty much never), so I'm not keen on complicating my code just to optimize something that will never be used.

-- 
Timur Tabi
Linux kernel developer at Freescale
