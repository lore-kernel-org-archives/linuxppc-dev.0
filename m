Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA8C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 16:01:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA41208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 16:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA41208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4347nX4vQ4zDqkc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 03:01:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4347kw1R4pzDqk5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 02:59:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4347kp25Ptz9v0bq;
 Tue, 27 Nov 2018 16:59:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id HZqsiMQnoPpC; Tue, 27 Nov 2018 16:59:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4347kp1Pytz9v0bb;
 Tue, 27 Nov 2018 16:59:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9483C8B832;
 Tue, 27 Nov 2018 16:59:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id aJ5j15rPczHl; Tue, 27 Nov 2018 16:59:15 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F3CDE8B827;
 Tue, 27 Nov 2018 16:59:14 +0100 (CET)
Subject: Re: [PATCH] lkdtm: do not depend on CONFIG_BLOCK
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
 <20181127074316.GC13965@kroah.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8daf27d0-0f58-2dd6-c1bb-7b634494212a@c-s.fr>
Date: Tue, 27 Nov 2018 15:59:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181127074316.GC13965@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/27/2018 07:43 AM, Greg Kroah-Hartman wrote:
> On Fri, Nov 09, 2018 at 07:05:51AM +0000, Christophe Leroy wrote:
>> Most parts of lkdtm don't require CONFIG_BLOCK.
>>
>> This patch limits dependency to CONFIG_BLOCK in order to give embedded
>> platforms which don't select CONFIG_BLOCK the opportunity to use LKDTM.
>>
>> Fixes: fddd9cf82c9f ("make LKDTM depend on BLOCK")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   drivers/misc/lkdtm/core.c | 7 ++++++-
>>   lib/Kconfig.debug         | 1 -
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
>> index 2837dc77478e..bc76756b7eda 100644
>> --- a/drivers/misc/lkdtm/core.c
>> +++ b/drivers/misc/lkdtm/core.c
>> @@ -40,9 +40,12 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/hrtimer.h>
>>   #include <linux/slab.h>
>> -#include <scsi/scsi_cmnd.h>
>>   #include <linux/debugfs.h>
>>   
>> +#ifdef CONFIG_BLOCK
>> +#include <scsi/scsi_cmnd.h>
>> +#endif
> 
> Why would this config option be needed to be checked just to be able to
> include a .h file?

Because if including that file regardless of the config option, you get:

   CALL    scripts/checksyscalls.sh
   CC      drivers/misc/lkdtm/core.o
In file included from ./include/scsi/scsi_cmnd.h:7:0,
                  from drivers/misc/lkdtm/core.c:45:
./include/linux/t10-pi.h:40:41: warning: 'struct request' declared 
inside parameter list
  static inline u32 t10_pi_ref_tag(struct request *rq)
                                          ^
./include/linux/t10-pi.h:40:41: warning: its scope is only this 
definition or declaration, which is probably not what you want
./include/linux/t10-pi.h:61:8: warning: 'struct request' declared inside 
parameter list
         unsigned int intervals)
         ^
./include/linux/t10-pi.h:64:42: warning: 'struct request' declared 
inside parameter list
  static inline void t10_pi_prepare(struct request *rq, u8 protection_type)
                                           ^
In file included from ./include/scsi/scsi_cmnd.h:12:0,
                  from drivers/misc/lkdtm/core.c:45:
./include/scsi/scsi_device.h:435:4: error: unknown type name 'req_flags_t'
     req_flags_t rq_flags, int *resid);
     ^
./include/scsi/scsi_device.h: In function 'scsi_execute_req':
./include/scsi/scsi_device.h:442:2: error: implicit declaration of 
function '__scsi_execute' [-Werror=implicit-function-declaration]
   __scsi_execute(sdev, cmd, data_direction, buffer, bufflen, \
   ^
./include/scsi/scsi_device.h:451:9: note: in expansion of macro 
'scsi_execute'
   return scsi_execute(sdev, cmd, data_direction, buffer,
          ^
In file included from ./include/scsi/scsi_request.h:5:0,
                  from ./include/scsi/scsi_cmnd.h:13,
                  from drivers/misc/lkdtm/core.c:45:
./include/linux/blk-mq.h: At top level:
./include/linux/blk-mq.h:100:9: error: type defaults to 'int' in 
declaration of 'blk_status_t' [-Werror=implicit-int]
  typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
          ^
./include/linux/blk-mq.h:100:9: error: 'blk_status_t' declared as 
function returning a function
./include/linux/blk-mq.h:101:16: warning: parameter names (without 
types) in function declaration
    const struct blk_mq_queue_data *);
                 ^
./include/linux/blk-mq.h:123:2: error: unknown type name 'queue_rq_fn'
   queue_rq_fn  *queue_rq;
   ^
./include/linux/blk-mq.h:144:2: error: unknown type name 'softirq_done_fn'
   softirq_done_fn  *complete;
   ^
./include/linux/blk-mq.h:223:31: error: 'blk_mq_req_flags_t' undeclared 
here (not in a function)
   BLK_MQ_REQ_NOWAIT = (__force blk_mq_req_flags_t)(1 << 0),
                                ^
./include/linux/blk-mq.h:233:3: error: expected declaration specifiers 
or '...' before 'blk_mq_req_flags_t'
    blk_mq_req_flags_t flags);
    ^
./include/linux/blk-mq.h:235:20: error: expected declaration specifiers 
or '...' before 'blk_mq_req_flags_t'
    unsigned int op, blk_mq_req_flags_t flags,
                     ^
In file included from ./arch/powerpc/include/asm/atomic.h:11:0,
                  from ./include/linux/atomic.h:7,
                  from ./include/linux/spinlock.h:436,
                  from ./include/linux/wait.h:9,
                  from ./include/linux/wait_bit.h:8,
                  from ./include/linux/fs.h:6,
                  from drivers/misc/lkdtm/core.c:34:
./include/linux/blk-mq.h: In function 'blk_mq_mark_complete':
./include/linux/blk-mq.h:306:20: error: dereferencing pointer to 
incomplete type 'struct request'
   return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
                     ^
./arch/powerpc/include/asm/cmpxchg.h:483:19: note: in definition of 
macro 'cmpxchg'
       __typeof__(*(ptr)) _o_ = (o);      \
                    ^
./include/linux/blk-mq.h:306:29: error: 'MQ_RQ_IN_FLIGHT' undeclared 
(first use in this function)
   return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
                              ^
./arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of 
macro 'cmpxchg'
       __typeof__(*(ptr)) _o_ = (o);      \
                                 ^
./include/linux/blk-mq.h:306:29: note: each undeclared identifier is 
reported only once for each function it appears in
   return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
                              ^
./arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of 
macro 'cmpxchg'
       __typeof__(*(ptr)) _o_ = (o);      \
                                 ^
./include/linux/blk-mq.h:306:46: error: 'MQ_RQ_COMPLETE' undeclared 
(first use in this function)
   return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
                                               ^
./arch/powerpc/include/asm/cmpxchg.h:484:32: note: in definition of 
macro 'cmpxchg'
       __typeof__(*(ptr)) _n_ = (n);      \
                                 ^
In file included from ./include/scsi/scsi_request.h:5:0,
                  from ./include/scsi/scsi_cmnd.h:13,
                  from drivers/misc/lkdtm/core.c:45:
./include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
./include/linux/blk-mq.h:316:22: error: invalid application of 'sizeof' 
to incomplete type 'struct request'
   return pdu - sizeof(struct request);
                       ^
./include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
./include/linux/blk-mq.h:320:2: error: invalid use of undefined type 
'struct request'
   return rq + 1;
   ^
In file included from drivers/misc/lkdtm/core.c:45:0:
./include/scsi/scsi_cmnd.h: In function 'scsi_bidi_cmnd':
./include/scsi/scsi_cmnd.h:214:9: error: implicit declaration of 
function 'blk_bidi_rq' [-Werror=implicit-function-declaration]
   return blk_bidi_rq(cmd->request) &&
          ^
./include/scsi/scsi_cmnd.h: In function 'scsi_get_lba':
./include/scsi/scsi_cmnd.h:307:9: error: implicit declaration of 
function 'blk_rq_pos' [-Werror=implicit-function-declaration]
   return blk_rq_pos(scmd->request);
          ^
cc1: some warnings being treated as errors
make[1]: *** [drivers/misc/lkdtm/core.o] Error 1
make: *** [drivers/misc/lkdtm/core.o] Error 2


> 
> And shouldn't you be depending on SCSI instead?

Yes maybe. I did make it depend on CONFIG_BLOCK because it was what it 
was depending on in the Kconfig. I'll send a v2

Christophe

> 
>> +
>>   #ifdef CONFIG_IDE
>>   #include <linux/ide.h>
>>   #endif
>> @@ -101,7 +104,9 @@ static struct crashpoint crashpoints[] = {
>>   	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
>>   	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
>>   	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
>> +# ifdef CONFIG_BLOCK
>>   	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
>> +# endif
> 
> Again, scsi?
> 
> thanks,
> 
> greg k-h
> 
