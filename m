Return-Path: <mpe@ellerman.id.au>
Message-ID: <1386900030.21216.7.camel@concordia>
Subject: Re: powerpc/powernv: Framework to log critical errors on powernv.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Fri, 13 Dec 2013 13:00:30 +1100
In-Reply-To: <52A99D47.4090503@linux.vnet.ibm.com>
References: <52A99D47.4090503@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-12 at 16:55 +0530, Deepthi Dharwar wrote:
> powerpc/powernv: Framework to log critical errors on powernv.
> 
> From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> 
> This patch provides error logging interfaces to report critical
> powernv error logs to FSP.
> All the required information to dump the error is collected
> at POWERNV level through error log interfaces
> and then pushed on to FSP.
> 
> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal.h                |  125 ++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-elog.c     |   59 +++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
>  3 files changed, 184 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index be404ea..b8d1dd4 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -134,6 +134,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
>  #define OPAL_ELOG_ACK				73
>  #define OPAL_ELOG_RESEND			74
>  #define OPAL_ELOG_SIZE				75
> +#define OPAL_ELOG_SEND				87
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -216,6 +217,122 @@ enum OpalPendingState {
>  	OPAL_EVENT_PCI_ERROR		= 0x200
>  };
>  
> +/* Classification of Error/Events reporting type classification
> + * Platform Events/Errors: Report Machine Check Interrupt
> + * INPUT_OUTPUT: Report all I/O related events/errors
> + * RESOURCE_DEALLOC: Hotplug events and errors
> + * MISC: Miscellanous error
> + * Field: error_events_type
> + */
> +enum Error_Events {
> +	OPAL_PLATFORM,
> +	OPAL_INPUT_OUTPUT,
> +	OPAL_RESOURCE_DEALLOC,
> +	OPAL_MISC,
> +};
> +
> +/* OPAL Subsystem IDs listed for reporting events/errors
> + * Field: subsystem_id
> + */
> +
> +#define OPAL_PROCESSOR_SUBSYSTEM        0x10
> +#define OPAL_MEMORY_SUBSYSTEM           0x20
> +#define OPAL_IO_SUBSYSTEM               0x30
> +#define OPAL_IO_DEVICES                 0x40
> +#define OPAL_CEC_HARDWARE               0x50
> +#define OPAL_POWER_COOLING              0x60
> +#define OPAL_MISC_SUBSYSTEM             0x70
> +#define OPAL_SURVEILLANCE_ERR           0x7A
> +#define OPAL_PLATFORM_FIRMWARE          0x80
> +#define OPAL_SOFTWARE                   0x90
> +#define OPAL_EXTERNAL_ENV               0xA0
> +
> +/* During reporting an event/error the following represents
> + * how serious the logged event/error is. (Severity)
> + * Field: event_sev
> + */
> +#define OPAL_INFO                                   0x00
> +#define OPAL_RECOVERED_ERR_GENERAL                  0x10
> +
> +/* 0x2X series is to denote set of Predictive Error
> + * 0x20 Generic predictive error
> + * 0x21 Predictive error, degraded performance
> + * 0x22 Predictive error, fault may be corrected after reboot
> + * 0x23 Predictive error, fault may be corrected after reboot,
> + * degraded performance
> + * 0x24 Predictive error, loss of redundancy
> + */
> +#define OPAL_PREDICTIVE_ERR_GENERAL                         0x20
> +#define OPAL_PREDICTIVE_ERR_DEGRADED_PERF                   0x21
> +#define OPAL_PREDICTIVE_ERR_FAULT_RECTIFY_REBOOT            0x22
> +#define OPAL_PREDICTIVE_ERR_FAULT_RECTIFY_BOOT_DEGRADE_PERF 0x23
> +#define OPAL_PREDICTIVE_ERR_LOSS_OF_REDUNDANCY              0x24
> +
> +/* 0x4X series for Unrecoverable Error
> + * 0x40 Generic Unrecoverable error
> + * 0x41 Unrecoverable error bypassed with degraded performance
> + * 0x44 Unrecoverable error bypassed with loss of redundancy
> + * 0x45 Unrecoverable error bypassed with loss of redundancy and performance
> + * 0x48 Unrecoverable error bypassed with loss of function
> + */
> +#define OPAL_UNRECOVERABLE_ERR_GENERAL                      0x40
> +#define OPAL_UNRECOVERABLE_ERR_DEGRADE_PERF                 0x41
> +#define OPAL_UNRECOVERABLE_ERR_LOSS_REDUNDANCY              0x44
> +#define OPAL_UNRECOVERABLE_ERR_LOSS_REDUNDANCY_PERF         0x45
> +#define OPAL_UNRECOVERABLE_ERR_LOSS_OF_FUNCTION             0x48
> +
> +/* Event Sub-type
> + * This field provides additional information on the non-error
> + * event type
> + * Field: event_subtype
> + */
> +#define OPAL_NA                                         0x00
> +#define OPAL_MISCELLANEOUS_INFO_ONLY                    0x01
> +#define OPAL_PREV_REPORTED_ERR_RECTIFIED                0x10
> +#define OPAL_SYS_RESOURCES_DECONFIG_BY_USER             0x20
> +#define OPAL_SYS_RESOURCE_DECONFIG_PRIOR_ERR            0x21
> +#define OPAL_RESOURCE_DEALLOC_EVENT_NOTIFY              0x22
> +#define OPAL_CONCURRENT_MAINTENANCE_EVENT               0x40
> +#define OPAL_CAPACITY_UPGRADE_EVENT                     0x60
> +#define OPAL_RESOURCE_SPARING_EVENT                     0x70
> +#define OPAL_DYNAMIC_RECONFIG_EVENT                     0x80
> +#define OPAL_NORMAL_SYS_PLATFORM_SHUTDOWN               0xD0
> +#define OPAL_ABNORMAL_POWER_OFF                         0xE0


None of the above seem to be used anywhere.

cheers
