Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw4.sony.co.jp (MGW4.Sony.CO.JP [137.153.0.46])
	by ozlabs.org (Postfix) with ESMTP id 980A8DDEB9
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 11:32:09 +1000 (EST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8/Sony) with ESMTP id l871W8n1017225
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 10:32:08 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail2.sony.co.jp (R8/Sony) with SMTP id l871W8g6017221
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 10:32:08 +0900 (JST)
Message-ID: <46E0A9E8.3050701@am.sony.com>
Date: Thu, 06 Sep 2007 18:31:20 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 2/2] Cell: Wrap master run control bit
References: <46DD4783.9040103@am.sony.com> <200709050042.13926.arnd@arndb.de>
In-Reply-To: <200709050042.13926.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 04 September 2007, Geoff Levand wrote:
>> 
>> From: Masato Noguchi <Masato.Noguchi@jp.sony.com>
>> 
>> Add platform specific SPU run control routines.
>> 
>> The current spufs_run_spu() implementation uses the SPU master
>> run control bit (MFC_SR1[S]) to control SPE execution, but the
>> PS3 hypervisor does not support the use of this feature.  This
>> change adds run control wrapper routines.  The  bare metal
>> routines use the master run control bit, and the PS3 specific
>> routines use the priv2 run control register.
>> 
>> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Hmm, ok. Since I don't think we'll get to do the right solution
> (unmapping the ps registers on the ps3) that soon, doing this
> patch is at least better than the current situation where we
> end up with an oops every time we leave spu_run.
> 
> It would probably be good to mention the remaining problem
> with the current approach in the changelog and as a comment
> in the ps3 specific functions.

Ok, I did that.

>> @@ -178,6 +179,8 @@ struct spu_management_ops {
>>  	int (*enumerate_spus)(int (*fn)(void *data));
>>  	int (*create_spu)(struct spu *spu, void *data);
>>  	int (*destroy_spu)(struct spu *spu);
>> +	int (*enable_spu)(struct spu_context *ctx);
>> +	int (*disable_spu)(struct spu_context *ctx);
>>  	int (*init_affinity)(void);
>>  };
> 
> Also, I think you should make the return type of the callback
> 'void' since the result is not used anywhere.

Noguchi-san was hesitant to do this.  I also thought lets leave it
as is until we consider the unmapping support, as maybe a return
value might make sense.  Jeremy, if you think it better to return
void, please make the update.

-Geoff
