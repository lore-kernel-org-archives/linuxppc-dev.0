Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC35D1A03A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 19:32:10 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 10 Feb 2016 18:32:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 771F33578055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 19:32:08 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A8Vv567798846
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 19:32:05 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A8VaWB022363
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 19:31:36 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 10/18] cxl: New hcalls to support CAPI adapters
In-reply-to: <1454765345-7417-11-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-11-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 19:31:10 +1100
Message-Id: <1455089064-sup-7113@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#define H_CONTROL_CA_FUNCTION_RESET                   1 /* perform a reset */
> +#define H_CONTROL_CA_FUNCTION_SUSPEND_PROCESS         2 /* suspend a process from being executed */
> +#define H_CONTROL_CA_FUNCTION_RESUME_PROCESS          3 /* resume a process to be executed */
> +#define H_CONTROL_CA_FUNCTION_READ_ERR_STATE          4 /* read the error state */
> +#define H_CONTROL_CA_FUNCTION_GET_AFU_ERR             5 /* collect the AFU error buffer */
> +#define H_CONTROL_CA_FUNCTION_GET_CONFIG              6 /* collect configuration record */
> +#define H_CONTROL_CA_FUNCTION_GET_DOWNLOAD_STATE      7 /* query to return download status */
> +#define H_CONTROL_CA_FUNCTION_TERMINATE_PROCESS       8 /* terminate the process before completion */
> +#define H_CONTROL_CA_FUNCTION_COLLECT_VPD             9 /* collect VPD */
> +#define H_CONTROL_CA_FUNCTION_GET_FUNCTION_ERR_INT   11 /* read the function-wide error data based on an interrupt */
> +#define H_CONTROL_CA_FUNCTION_ACK_FUNCTION_ERR_INT   12 /* acknowledge function-wide error data based on an interrupt */
> +#define H_CONTROL_CA_FUNCTION_GET_ERROR_LOG          13 /* retrieve the Platform Log ID (PLID) of an error log */
> +
> +#define H_CONTROL_CA_FAULTS_RESPOND_PSL    1
> +#define H_CONTROL_CA_FAULTS_RESPOND_AFU    2
> +
> +#define OP_STR_AFU(x)                            \
> +    (x == H_CONTROL_CA_FUNCTION_RESET ? "RESET" :            \
> +        x == H_CONTROL_CA_FUNCTION_RESUME_PROCESS ? "PROCESS" :    \
> +        x == H_CONTROL_CA_FUNCTION_RESUME_PROCESS ? "RESUME" :    \

H_CONTROL_CA_FUNCTION_RESUME_PROCESS is listed twice here, and the names
don't match.

> +        x == H_CONTROL_CA_FUNCTION_READ_ERR_STATE ? "READ_ERR_STATE" : \
> +        x == H_CONTROL_CA_FUNCTION_GET_AFU_ERR ? "GET_AFU_ERR" : \
> +        x == H_CONTROL_CA_FUNCTION_GET_CONFIG ? "GET_CONFIG" :    \
> +        x == H_CONTROL_CA_FUNCTION_GET_DOWNLOAD_STATE ? "DOWNLOAD_STATE" : \
> +        x == H_CONTROL_CA_FUNCTION_TERMINATE_PROCESS ? "TERMINATE_PROC" : \
> +        x == H_CONTROL_CA_FUNCTION_COLLECT_VPD ? "COLLECT_VPD" :    \
> +        x == H_CONTROL_CA_FUNCTION_GET_FUNCTION_ERR_INT ? "GET_ERR_INTERRUPT" :    \
> +        x == H_CONTROL_CA_FUNCTION_ACK_FUNCTION_ERR_INT ? "ACK_ERR_INTERRUPT" :    \
> +        x == H_CONTROL_CA_FUNCTION_GET_ERROR_LOG ? "GET_ERROR_LOG" : \
> +        "UNKNOWN OP")
> +
> +#define H_CONTROL_CA_FACILITY_RESET                   1 /* perform a reset */
> +#define H_CONTROL_CA_FACILITY_COLLECT_VPD             2 /* collect VPD */
> +
> +#define OP_STR_CONTROL_ADAPTER(x)                    \
> +    (x == H_CONTROL_CA_FACILITY_RESET ? "RESET" :            \
> +        x == H_CONTROL_CA_FACILITY_COLLECT_VPD ? "COLLECT_VPD" : \
> +        "UNKNOWN OP")
> +
> +#define H_CONTROL_CA_FACILITY_DOWNLOAD                1 /* download adapter image */
> +#define H_CONTROL_CA_FACILITY_VALIDATE                2 /* validate adapter image */
> +
> +#define OP_STR_DOWNLOAD_ADAPTER(x)                    \
> +    (x == H_CONTROL_CA_FACILITY_DOWNLOAD ? "DOWNLOAD" :        \
> +        x == H_CONTROL_CA_FACILITY_VALIDATE ? "VALIDATE" :    \
> +        "UNKNOWN OP")
> +

Since these are almost sequential how about using static arrays and a
lookup helper, like:

static char *afu_op_names[] = {
	"UNKNOWN_OP",           /* 0 undefined */
	"RESET",                /* 1 */
	"SUSPEND_PROCESS",      /* 2 */
	"RESUME_PROCESS",       /* 3 */
	"READ_ERR_STATE",       /* 4 */
	"GET_AFU_ERR",          /* 5 */
	"GET_CONFIG",           /* 6 */
	"GET_DOWNLOAD_STATE",   /* 7 */
	"TERMINATE_PROCESS",    /* 8 */
	"COLLECT_VPD",          /* 9 */
	"UNKNOWN_OP",           /* 10 undefined */
	"GET_FUNCTION_ERR_INT", /* 11 */
	"ACK_FUNCTION_ERR_INT", /* 12 */
	"GET_ERROR_LOG",        /* 13 */
};

static char *control_adapter_op_names[] = {
	"UNKNOWN_OP",           /* 0 undefined */
	"RESET",                /* 1 */
	"COLLECT_VPD",          /* 2 */
};

static char *download_op_names[] = {
	"UNKNOWN_OP",           /* 0 undefined */
	"DOWNLOAD",             /* 1 */
	"VALIDATE",             /* 2 */
};

static char* op_str(unsigned int op, char *name_array[], int array_len)
{
	if (op >= array_len)
		return "UNKNOWN_OP";
	return name_array[op];
}

#define OP_STR(op, name_array)      op_str(op, name_array, ARRAY_SIZE(name_array))

#define OP_STR_AFU(op)              OP_STR(op, afu_op_names)
#define OP_STR_CONTROL_ADAPTER(op)  OP_STR(op, control_adapter_op_names)
#define OP_STR_DOWNLOAD_ADAPTER(op) OP_STR(op, download_op_names)

> +    buf = (u32 *) element;
> +    for (i = 0; i*4 < sizeof(struct cxl_process_element_hcall); i += 4) {
> +        if ((i+3)*4 < sizeof(struct cxl_process_element_hcall))
> +            pr_devel("%.8x %.8x %.8x %.8x\n", buf[i], buf[i + 1], buf[i + 2], buf[i + 3]);
> +        else if ((i+2)*4 < sizeof(struct cxl_process_element_hcall))
> +            pr_devel("%.8x %.8x %.8x\n", buf[i], buf[i + 1], buf[i + 2]);
> +        else if ((i+1)*4 < sizeof(struct cxl_process_element_hcall))
> +            pr_devel("%.8x %.8x\n", buf[i], buf[i + 1]);
> +        else
> +            pr_devel("%.8x\n", buf[i]);

For something that is only used with pr_devel for debugging I'd like
something that is a little easier on the eyes, like:

or (i = 0; i < sizeof(struct cxl_process_element_hcall); i++) {
	if (i && i % 4 == 0)
		pr_devel("\n");
	pr_devel("%08x ", buf[i]);
}
pr_devel("\n");



> +/*
> + * This is straight out of PAPR, but replacing some of the compound fields with
> + * a single field, where they were identical to the register layout.
> + *
> + * The 'flags' parameter regroups the various bit-fields
> + */

Thanks for getting rid of the bit fields :)

Cheers,
-Ian
