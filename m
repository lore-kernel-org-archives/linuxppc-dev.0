Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC2FCDE111
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 02:56:59 +1000 (EST)
Message-Id: <6EC8B59D-62C8-4D9B-B548-4833A06F13AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090422164400.GA9592@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3] powerpc/85xx: Add P2020DS board support
Date: Wed, 22 Apr 2009 11:54:46 -0500
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
	<20090422164400.GA9592@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 11:44 AM, Scott Wood wrote:

> On Tue, Apr 21, 2009 at 10:31:45PM -0500, Kumar Gala wrote:
>> +	localbus@ffe05000 {
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		compatible = "fsl,elbc", "simple-bus";
>
> If this has an elbc more recent than 1.0 (looks like it), we should
> indicate that here.

that might be the case, but I leave it to u-boot to do that.

>> +		reg = <0 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove  
>> once parse code for immrbase fixed
>
> The immrbase code was fixed a long time ago -- this can go away.

will remove

>> +static int __init p2020_ds_probe(void)
>> +{
>> +	unsigned long root = of_get_flat_dt_root();
>> +
>> +	if (of_flat_dt_is_compatible(root, "fsl,P2020DS")) {
>> +#ifdef CONFIG_PCI
>> +		primary_phb_addr = 0x9000;
>> +#endif
>> +		return 1;
>> +	} else {
>> +		return 0;
>> +	}
>> +}
>
> Unnecessary "else".

will fix this and the 2 other cases it shows up on.

- k
