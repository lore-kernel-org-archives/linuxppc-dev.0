Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id E9736DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 01:44:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so57086anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 06:44:58 -0800 (PST)
Message-ID: <fa686aa40801090644q5d1aa117ka7e8f5aed34237bd@mail.gmail.com>
Date: Wed, 9 Jan 2008 07:44:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olaf Hering" <olaf@aepfle.de>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <20080109140608.GA15673@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109140608.GA15673@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Woo!  Thanks Olaf.  I was just about to sit down and write something
like this myself.  Looks good to me.  I'll pick this up (but I'm going
to move it to the fixup_device_tree_efika() function)

Cheers,
g.


On 1/9/08, Olaf Hering <olaf@aepfle.de> wrote:
>
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
>         else if (strncmp(version, "FirmWorks,3.", 12) == 0) {
>                 of_workarounds = OF_WA_CLAIM | OF_WA_LONGTRAIL;
>                 call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
> +#ifdef CONFIG_PPC_MPC52xx
> +       } else if (strcmp(version, "EFIKA5K2") == 0) {
> +               call_prom("interpret", 1, 1,
> +                       " .\" Adding EFIKA5K2 Ethernet PHY\" cr"
> +                       " s\" /builtin\" find-device"
> +                       " new-device"
> +                               " 1 encode-int s\" #address-cells\" property"
> +                               " 0 encode-int s\" #size-cells\" property"
> +                               " s\" mdio\" 2dup device-name device-type"
> +                               " s\" mpc5200b-fec-phy\" encode-string s\" compatible\" property"
> +                               " 0xf0003000 0x400 reg"
> +                               " 0x2 encode-int"
> +                               " 0x5 encode-int encode+"
> +                               " 0x3 encode-int encode+"
> +                               " s\" interrupts\" property"
> +                               " new-device"
> +                                       " s\" ethernet-phy\" 2dup device-name device-type"
> +                                       " 0x10 encode-int s\" reg\" property"
> +                                       " my-self"
> +                                       " ihandle>phandle"
> +                               " finish-device"
> +                       " finish-device"
> +                       " s\" /builtin/ethernet\" find-device"
> +                               " encode-int"
> +                               " s\" phy-handle\" property"
> +                       " device-end"
> +                       );
> +#endif
>         } else
>                 return;
>         _prom->memory = call_prom("open", 1, 1, ADDR("/memory"));
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
