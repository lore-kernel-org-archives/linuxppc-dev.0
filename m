Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463CD1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:44:29 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Jun 2014 09:44:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C12A2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:44:26 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5NNi9HM11010464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:44:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5NNiP6n024174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:44:25 +1000
Date: Tue, 24 Jun 2014 09:44:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 1/3] powerpc/powernv: Sync header with firmware
Message-ID: <20140623234427.GA4955@shangw>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403557814.4587.137.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403557814.4587.137.camel@pasglop>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 07:10:14AM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2014-06-23 at 12:14 +1000, Gavin Shan wrote:
>> The patch synchronizes firmware header file (opal.h) for PCI error
>> injection
>
>The FW API you expose is not PCI specific. I haven't seen the
>corresponding FW patches yet but I'm not fan of that single call
>that collates unrelated things.
>
>I much'd prefer see a opal_pci_err_inject that is specific to
>IO(D)A errors, which takes a PHB ID and goes via the normal dispatch
>to PHB ops inside OPAL. For the rest, especially core specific
>injections, we can provide a separate dedicated call.
>

Thanks, Ben. I'll change the firmware API to have a separate
API (opal_pci_err_inject) for PCI errors.

>Cheers, 
>Ben.
>

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/opal.h                | 65 ++++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
>>  2 files changed, 66 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index 66ad7a7..d982bb8 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -175,6 +175,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
>>  #define OPAL_SET_PARAM				90
>>  #define OPAL_DUMP_RESEND			91
>>  #define OPAL_DUMP_INFO2				94
>> +#define OPAL_ERR_INJECT				96
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> @@ -219,6 +220,69 @@ enum OpalPciErrorSeverity {
>>  	OPAL_EEH_SEV_INF	= 5
>>  };
>>  
>> +enum OpalErrinjctType {
>> +	OpalErrinjctTypeFirst			= 0,
>> +	OpalErrinjctTypeFatal			= 1,
>> +	OpalErrinjctTypeRecoverRandomEvent	= 2,
>> +	OpalErrinjctTypeRecoverSpecialEvent	= 3,
>> +	OpalErrinjctTypeCorruptedPage		= 4,
>> +	OpalErrinjctTypeCorruptedSlb		= 5,
>> +	OpalErrinjctTypeTranslatorFailure	= 6,
>> +	OpalErrinjctTypeIoaBusError		= 7,
>> +	OpalErrinjctTypeIoaBusError64		= 8,
>> +	OpalErrinjctTypePlatformSpecific	= 9,
>> +	OpalErrinjctTypeDcacheStart		= 10,
>> +	OpalErrinjctTypeDcacheEnd		= 11,
>> +	OpalErrinjctTypeIcacheStart		= 12,
>> +	OpalErrinjctTypeIcacheEnd		= 13,
>> +	OpalErrinjctTypeTlbStart		= 14,
>> +	OpalErrinjctTypeTlbEnd			= 15,
>> +	OpalErrinjctTypeUpstreamIoError		= 16,
>> +	OpalErrinjctTypeLast			= 17,
>> +
>> +	/* IoaBusError & IoaBusError64 */
>> +	OpalEitIoaLoadMemAddr			= 0,
>> +	OpalEitIoaLoadMemData			= 1,
>> +	OpalEitIoaLoadIoAddr			= 2,
>> +	OpalEitIoaLoadIoData			= 3,
>> +	OpalEitIoaLoadConfigAddr		= 4,
>> +	OpalEitIoaLoadConfigData		= 5,
>> +	OpalEitIoaStoreMemAddr			= 6,
>> +	OpalEitIoaStoreMemData			= 7,
>> +	OpalEitIoaStoreIoAddr			= 8,
>> +	OpalEitIoaStoreIoData			= 9,
>> +	OpalEitIoaStoreConfigAddr		= 10,
>> +	OpalEitIoaStoreConfigData		= 11,
>> +	OpalEitIoaDmaReadMemAddr		= 12,
>> +	OpalEitIoaDmaReadMemData		= 13,
>> +	OpalEitIoaDmaReadMemMaster		= 14,
>> +	OpalEitIoaDmaReadMemTarget		= 15,
>> +	OpalEitIoaDmaWriteMemAddr		= 16,
>> +	OpalEitIoaDmaWriteMemData		= 17,
>> +	OpalEitIoaDmaWriteMemMaster		= 18,
>> +	OpalEitIoaDmaWriteMemTarget		= 19,
>> +};
>> +
>> +struct OpalErrinjct {
>> +	int32_t type;
>> +	union {
>> +		struct {
>> +			uint32_t addr;
>> +			uint32_t mask;
>> +			uint64_t phb_id;
>> +			uint32_t pe;
>> +			uint32_t function;
>> +		} ioa;
>> +		struct {
>> +			uint64_t addr;
>> +			uint64_t mask;
>> +			uint64_t phb_id;
>> +			uint32_t pe;
>> +			uint32_t function;
>> +		} ioa64;
>> +	};
>> +};
>> +
>>  enum OpalShpcAction {
>>  	OPAL_SHPC_GET_LINK_STATE = 0,
>>  	OPAL_SHPC_GET_SLOT_STATE = 1
>> @@ -870,6 +934,7 @@ int64_t opal_update_flash(uint64_t blk_list);
>>  int64_t opal_dump_init(uint8_t dump_type);
>>  int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
>>  int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
>> +int64_t opal_err_injct(struct OpalErrinjct *ei);
>>  int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
>>  int64_t opal_dump_ack(uint32_t dump_id);
>>  int64_t opal_dump_resend_notification(void);
>> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> index f531ffe..44b3d81 100644
>> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
>> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> @@ -136,6 +136,7 @@ OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
>>  OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
>>  OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
>>  OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
>> +OPAL_CALL(opal_err_injct,			OPAL_ERR_INJECT);
>>  OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
>>  OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
>>  OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
>
>
