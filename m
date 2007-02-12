Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 854DEDDDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 03:42:29 +1100 (EST)
Message-ID: <45D098E5.3090109@freescale.com>
Date: Mon, 12 Feb 2007 10:42:13 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add initrd information to the device
	tree in ft_finalize().
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230140.GO3849@ld0162-tx32.am.freescale.net>
	<20070209230207.GA12035@mag.az.mvista.com>
In-Reply-To: <20070209230207.GA12035@mag.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
>>diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
>>index 04da38f..39fa010 100644
>>--- a/arch/powerpc/boot/flatdevtree_misc.c
>>+++ b/arch/powerpc/boot/flatdevtree_misc.c
>>@@ -33,8 +33,20 @@ static int ft_setprop(const void *phandl
>> 	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
>> }
>> 
>>-static unsigned long ft_finalize(void)
>>+unsigned long ft_finalize(void)
> 
> 
> This is unnecessary.  There is already global access from
> dt_ops.finalize.

cuboot has its own dt_ops.finalize, which calls ft_finalize, and 
relocates the tree to someplace that won't get overwritten by the kernel 
relocation.

>>+	unsigned long initrd_end = initrd.addr + initrd.size;
>>+	void *devp;
>>+
>>+	if (initrd.size && (devp = finddevice("/chosen"))) {
>>+		setprop(devp, "linux,initrd-start", &initrd.addr,
>>+		        sizeof(initrd.addr));
>>+		setprop(devp, "linux,initrd-end", &initrd_end,
>>+		        sizeof(initrd_end));
>>+
>>+		ft_add_rsvmap(&cxt, initrd.addr, initrd.size);
>>+	}
>>+
> 
> 
> IMHO, this is a very unnatural place to put this code.
> It really belongs in main.c.  That's where all the rest
> of the code that accesses initrd.* is.

I was trying to not change the existing semantics for the of.c platform, 
which passes the initrd information a different way.

-Scott
