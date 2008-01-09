Return-Path: <neko@genesi-usa.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.233])
	by ozlabs.org (Postfix) with ESMTP id A7FFADE041
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:22:53 +1100 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so108339hud.9
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:22:51 -0800 (PST)
Message-ID: <4784E78C.40904@genesi-usa.com>
Date: Wed, 09 Jan 2008 15:26:04 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: add phy-handle property for fec_mpc52xx
References: <20080109140608.GA15673@aepfle.de>
In-Reply-To: <20080109140608.GA15673@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clarification: I really have to disagree with this patch, and Sven.

The whole point of removing the stuff from the Linux kernel (as the
efika.forth script and the associated patch performs) is that it means
the Linux kernel is no longer a "moving target" for our firmware
development.

If users require these kernels they can run efika.forth - the major
stumbling block being this is quite ugly to do right now. This is our
problem - bplan, Genesi, myself whoever you want to target - it should
not be made into a Linux problem by creating this "moving target" that
needs constant patching to maintain driver coherency.

There is a clever way to load in a forth script to nvramrc on the
Efika through exploitation of an exposed internal firmware structure
(not security critical, just very useful). Unfortunately right now I
am not willing to shoulder the entire burden of writing, testing and
further development of a suite of tools to bridge the gap between the
current firmware which misses certain features, and a new firmware
which may not be released in a timely fashion.

If anyone wants to help/assist/suggest any updates to efika.forth,
create binary tools which assist the installation of the script for
users and for placement on Linux distro CDs etc. I would be very
grateful, but it seems we have hit the Wall of Apathy where users
complain for a feature but are not willing to work for it.

(I am invoking the Open Source Fallacy of that if the source is
available you can patch it, I say that patching Linux is not the
solution, but patching the firmware is. But nobody is willing to
work on patching the firmware and keeping Linux entirely independant
of our so-deemed "crappy" firmware)

Please let's keep the nature of our firmware and the Linux codebase
independant, and move the burden of support to Genesi, and not the
Linux PowerPC team. After all, what is next, after phy-handle do
you want to add i2c, irda, missing xlb/cdm entries in the patch so
that other things work? Does everyone have to custom compile their
own kernel? What happens if we do another firmware release and
the Linux kernel overwrites important values without checking as
it does now? It simply causes problems.

Therefore I heartily do not acknowledge this patch. Olaf, if you
would like to assist in the development of an easy installer for
the device tree supplement for users, please feel free... save
these guys from having to maintain support for a broken device
tree by providing a correct one :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> The new network driver fec_mpc52xx will not work on efika because the
> firmware does not provide all required properties.
> http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
> create more properties. But only the phy stuff is required to get a
> working network.
> 
> This should go into the kernel because its appearently
> impossible to boot the script via tftp and then load the real boot
> binary (yaboot or zimage).
> 
> ---
>  arch/powerpc/kernel/prom_init.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1487,6 +1487,34 @@ static void __init prom_find_mmu(void)
>  	else if (strncmp(version, "FirmWorks,3.", 12) == 0) {
>  		of_workarounds = OF_WA_CLAIM | OF_WA_LONGTRAIL;
>  		call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
> +#ifdef CONFIG_PPC_MPC52xx
> +	} else if (strcmp(version, "EFIKA5K2") == 0) {
> +		call_prom("interpret", 1, 1,
> +			" .\" Adding EFIKA5K2 Ethernet PHY\" cr"
> +			" s\" /builtin\" find-device"
> +			" new-device"
> +				" 1 encode-int s\" #address-cells\" property"
> +				" 0 encode-int s\" #size-cells\" property"
> +				" s\" mdio\" 2dup device-name device-type"
> +				" s\" mpc5200b-fec-phy\" encode-string s\" compatible\" property"
> +				" 0xf0003000 0x400 reg"
> +				" 0x2 encode-int"
> +				" 0x5 encode-int encode+"
> +				" 0x3 encode-int encode+"
> +				" s\" interrupts\" property"
> +				" new-device"
> +					" s\" ethernet-phy\" 2dup device-name device-type"
> +					" 0x10 encode-int s\" reg\" property"
> +					" my-self"
> +					" ihandle>phandle"
> +				" finish-device"
> +			" finish-device"
> +			" s\" /builtin/ethernet\" find-device"
> +				" encode-int"
> +				" s\" phy-handle\" property"
> +			" device-end"
> +			);
> +#endif
>  	} else
>  		return;
>  	_prom->memory = call_prom("open", 1, 1, ADDR("/memory"));
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
