Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns8.sony.co.jp (NS8.Sony.CO.JP [137.153.0.33])
	by ozlabs.org (Postfix) with ESMTP id 7FBB767CCD
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 16:24:39 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kA85OZsa023955
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 14:24:35 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kA85OZdI023947
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 14:24:35 +0900 (JST)
Message-ID: <45516A0C.5050607@am.sony.com>
Date: Tue, 07 Nov 2006 21:24:28 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [PATCH] cell: abstract spu management routines
References: <455161D2.3090004@am.sony.com>
	<1162962074.20271.16.camel@localhost.localdomain>
In-Reply-To: <1162962074.20271.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>> +static struct platform_data *platform_data(struct spu *spu)
>> +{
>> +	BUG_ON(!spu->platform_data);
>> +	return (struct platform_data*)spu->platform_data;
>> +}
> 
> I don't see the point of this, why not just grab platform data directly?

Well, first, it does a check, and second, you can't just grab platform_data,
you need to always do the cast also. So then, is something like
'((struct platform_data*)spu->platform_data)->' preferred over
'platform_data(spu)->'?

-Geoff
