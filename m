Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67143C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:38:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36C02086E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36C02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vfsz6XfQzF1Q4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:38:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vfqm583jzF1BS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:36:19 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AGYliG143622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:36:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1m7gjcj4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:36:16 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 12:36:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 12:36:13 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AGaCgE29753526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 16:36:12 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB66C12405B;
 Wed, 10 Oct 2018 13:35:58 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7767C124054;
 Wed, 10 Oct 2018 13:35:58 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.80.235.83])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 10 Oct 2018 13:35:58 -0400 (EDT)
Subject: Re: [PATCH 1/2] powerpc/pseries: PAPR persistent memory support
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20181010060812.20068-1-oohall@gmail.com>
 <20181010060812.20068-2-oohall@gmail.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 10 Oct 2018 11:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010060812.20068-2-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101016-0072-0000-0000-000003B2A4FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009854; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100693; UDB=6.00569506; IPR=6.00880742; 
 MB=3.00023698; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 16:36:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101016-0073-0000-0000-000049B57235
Message-Id: <857573fb-6839-000b-a64a-c020b0d8faea@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100161
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/10/2018 01:08 AM, Oliver O'Halloran wrote:
> This patch implements support for discovering storage class memory
> devices at boot and for handling hotplug of new regions via RTAS
> hotplug events.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/include/asm/firmware.h       |  3 ++-
>  arch/powerpc/include/asm/hvcall.h         | 10 +++++++++-
>  arch/powerpc/include/asm/rtas.h           |  2 ++
>  arch/powerpc/kernel/rtasd.c               |  2 ++
>  arch/powerpc/platforms/pseries/Makefile   |  2 +-
>  arch/powerpc/platforms/pseries/dlpar.c    |  4 ++++
>  arch/powerpc/platforms/pseries/firmware.c |  1 +
>  arch/powerpc/platforms/pseries/pseries.h  |  5 +++++
>  arch/powerpc/platforms/pseries/ras.c      |  3 ++-
>  9 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index 7a051bd21f87..113c64d5d394 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -52,6 +52,7 @@
>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
>  #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
>  #define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
> +#define FW_FEATURE_PAPR_SCM 	ASM_CONST(0x0000001000000000)
> 
>  #ifndef __ASSEMBLY__
> 
> @@ -69,7 +70,7 @@ enum {
>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
>  		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
>  		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
> -		FW_FEATURE_DRC_INFO,
> +		FW_FEATURE_DRC_INFO | FW_FEATURE_PAPR_SCM,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>  	FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index a0b17f9f1ea4..0e81ef83b35a 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -295,7 +295,15 @@
>  #define H_INT_ESB               0x3C8
>  #define H_INT_SYNC              0x3CC
>  #define H_INT_RESET             0x3D0
> -#define MAX_HCALL_OPCODE	H_INT_RESET
> +#define H_SCM_READ_METADATA     0x3E4
> +#define H_SCM_WRITE_METADATA    0x3E8
> +#define H_SCM_BIND_MEM          0x3EC
> +#define H_SCM_UNBIND_MEM        0x3F0
> +#define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
> +#define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
> +#define H_SCM_MEM_QUERY	        0x3FC
> +#define H_SCM_BLOCK_CLEAR       0x400
> +#define MAX_HCALL_OPCODE	H_SCM_BLOCK_CLEAR
> 
>  /* H_VIOCTL functions */
>  #define H_GET_VIOA_DUMP_SIZE	0x01
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 71e393c46a49..1e81f3d55457 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -125,6 +125,7 @@ struct rtas_suspend_me_data {
>  #define RTAS_TYPE_INFO			0xE2
>  #define RTAS_TYPE_DEALLOC		0xE3
>  #define RTAS_TYPE_DUMP			0xE4
> +#define RTAS_TYPE_HOTPLUG		0xE5
>  /* I don't add PowerMGM events right now, this is a different topic */ 
>  #define RTAS_TYPE_PMGM_POWER_SW_ON	0x60
>  #define RTAS_TYPE_PMGM_POWER_SW_OFF	0x61
> @@ -316,6 +317,7 @@ struct pseries_hp_errorlog {
>  #define PSERIES_HP_ELOG_RESOURCE_MEM	2
>  #define PSERIES_HP_ELOG_RESOURCE_SLOT	3
>  #define PSERIES_HP_ELOG_RESOURCE_PHB	4
> +#define PSERIES_HP_ELOG_RESOURCE_PMEM   6
> 
>  #define PSERIES_HP_ELOG_ACTION_ADD	1
>  #define PSERIES_HP_ELOG_ACTION_REMOVE	2
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 6fafc82c04b0..fad0baddfcba 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -91,6 +91,8 @@ static char *rtas_event_type(int type)
>  			return "Dump Notification Event";
>  		case RTAS_TYPE_PRRN:
>  			return "Platform Resource Reassignment Event";
> +		case RTAS_TYPE_HOTPLUG:
> +			return "Hotplug Event";
>  	}
> 
>  	return rtas_type[0];
> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> index 7e89d5c47068..892b27ced973 100644
> --- a/arch/powerpc/platforms/pseries/Makefile
> +++ b/arch/powerpc/platforms/pseries/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
>  obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
> 
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
> -obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
> +obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o pmem.o
> 
>  obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
>  obj-$(CONFIG_HVCS)		+= hvcserver.o
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a0b20c03f078..795996fefdb9 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -357,6 +357,10 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
>  	case PSERIES_HP_ELOG_RESOURCE_CPU:
>  		rc = dlpar_cpu(hp_elog);
>  		break;
> +	case PSERIES_HP_ELOG_RESOURCE_PMEM:
> +		rc = dlpar_hp_pmem(hp_elog);

You reference a dlpar handler for pmem here but I am not finding a handler
defined when CONFIG_MEMORY_HOTPLUG is defined. The update to pseries.h below
only provides a definition when it is not defined.

Also, do we need to handle dlpar of pmem memory? There have been discussion of
supporting this in the future but I did not thin it was currently supported.

-Nathan

> +		break;
> +
>  	default:
>  		pr_warn_ratelimited("Invalid resource (%d) specified\n",
>  				    hp_elog->resource);
> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
> index a3bbeb43689e..4927de57d8ee 100644
> --- a/arch/powerpc/platforms/pseries/firmware.c
> +++ b/arch/powerpc/platforms/pseries/firmware.c
> @@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
>  	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
>  	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
>  	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
> +	{FW_FEATURE_PAPR_SCM,		"hcall-scm"},
>  };
> 
>  /* Build up the firmware features bitmask using the contents of
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 60db2ee511fb..d0829677c896 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -63,11 +63,16 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
>  			 struct completion *hotplug_done, int *rc);
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
> +int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog);
>  #else
>  static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  {
>  	return -EOPNOTSUPP;
>  }
> +int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
> +{
> +	return -EOPNOTSUPP;
> +};
>  #endif
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 851ce326874a..ae22fc007276 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -237,7 +237,8 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
>  	 * hotplug events on the ras_log_buf to be handled by rtas_errd.
>  	 */
>  	if (hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_MEM ||
> -	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU)
> +	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU ||
> +	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_PMEM)
>  		queue_hotplug_event(hp_elog, NULL, NULL);
>  	else
>  		log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
> 

