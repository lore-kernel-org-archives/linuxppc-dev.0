Return-Path: <mpe@ellerman.id.au>
Message-ID: <1387334600.19507.5.camel@concordia>
Subject: Re: [PATCH v2] powerpc/powernv: Framework to log critical errors on
 powernv.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 13:43:20 +1100
In-Reply-To: <52AEF27F.3070202@linux.vnet.ibm.com>
References: <52AEF27F.3070202@linux.vnet.ibm.com>
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

On Mon, 2013-12-16 at 18:00 +0530, Deepthi Dharwar wrote:
> This patch provides error logging interfaces to report critical
> powernv error to FSP.
> All the required information to dump the error is collected
> at POWERNV level through error log interfaces
> and then pushed on to FSP.
> 
> This also supports synchronous error logging in cases of
> PANIC, by passing OPAL_ERROR_PANIC as severity in
> elog_create() call.

Please make note of the fact that none of this code is currently used but will
be in a subsequent patch. When can we expect those patches?


> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 0f01308..1c5440a 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -168,6 +168,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
>  #define OPAL_GET_MSG				85
>  #define OPAL_CHECK_ASYNC_COMPLETION		86
>  #define OPAL_SYNC_HOST_REBOOT			87
> +#define OPAL_ELOG_SEND				88
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -260,6 +261,122 @@ enum OpalMessageType {
>  	OPAL_MSG_TYPE_MAX,
>  };
>  
> +/* Classification of Error/Events reporting type classification

Standard comment style for block comments is:

/*
 * Classification ...
 */

That applies to almost all of your comments in here.


> + * Platform Events/Errors: Report Machine Check Interrupt

I think these comments would be better inline with the values, eg:

	/* Report Machine Check Interrupt */
	OPAL_PLATFORM,

	/* Report all I/O related events/errors */
	OPAL_INPUT_OUTPUT,

	etc.


Again that applies to most of your comments.

> + * INPUT_OUTPUT: Report all I/O related events/errors
> + * RESOURCE_DEALLOC: Hotplug events and errors
> + * MISC: Miscellanous error
> + * Field: error_events_type

What is this "Field:" thing about?

> + */
> +enum error_events {

If you're going to define an enum you should actually use it in the API, I
can't see anywhere you do?

If you do want to use an enum it should be "opal_error_events".

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
> +#define OPAL_ERROR_PANIC                                    0x50
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
> +
> +/* Max user dump size is 14K    */
> +#define OPAL_LOG_MAX_DUMP       14336
> +
> +/* Multiple user data sections */
> +struct opal_usr_data_scn {

Just spell it out? opal_user_data_section 

> +	uint32_t tag;
> +	uint16_t size;
> +	uint16_t component_id;
> +	char data_dump[4];
> +};
> +
> +/* All the information regarding an error/event to be reported
> + * needs to populate this structure using pre-defined interfaces
> + * only
> + */
> +struct opal_errorlog {
> +
> +	uint16_t component_id;
> +	uint8_t error_events_type:3;

Bit field?

> +	uint8_t subsystem_id;
> +
> +	uint8_t event_sev;
> +	uint8_t event_subtype;
> +	uint8_t usr_scn_count; /* User section count */

user_section_count;

> +	uint8_t elog_origin;
> +
> +	uint32_t usr_scn_size; /* User section size */

user_section_size;

> +	uint32_t reason_code;
> +	uint32_t additional_info[4];
> +
> +	char usr_data_dump[OPAL_LOG_MAX_DUMP];
> +};

It looks like this goes straight to Opal, should we be using __packed ?


> @@ -853,6 +970,14 @@ int64_t opal_dump_ack(uint32_t dump_id);
>  int64_t opal_get_msg(uint64_t buffer, size_t size);
>  int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
>  int64_t opal_sync_host_reboot(void);
> +struct opal_errorlog *elog_create(uint8_t err_evt_type, uint16_t component_id,
> +		uint8_t subsystem_id, uint8_t event_sev, uint8_t  event_subtype,
> +		uint32_t reason_code, uint32_t info0, uint32_t info1,
> +		uint32_t info2, uint32_t info3);
> +int update_user_dump(struct opal_errorlog *buf, unsigned char *data,
> +					uint32_t tag, uint16_t size);
> +void commit_errorlog_to_fsp(struct opal_errorlog *buf);
> +int opal_commit_log_to_fsp(void *buf);

Are we using "opal_" as a prefix or not?

> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index 58849d0..ade1e58 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -15,6 +15,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/fs.h>
>  #include <linux/vmalloc.h>
> +#include <linux/mm.h>
>  #include <linux/fcntl.h>
>  #include <asm/uaccess.h>
>  #include <asm/opal.h>
> @@ -22,7 +23,9 @@
>  /* Maximum size of a single log on FSP is 16KB */
>  #define OPAL_MAX_ERRLOG_SIZE	16384
>  
> -/* maximu number of records powernv can hold */
> +#define USR_CHAR_ARRAY_FIXED_SIZE      4

What is this?

> +/* Maximum number of records powernv can hold */

That's an unrelated typo fix AFAICS, please send it separately.

>  #define MAX_NUM_RECORD	128
>  
>  struct opal_err_log {
> @@ -272,6 +275,61 @@ static int init_err_log_buffer(void)
>  	return 0;
>  }
>  
> +/* Interface to be used by POWERNV to push the logs to FSP via Sapphire */
> +struct opal_errorlog *elog_create(uint8_t err_evt_type, uint16_t component_id,
> +		uint8_t subsystem_id, uint8_t event_sev, uint8_t  event_subtype,
> +		uint32_t reason_code, uint32_t info0, uint32_t info1,
> +		uint32_t info2, uint32_t info3)


A call to this function is going to be just a giant list of integer values, it
will not be easy to see at a glance which value goes in which field.

I think you'd be better off with an elog_alloc() routine, and then you just do
the initialisation explicitly so that it's obvious which value goes where:

	elog->error_events_type = FOO;
	elog->component_id = BAR;
	elog->subsystem_id = ETC;


elog_create(uint8_t err_evt_type, uint16_t component_id,
> +		uint8_t subsystem_id, uint8_t event_sev, uint8_t  event_subtype,
> +		uint32_t reason_code, uint32_t info0, uint32_t info1,
> +		uint32_t info2, uint32_t info3)
> +{
> +	struct opal_errorlog *buf;
> +
> +	buf = kzalloc(sizeof(struct opal_errorlog), GFP_KERNEL);
> +	if (!buf) {
> +		printk(KERN_ERR "ELOG: failed to allocate memory.\n");
> +		return NULL;
> +	}
> +
> +	buf->error_events_type = err_evt_type;
> +	buf->component_id = component_id;
> +	buf->subsystem_id = subsystem_id;
> +	buf->event_sev = event_sev;
> +	buf->event_subtype = event_subtype;
> +	buf->reason_code = reason_code;
> +	buf->additional_info[0] = info0;
> +	buf->additional_info[1] = info1;
> +	buf->additional_info[2] = info2;
> +	buf->additional_info[3] = info3;
> +	return buf;
> +}
> +
> +int update_user_dump(struct opal_errorlog *buf, unsigned char *data,
> +				uint32_t tag, uint16_t size)
> +{
> +	char *buffer = (char *)buf->usr_data_dump + buf->usr_scn_size;
> +	struct opal_usr_data_scn *tmp;
> +
> +	if ((buf->usr_scn_size + size) > OPAL_LOG_MAX_DUMP) {
> +		printk(KERN_ERR "ELOG: Size of dump data overruns buffer");

Use pr_err() and set pr_fmt() to "opal-error-log" at the top of the file.

> +		return -1;
> +	}
> +
> +	tmp = (struct opal_usr_data_scn *)buffer;
> +	tmp->tag = tag;
> +	tmp->size = size + sizeof(struct opal_usr_data_scn)
> +				- USR_CHAR_ARRAY_FIXED_SIZE;
> +	memcpy(tmp->data_dump, data, size);
> +
> +	buf->usr_scn_size += tmp->size;
> +	buf->usr_scn_count++;
> +	return 0;
> +}
> +
> +void commit_errorlog_to_fsp(struct opal_errorlog *buf)
> +{
> +	opal_commit_log_to_fsp((void *)(vmalloc_to_pfn(buf) << PAGE_SHIFT));

Can't fail?

> +	kfree(buf);

It's a bit rude to free buf when the caller still has a pointer to it.

> +}


cheers
