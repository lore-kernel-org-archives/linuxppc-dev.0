Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB71B1A0585
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:02:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Mon, 11 May 2015 17:02:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EB2B42BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:02:37 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B72TY638142184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:02:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B724ca009518
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:02:05 +1000
Message-ID: <555053DA.4010701@linux.vnet.ibm.com>
Date: Mon, 11 May 2015 12:31:46 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 1/2] powerpc/powernv: Add poweroff (EPOW, DPO) events
 support for PowerNV platform
References: <1430991020-7556-1-git-send-email-vipin@linux.vnet.ibm.com>
 <1430991020-7556-2-git-send-email-vipin@linux.vnet.ibm.com>
 <CACPK8XdvbuUpNkxj2CvWLvgdm8M4un6id0i2E+G2WhFoG_bJpw@mail.gmail.com>
In-Reply-To: <CACPK8XdvbuUpNkxj2CvWLvgdm8M4un6id0i2E+G2WhFoG_bJpw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joel,
            Thanks for review. My comments below.

On 05/08/2015 06:56 AM, Joel Stanley wrote:
> Hello Vipin,
>
> On Thu, May 7, 2015 at 7:00 PM, Vipin K Parashar
> <vipin@linux.vnet.ibm.com> wrote:
>> This patch adds support for FSP EPOW (Early Power Off Warning) and
>> DPO (Delayed Power Off) events support for PowerNV platform.
> I reviewed this patch for the changes it made to the existing poweroff
> code, you still need someone to look at the EPOW code itself.
>
>> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/opal-api.h            |  30 ++
>>   arch/powerpc/include/asm/opal.h                |   3 +-
>>   arch/powerpc/platforms/powernv/opal-power.c    | 379 +++++++++++++++++++++++--
>>   arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>>   4 files changed, 391 insertions(+), 22 deletions(-)
>>
>>   /* Internal functions */
>>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>> diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
>> index ac46c2c..7c1b2f8 100644
>> --- a/arch/powerpc/platforms/powernv/opal-power.c
>> +++ b/arch/powerpc/platforms/powernv/opal-power.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * PowerNV OPAL power control for graceful shutdown handling
>> + * PowerNV poweroff events support
>>    *
>>    * Copyright 2015 IBM Corp.
>>    *
>> @@ -9,58 +9,395 @@
>>    * 2 of the License, or (at your option) any later version.
>>    */
>>
>> +#define pr_fmt(fmt)    "POWEROFF_EVENT: "    fmt
> OPAL_POWER?

Agreed.

>
>> +
>>   #include <linux/kernel.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/timer.h>
>>   #include <linux/reboot.h>
>> -#include <linux/notifier.h>
>> -
>> +#include <linux/of.h>
>>   #include <asm/opal.h>
>>   #include <asm/machdep.h>
>>
>> -#define SOFT_OFF 0x00
>> -#define SOFT_REBOOT 0x01
>> +/* Power control event types */
>> +#define SOFT_OFF       0x00
>> +#define SOFT_REBOOT    0x01
> While you're touching this code, I think these should be moved to opal-api.h

Sure will do.

>
>> +
>> +/* Max time for graceful system shutdown including guests. */
>> +#define MAX_POWEROFF_SYS_TIME  600
>> +
>> +/* IPMI power-control events notifier */
>>   static int opal_power_control_event(struct notifier_block *nb,
>> -                                   unsigned long msg_type, void *msg)
>> +                               unsigned long msg_type, void *msg)
>>   {
>> -       struct opal_msg *power_msg = msg;
>>          uint64_t type;
>> +       struct opal_msg *power_msg = msg;
>>
>>          type = be64_to_cpu(power_msg->params[0]);
>>
>>          switch (type) {
>>          case SOFT_REBOOT:
>> -               pr_info("OPAL: reboot requested\n");
>> +               pr_info("Reboot requested\n");
> I prefer the OPAL prefix.

OPAL prefix will get added with pr_fmt used above. So separate tag not 
needed.

>
>>                  orderly_reboot();
>>                  break;
>>          case SOFT_OFF:
>> -               pr_info("OPAL: poweroff requested\n");
>> +               pr_info("Poweroff requested\n");
> Ditto.

Same as above.

>
>>                  orderly_poweroff(true);
>>                  break;
>>          default:
>> -               pr_err("OPAL: power control type unexpected %016llx\n", type);
>> +               pr_err("Unknown event %llu\n", type);
> Ditto.

Same as above.

>
>>          }
>>
>>          return 0;
>>   }
>>
>> +/* OPAL EPOW event notifier block */
>> +static struct notifier_block opal_epow_nb = {
>> +       .notifier_call  = opal_epow_event,
>> +       .next           = NULL,
>> +       .priority       = 0,
>> +};
>> +
>> +/* OPAL DPO event notifier block */
>> +static struct notifier_block opal_dpo_nb = {
>> +       .notifier_call  = opal_dpo_event,
>> +       .next           = NULL,
>> +       .priority       = 0,
>> +};
>> +
>> +/* OPAL Power control events */
>>   static struct notifier_block opal_power_control_nb = {
>> -       .notifier_call  = opal_power_control_event,
>> -       .next           = NULL,
>> -       .priority       = 0,
>> +       .notifier_call  = opal_power_control_event,
>> +       .next           = NULL,
>> +       .priority       = 0,
>>   };
> Looks like you changed the whitespace?

Probably otherwise no change needed here.

>
>> -static int __init opal_power_control_init(void)
>> +/* Poweroff events init */
>> +static int __init opal_poweroff_events_init(void)
> This comment does not add any value.
>
> Renaming the function doesn't add much either.

ok. Will retain original name.

>
>>   {
>>          int ret;
>> +       struct device_node *node_epow;
>>
>> -       ret = opal_message_notifier_register(OPAL_MSG_SHUTDOWN,
>> -                                            &opal_power_control_nb);
>> -       if (ret) {
>> -               pr_err("%s: Can't register OPAL event notifier (%d)\n",
>> -                               __func__, ret);
>> -               return ret;
>> +       /*
>> +       * Determine EPOW, DPO support in hardware.
>> +       */
>> +       node_epow = of_find_node_by_path("/ibm,opal/epow");
>> +       if (node_epow) {
>> +               if (of_device_is_compatible(node_epow, "ibm,opal-epow")) {
>> +                       epow_supported = true;
>> +                       dpo_supported = true;
> Why are these separate flags? Do we have any systems that will support
> EPOW but not DPO, or DPO without EPOW?
>
> I suggest merging them into the one flag.

Had introduced two flags as future BMC systems might have EPOW while DPO 
remains FSP specific.
But agree that since today both of these are FSP specific so will merge 
both of them into single flag.

>
>> +                       pr_info("OPAL EPOW, DPO support detected.\n");
>> +               }
>> +               of_node_put(node_epow);
>> +       }
>> +
>> +       /* Prepare to handle EPOW events */
>> +       if (epow_supported) {
>> +               /* Initialize poweroff timer */
>> +               init_timer(&epow_timer);
>> +               epow_timer.function = epow_poweroff;
>> +
>> +               /* Register EPOW event notifier */
>> +               ret = opal_message_notifier_register(OPAL_MSG_EPOW,
>> +                               &opal_epow_nb);
>> +               if (ret) {
>> +                       pr_err("EPOW event notifier registration failed, "
>> +                                       "ret = %d\n", ret);
>> +               }
>> +       }
>> +
>> +       if (dpo_supported) {
>> +               /* Register DPO event notifier */
>> +               ret = opal_message_notifier_register(OPAL_MSG_DPO,
>> +                               &opal_dpo_nb);
>> +               if (ret)
>> +                       pr_err("DPO event notifier registration failed, "
>> +                                       "ret = %d\n", ret);
>>          }
>>
>> +       /* Check for any existing EPOW or DPO events. */
>> +       process_existing_poweroff_events();
>> +
>> +       /* Register IPMI poweroff events notifier */
>> +       ret = opal_message_notifier_register(OPAL_MSG_SHUTDOWN,
>> +                               &opal_power_control_nb);
>> +       if (ret)
>> +               pr_err("IPMI power-control events notifier registration "
>> +                               "failed, ret = %d\n", ret);
> The comment and the pr_err message are both incorrect; this is not an
> IPMI event but an OPAL event.

Will make them just power-control. OPAL will anyway get added with 
PREFIX mentioned above

>
>> +
>> +
>> +       pr_info("Poweroff events support initialized\n");
> This is unnecessary.

hmm, just a informational message indicating kernel support for 
power-control and power-off events.
Comes handy for quickly checking support via kernel logs.

>
>>          return 0;
>>   }
>> -machine_subsys_initcall(powernv, opal_power_control_init);
>> +
>> +machine_subsys_initcall(powernv, opal_poweroff_events_init);
>> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> index a7ade94..5d3c8e3 100644
>> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
>> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> @@ -249,6 +249,7 @@ OPAL_CALL(opal_pci_reinit,                  OPAL_PCI_REINIT);
>>   OPAL_CALL(opal_pci_mask_pe_error,              OPAL_PCI_MASK_PE_ERROR);
>>   OPAL_CALL(opal_set_slot_led_status,            OPAL_SET_SLOT_LED_STATUS);
>>   OPAL_CALL(opal_get_epow_status,                        OPAL_GET_EPOW_STATUS);
>> +OPAL_CALL(opal_get_dpo_status,                 OPAL_GET_DPO_STATUS);
>>   OPAL_CALL(opal_set_system_attention_led,       OPAL_SET_SYSTEM_ATTENTION_LED);
>>   OPAL_CALL(opal_pci_next_error,                 OPAL_PCI_NEXT_ERROR);
>>   OPAL_CALL(opal_pci_poll,                       OPAL_PCI_POLL);
>> --
>> 1.9.3
>>
