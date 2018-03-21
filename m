Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dPb4yFjzDqh0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:18:43 +1100 (AEDT)
Received: by mail-it0-x244.google.com with SMTP id z143-v6so14973816itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:18:43 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id
 199-v6sm2455276itl.1.2018.03.20.22.18.40
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:18:41 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] powerpc/eeh: Remove always-true tests in
 eeh_reset_device()
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <5a636a21f3352efa7a41bf4032f3a57973c4c18b.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <059b19f4-d64e-8ffc-0a26-dc279f90aec7@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:18:38 +1100
MIME-Version: 1.0
In-Reply-To: <5a636a21f3352efa7a41bf4032f3a57973c4c18b.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:49 pm, Sam Bobroff wrote:
> eeh_reset_device() tests the value of 'bus' more than once but the
> only caller, eeh_handle_normal_device() does this test itself and will
> never pass NULL.
> 
> So, remove the dead tests.
> 
> This should not change behaviour.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/kernel/eeh_driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 07437d765434..93fc22e791fa 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -655,7 +655,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  			pci_hp_remove_devices(bus);
>  			pci_unlock_rescan_remove();
>  		}
> -	} else if (bus) {
> +	} else {
>  		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
>  	}
>  
> @@ -708,7 +708,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
>  			pci_hp_add_devices(bus);
>  		}
> -	} else if (bus && rmv_data->removed) {
> +	} else if (rmv_data->removed) {
>  		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
>  		ssleep(5);
>  
> 


-- 
Alexey
